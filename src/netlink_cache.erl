%%    __                        __      _
%%   / /__________ __   _____  / /___  (_)___  ____ _
%%  / __/ ___/ __ `/ | / / _ \/ / __ \/ / __ \/ __ `/
%% / /_/ /  / /_/ /| |/ /  __/ / /_/ / / / / / /_/ /
%% \__/_/   \__,_/ |___/\___/_/ .___/_/_/ /_/\__, /
%%                           /_/            /____/
%%
%% Copyright (c) Travelping GmbH <info@travelping.com>

%% @author       Andreas Schultz <aschultz@tpip.net>
%% @copyright    2013 Travelping GmbH
%%
-module(netlink_cache).

-behaviour(gen_server).

%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------
-include("include/netlink.hrl").

%% API
-export([start/0, start/2, start/3,
	 start_link/0, start_link/2, start_link/3,
	 stop/0, stop/1]).
-export([get_cache_handle/0, get_cache_handle/1]).

%% gen_server callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
		 terminate/2, code_change/3]).
-export([all/2, lookup/3]).

-define(SERVER, ?MODULE).
-define(TABLE_NEIGH, netlink_cache_neigh).
-define(TABLE_ROUTE, netlink_cache_route).

-record(cache_handle, {
	  neighbour_table,
	  route_table
	 }).

-record(state, {
	  neighbour_table,
	  route_table
	 }).

%%%===================================================================
%%% API
%%%===================================================================

start() ->
    Args = [{neighbour_table, ?TABLE_NEIGH}, {route_table, ?TABLE_ROUTE}],
    start({local, ?SERVER}, Args, []).

start(Args, Options) ->
    gen_server:start(?MODULE, Args, Options).

start(ServerName, Args, Options) ->
    gen_server:start(ServerName, ?MODULE, Args, Options).

start_link() ->
    Args = [{neighbour_table, ?TABLE_NEIGH}, {route_table, ?TABLE_ROUTE}],
    gen_server:start_link({local, ?SERVER}, ?MODULE, Args, []).

start_link(Args, Options) ->
    gen_server:start_link(?MODULE, Args, Options).

start_link(ServerName, Args, Options) ->
    gen_server:start_link(ServerName, ?MODULE, Args, Options).

stop() ->
    stop(?SERVER).

stop(ServerName) ->
    gen_server:cast(ServerName, stop).

all(CacheHandle, Table) ->
    ets:tab2list(get_table(CacheHandle, Table)).

lookup(Key, CacheHandle, Table) ->
    ets:lookup(get_table(CacheHandle, Table), Key).

get_cache_handle() ->
    get_cache_handle(?MODULE).

get_cache_handle(Server) ->
    gen_server:call(Server, get_cache_handle).

