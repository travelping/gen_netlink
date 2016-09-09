%% This Source Code Form is subject to the terms of the Mozilla Public
%% License, v. 2.0. If a copy of the MPL was not distributed with this
%% file, You can obtain one at http://mozilla.org/MPL/2.0/.

%% Copyright 2016, Travelping GmbH <info@travelping.com>

%% helper process that can be used by an application to handle the
%% typical receive and send function of a netlink socket.

-module(netlink_socket).

-behavior(gen_server).

%% API

-export([start_link/2, start_link/3, stop/1, request/2]).

%% gen_server callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
	 terminate/2, code_change/3]).

%%-include_lib("kernel/include/file.hrl").
-include_lib("gen_netlink/include/netlink.hrl").

-record(state, {owner, socket, protocol, requests}).

%%====================================================================
%% API
%%====================================================================

start_link(Socket, Protocol) ->
    start_link(self(), Socket, Protocol).

start_link(Owner, Socket, Protocol) ->
    gen_server:start_link(?MODULE, [Owner, Socket, Protocol], []).

stop(Server) ->
    gen_server:call(Server, stop).

request(Server, Request) ->
    gen_server:call(Server, {request, Request}).

%%%===================================================================
%%% gen_server callbacks
%%%===================================================================

init([Owner, Socket, Protocol]) ->
    process_flag(trap_exit, true),

    gen_socket:controlling_process(Socket, self()),
    ok = gen_socket:input_event(Socket, true),
    State = #state{
	       owner = Owner,
	       socket = Socket,
	       protocol = Protocol,
	       requests = gb_trees:empty()
	      },
    {ok, State}.

handle_call(stop, _From, State) ->
    {stop, normal, State};

handle_call({request, #rtnetlink{flags = Flags, seq = Seq} = Request}, From, State) ->
    request(Seq, Flags, Request, From, State);
handle_call({request, #netlink{flags = Flags, seq = Seq} = Request}, From, State) ->
    request(Seq, Flags, Request, From, State).

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info({Socket, input_ready}, #state{socket = Socket, protocol = Protocol} = State0) ->
    Msgs = process_answer(Socket, Protocol, fun nl/2, []),
    State = lists:foldl(fun handle_msgs/2, State0, Msgs),
    ok = gen_socket:input_event(Socket, true),
    {noreply, State};

handle_info({'EXIT', From, _Reason}, #state{owner = From} = State) ->
    {stop, normal, State};
handle_info({timeout, Seq}, State0) ->
    State = reply(Seq, {error, {timeout, Seq}}, State0),
    {noreply, State}.

terminate(_Reason, #state{owner = Owner, socket = Socket}) ->
    gen_socket:controlling_process(Socket, Owner),
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

%%--------------------------------------------------------------------
%%% Internal functions
%%--------------------------------------------------------------------

reply(Seq, Msg, State0) ->
    {Result, State} = dequeue_request(Seq, State0),
    case Result of
	{ok, From} ->
	    gen_server:reply(From, Msg);
	_ ->
	    ok
    end,
    State.

cancel_timer(Ref) ->
    case erlang:cancel_timer(Ref) of
        false ->
            receive {timeout, Ref, _} -> 0
            after 0 -> false
            end;
        RemainingTime ->
            RemainingTime
    end.

enqueue_request(Seq, From, #state{requests = Requests} = State) ->
    TRef = erlang:send_after(5000, self(), {timeout, Seq}),
    State#state{requests = gb_trees:enter(Seq, {From, TRef}, Requests)}.

dequeue_request(Seq, #state{requests = Requests} = State) ->
    case gb_trees:lookup(Seq, Requests) of
	{value, {From, TRef}} ->
	    cancel_timer(TRef),
	    {{ok, From}, State#state{requests = gb_trees:delete(Seq, Requests)}};
	_ ->
	    {not_found, State}
    end.

do_request(Socket, Protocol, Request) ->
    BinReq = netlink:nl_enc(Protocol, Request),
    gen_socket:send(Socket, BinReq).

request(Seq, Flags, Request, From,
	    #state{socket = Socket, protocol = Protocol} = State0) ->
    case proplists:get_bool(ack, Flags) of
	true ->
	    State = enqueue_request(Seq, From, State0),
	    do_request(Socket, Protocol, Request),
	    {noreply, State};
	_ ->
	    do_request(Socket, Protocol, Request),
	    {reply, ok, State0}
    end.

process_answer(Socket, Protocol, Cb, CbState0) ->
    case gen_socket:recv(Socket, 16 * 1024 * 1024) of
        {ok, Data} ->
            Msg = netlink:nl_dec(Protocol, Data),
            case process_nl(false, Msg, Cb, CbState0) of
                {continue, CbState1} ->
                    process_answer(Socket, Protocol, Cb, CbState1);
                CbState1 ->
                    CbState1
            end;
        Other ->
            io:format("Other: ~p~n", [Other]),
            Other
    end.

process_nl(true, [], _Cb, CbState) ->
    {continue, CbState};
process_nl(_, [], _Cb, CbState) ->
    CbState;
process_nl(_Multi, [#netlink{type = done}], _Cb, CbState) ->
    CbState;
process_nl(_Multi, [Head|Rest], Cb, CbState0) ->
    CbState1 = Cb(Head, CbState0),
    Flags = element(3, Head),
    process_nl(lists:member(multi, Flags), Rest, Cb, CbState1).

nl(Msg, Acc) ->
    [Msg|Acc].

handle_msgs(#netlink{type = error, seq = Seq, msg = {Code, _}}, State)
  when Seq /= 0 ->
    Reply = if Code == 0 -> ok;
	       true      -> {error, Code}
	    end,
    reply(Seq, Reply, State);

handle_msgs(#rtnetlink{type = error, seq = Seq, msg = {Code, _}}, State)
  when Seq /= 0 ->
    Reply = if Code == 0 -> ok;
	       true      -> {error, Code}
	    end,
    reply(Seq, Reply, State);

handle_msgs(Msg, #state{owner = Owner, socket = Socket,
			protocol = Protocol} = State) ->
    Owner ! {netlink, Socket, Protocol, Msg},
    State.
