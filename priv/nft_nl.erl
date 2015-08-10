-module(nft_nl).

%% gen_server callbacks
-export([dump/0, dump/1]).

-include_lib("gen_netlink/include/netlink.hrl").

dump() ->
    dump([]).

dump(Opts) ->
    application:ensure_all_started(lager),
    lager:set_loglevel(lager_console_backend, debug),

    {ok, CtNl} = socket(netlink, raw, ?NETLINK_NETFILTER, Opts),
    ok = gen_socket:bind(CtNl, netlink:sockaddr_nl(netlink, 0, -1)),

    ok = gen_socket:setsockopt(CtNl, sol_socket, sndbuf, 32768),

    %% Set netlink receiver buffer to 16 MBytes, to avoid packet drops
    ok = netlink:rcvbufsiz(CtNl, 16 * 1024 * 1024),

    do_request(CtNl, {nftables,getgen,[request],0,0,{unspec,0,0,[]}}, fun nft/2, []),

    %% Tables = do_request(CtNl, {nftables,gettable,[match,root,request],0,0,{unspec,0,0,[]}}, fun nft_table/2, []),
    %% lager:info("Tables: ~p~n", [lager:pr(Tables, ?MODULE)]),

    %% Chains = do_request(CtNl, {nftables,getchain,[match,root,request],0,0,{unspec,0,0,[]}}, fun nft/2, []),
    %% lager:info("Chains: ~p~n", [lager:pr(Chains, ?MODULE)]),

    Rules  = do_request(CtNl, {nftables,getrule, [match,root,request],0,0,{unspec,0,0,[]}}, fun nft_rule/2, []),
    io:format("Rules: ~p~n",  [Rules]),
    io:format("Rules: ~p~n",  [convert_rules(Rules)]),

    ok.

%%%===================================================================
%%% Internal functions
%%%===================================================================

socket(Family, Type, Protocol, Opts) ->
    case proplists:get_value(netns, Opts) of
	undefined ->
	    gen_socket:socket(Family, Type, Protocol);
	NetNs ->
	    gen_socket:socketat(NetNs, Family, Type, Protocol)
    end.

do_request(Socket, Req, Cb, CbState) ->
    BinReq = netlink:nl_ct_enc(Req),
    gen_socket:send(Socket, BinReq),
    process_answer(Socket, Cb, CbState).

process_answer(Socket, Cb, CbState0) ->
    case gen_socket:recv(Socket, 16 * 1024 * 1024) of
	{ok, Data} ->
	    Msg = netlink:nl_ct_dec(Data),
	    case process_nl(false, Msg, Cb, CbState0) of
		{continue, CbState1} ->
		    process_answer(Socket, Cb, CbState1);
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

nft(Msg, Acc) ->
    [Msg|Acc].

nft_table(#nftables{msg = {Family, _Version, _ResId, NLA} = Msg}, Acc) ->
    Table = {Family, proplists:get_value(name, NLA), proplists:get_value(use, NLA)},
    [Table|Acc];
nft_table(Msg, Acc) ->
    lager:error("unknown nft table msg: ~p~n", [lager:pr(Msg, ?MODULE)]),
    Acc.

nft_rule(#nftables{msg = {Family, Version, ResId, NLA0}}, Acc) ->
    NLA1 = lists:map(fun({expressions, Expr0}) ->
			     Expr1 = lists:map(fun(Expr) -> netlink:nft_decode(Family, Expr) end, Expr0),
			     {expressions, Expr1};
			(NLA) -> NLA
		     end, NLA0),
    Msg = {Family, Version, ResId, NLA1},
    [Msg|Acc];
nft_rule(Msg, Acc) ->
    lager:error("unknown nft rule msg: ~p~n", [lager:pr(Msg, ?MODULE)]),
    Acc.

convert_rules(Rules) ->
    convert_rules(Rules, #{}).

convert_rules([], RuleSet) ->
    RuleSet;
convert_rules([{Family, _, _, Rule}|Next], RuleSet) ->
    {Table, Chain, Handle, Expressions} = decode_rule(Rule, {undefined, undefined, undefined, undefined}),
    RulesObj = maps:get(Family, RuleSet, #{}),
    TableObj = maps:get(Table, RulesObj, #{}),
    ChainObj = maps:get(Chain, TableObj, []),

    NewChainObj = [{Handle, Expressions}|ChainObj],
    NewTableObj = TableObj#{Chain => NewChainObj},
    NewRulesObj = RulesObj#{Table => NewTableObj},
    NewRuleSet  = RuleSet#{Family => NewRulesObj},
    convert_rules(Next, NewRuleSet).


decode_rule([], Rule) ->
    Rule;
decode_rule([{table, Value}|Next], Rule) ->
    decode_rule(Next, setelement(1, Rule, Value));
decode_rule([{chain, Value}|Next], Rule) ->
    decode_rule(Next, setelement(2, Rule, Value));
decode_rule([{handle, Value}|Next], Rule) ->
    decode_rule(Next, setelement(3, Rule, Value));
decode_rule([{expressions, Value}|Next], Rule) ->
    decode_rule(Next, setelement(4, Rule, Value));
decode_rule([_|Next], Rule) ->
    decode_rule(Next, Rule).