%%%===================================================================
%%% gen_server callbacks
%%%===================================================================

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Initializes the server
%%
%% @spec init(Args) -> {ok, State} |
%%                     {ok, State, Timeout} |
%%                     ignore |
%%                     {stop, Reason}
%% @end
%%--------------------------------------------------------------------
init(Options) ->
    lager:debug("Options: ~p~n", [Options]),
    NeighbourTable = new_table([ordered_set, protected, {keypos, #neighbour_cache_entry.key}], neighbour_table, Options),
    RouteTable = new_table([ordered_set, protected, {keypos, #route_cache_entry.key}], route_table, Options),

    Netlink = case proplists:get_value(netlink, Options) of
		  undefined ->
		      netlink;
		  Id when is_pid(Id); is_atom(Id) ->
		      Id
	      end,
    netlink:subscribe(Netlink, self(), [rt]),

    NeighReq = #rtnetlink{type = getneigh, flags = [match,root,request],
			    seq = 1, pid = 0, msg = {unspec,0,0,0,0,[]}},
    netlink:send(Netlink, rt, netlink:nl_rt_enc(NeighReq)),

    RouteReq = #rtnetlink{type = getroute, flags = [match,root,request],
			  seq =  2 ,pid = 0,
			  msg = {inet,0,0,0,8,unspec,29,unspec,[],[]}},
    netlink:send(Netlink, rt, netlink:nl_rt_enc(RouteReq)),

    {ok, #state{neighbour_table = NeighbourTable, route_table = RouteTable}}.

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Handling call messages
%%
%% @spec handle_call(Request, From, State) ->
%%                                   {reply, Reply, State} |
%%                                   {reply, Reply, State, Timeout} |
%%                                   {noreply, State} |
%%                                   {noreply, State, Timeout} |
%%                                   {stop, Reason, Reply, State} |
%%                                   {stop, Reason, State}
%% @end
%%--------------------------------------------------------------------

handle_call(get_cache_handle, _From, State) ->
    {reply, state_to_handle(State), State};

handle_call(Request, _From, State) ->
    lager:warning("unhandled call: ~p", [Request]),
    {reply, ok, State}.

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Handling cast messages
%%
%% @spec handle_cast(Msg, State) -> {noreply, State} |
%%                                  {noreply, State, Timeout} |
%%                                  {stop, Reason, State}
%% @end
%%--------------------------------------------------------------------
handle_cast(Msg, State) ->
    lager:warning("unhandled cast: ~p", [Msg]),
    {noreply, State}.

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Handling all non call/cast messages
%%
%% @spec handle_info(Info, State) -> {noreply, State} |
%%                                   {noreply, State, Timeout} |
%%                                   {stop, Reason, State}
%% @end
%%--------------------------------------------------------------------
handle_info({rtnetlink, Infos}, State0) ->
    State = handle_rtnetlink(Infos, State0),
    {noreply, State};
handle_info(Info, State) ->
    lager:warning("unhandled info: ~p", [Info]),
    {noreply, State}.

%%--------------------------------------------------------------------
%% @private
%% @doc
%% This function is called by a gen_server when it is about to
%% terminate. It should be the opposite of Module:init/1 and do any
%% necessary cleaning up. When it returns, the gen_server terminates
%% with Reason. The return value is ignored.
%%
%% @spec terminate(Reason, State) -> void()
%% @end
%%--------------------------------------------------------------------
terminate(_Reason, _State) ->
	ok.

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Convert process state when code is changed
%%
%% @spec code_change(OldVsn, State, Extra) -> {ok, NewState}
%% @end
%%--------------------------------------------------------------------
code_change(_OldVsn, State, _Extra) ->
	{ok, State}.

%%%===================================================================
%%% Internal functions
%%%===================================================================

new_table(ETSOpts, NameKey, Options) ->
    case proplists:get_value(NameKey, Options, undefined) of
	undefined ->
	    ets:new(NameKey, ETSOpts);
	Name ->
	    ets:new(Name, [named_table|ETSOpts])
    end.

state_to_handle(#state{neighbour_table = NeighbourTable, route_table = RouteTable}) ->
    #cache_handle{neighbour_table = NeighbourTable, route_table = RouteTable}.


get_table(#cache_handle{neighbour_table = NeighbourTable}, neighbour_table) ->
    NeighbourTable;
get_table(#cache_handle{route_table = RouteTable}, route_table) ->
    RouteTable.

handle_rtnetlink([], State) ->
    State;
handle_rtnetlink([Info|Next], State0) ->
    State = handle_rtnetlink2(Info, State0),
    handle_rtnetlink(Next, State).

handle_rtnetlink2(#rtnetlink{msg = {_Family, _IfIndex, NUDState, _Flags, _NdmType, _Req}}, State)
  when (NUDState band ?NUD_NOARP) /= 0 ->
    State;

handle_rtnetlink2(#rtnetlink{type = newneigh, msg = {_Family, IfIndex, _NUDState, _Flags, _NdmType, Req}}, State) ->
    Dst = proplists:get_value(dst, Req),
    Object = #neighbour_cache_entry{key = {IfIndex, Dst},
				    if_index = IfIndex,
				    dst = Dst,
				    lladdr = proplists:get_value(lladdr, Req)},
    ets:insert(State#state.neighbour_table, Object),
    State;

handle_rtnetlink2(#rtnetlink{type = delneigh, msg = {_Family, IfIndex, _NUDState, _Flags, _NdmType, Req}}, State) ->
    Dst = proplists:get_value(dst, Req),
    Key = {IfIndex, Dst},
    ets:delete(State#state.neighbour_table, Key),
    State;

handle_rtnetlink2(#rtnetlink{type = newroute, msg = {_Family, DstLen, _SrcLen, _Tos, _Table, _Protocol, _Scope, unicast, _Flags, Req}}, State) ->
    Dst = proplists:get_value(dst, Req, {0,0,0,0}),
    Key = {Dst, DstLen},
    Object = #route_cache_entry{
		key      = Key,
		dst      = Dst,
		dst_len  = DstLen,
		table    = proplists:get_value(table, Req),
		gateway  = proplists:get_value(gateway, Req),
		oif      = proplists:get_value(oif, Req)},
    ets:insert(State#state.route_table, Object),
    State;

handle_rtnetlink2(#rtnetlink{type = delroute, msg = {_Family, DstLen, _SrcLen, _Tos, _Table, _Protocol, _Scope, unicast, _Flags, Req}}, State) ->
    Dst = proplists:get_value(dst, Req, {0,0,0,0}),
    Key = {Dst, DstLen},
    ets:delete(State#state.route_table, Key),
    State;

handle_rtnetlink2(Info, State) ->
    State.


