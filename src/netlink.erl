-module(netlink).

-export([start/0, nl_ct_dec/1, dec_netlink/2, create_table/0, gen_const/1, define_consts/0]).

-include("gen_socket.hrl").

-define(TAB, ?MODULE).

%% netlink event sources
-define(NETLINK_ROUTE, 0).
-define(NETLINK_UNUSED, 1).
-define(NETLINK_USERSOCK, 2).
-define(NETLINK_FIREWALL, 3).
-define(NETLINK_INET_DIAG, 4).
-define(NETLINK_NFLOG, 5).
-define(NETLINK_XFRM, 6).
-define(NETLINK_SELINUX, 7).
-define(NETLINK_ISCSI, 8).
-define(NETLINK_AUDIT, 9).
-define(NETLINK_FIB_LOOKUP, 10).
-define(NETLINK_CONNECTOR, 11).
-define(NETLINK_NETFILTER, 12).
-define(NETLINK_IP6_FW, 13).
-define(NETLINK_DNRTMSG, 14).
-define(NETLINK_KOBJECT_UEVENT, 15).
-define(NETLINK_GENERIC, 16).
-define(NETLINK_SCSITRANSPORT, 18).
-define(NETLINK_ECRYPTFS, 19).

%% netlink info
-define(NETLINK_ADD_MEMBERSHIP, 1).
-define(NETLINK_DROP_MEMBERSHIP, 2).
-define(NETLINK_PKTINFO, 3).
-define(NETLINK_BROADCAST_ERROR, 4).
-define(NETLINK_NO_ENOBUFS, 5).

-define(SOL_NETLINK, 270).

-define(NFNLGRP_NONE, 0).
-define(NFNLGRP_CONNTRACK_NEW, 1).
-define(NFNLGRP_CONNTRACK_UPDATE, 2).
-define(NFNLGRP_CONNTRACK_DESTROY, 3).
-define(NFNLGRP_CONNTRACK_EXP_NEW, 4).
-define(NFNLGRP_CONNTRACK_EXP_UPDATE, 5).
-define(NFNLGRP_CONNTRACK_EXP_DESTROY, 6).

%%
%% grep define src/netlink.erl | awk -F"[(,]" '{ printf "enc_opt(%s)%*s ?%s;\n", tolower($2), 32 - length($2), "->", $2 }'
%%
enc_opt(netlink_route)                 -> ?NETLINK_ROUTE;
enc_opt(netlink_unused)                -> ?NETLINK_UNUSED;
enc_opt(netlink_usersock)              -> ?NETLINK_USERSOCK;
enc_opt(netlink_firewall)              -> ?NETLINK_FIREWALL;
enc_opt(netlink_inet_diag)             -> ?NETLINK_INET_DIAG;
enc_opt(netlink_nflog)                 -> ?NETLINK_NFLOG;
enc_opt(netlink_xfrm)                  -> ?NETLINK_XFRM;
enc_opt(netlink_selinux)               -> ?NETLINK_SELINUX;
enc_opt(netlink_iscsi)                 -> ?NETLINK_ISCSI;
enc_opt(netlink_audit)                 -> ?NETLINK_AUDIT;
enc_opt(netlink_fib_lookup)            -> ?NETLINK_FIB_LOOKUP;
enc_opt(netlink_connector)             -> ?NETLINK_CONNECTOR;
enc_opt(netlink_netfilter)             -> ?NETLINK_NETFILTER;
enc_opt(netlink_ip6_fw)                -> ?NETLINK_IP6_FW;
enc_opt(netlink_dnrtmsg)               -> ?NETLINK_DNRTMSG;
enc_opt(netlink_kobject_uevent)        -> ?NETLINK_KOBJECT_UEVENT;
enc_opt(netlink_generic)               -> ?NETLINK_GENERIC;
enc_opt(netlink_scsitransport)         -> ?NETLINK_SCSITRANSPORT;
enc_opt(netlink_ecryptfs)              -> ?NETLINK_ECRYPTFS;
enc_opt(netlink_add_membership)        -> ?NETLINK_ADD_MEMBERSHIP;
enc_opt(netlink_drop_membership)       -> ?NETLINK_DROP_MEMBERSHIP;
enc_opt(netlink_pktinfo)               -> ?NETLINK_PKTINFO;
enc_opt(netlink_broadcast_error)       -> ?NETLINK_BROADCAST_ERROR;
enc_opt(netlink_no_enobufs)            -> ?NETLINK_NO_ENOBUFS;
enc_opt(sol_netlink)                   -> ?SOL_NETLINK;
enc_opt(nfnlgrp_none)                  -> ?NFNLGRP_NONE;
enc_opt(nfnlgrp_conntrack_new)         -> ?NFNLGRP_CONNTRACK_NEW;
enc_opt(nfnlgrp_conntrack_update)      -> ?NFNLGRP_CONNTRACK_UPDATE;
enc_opt(nfnlgrp_conntrack_destroy)     -> ?NFNLGRP_CONNTRACK_DESTROY;
enc_opt(nfnlgrp_conntrack_exp_new)     -> ?NFNLGRP_CONNTRACK_EXP_NEW;
enc_opt(nfnlgrp_conntrack_exp_update)  -> ?NFNLGRP_CONNTRACK_EXP_UPDATE;
enc_opt(nfnlgrp_conntrack_exp_destroy) -> ?NFNLGRP_CONNTRACK_EXP_DESTROY.

%%
%% grep define src/netlink.erl | awk -F"[(,]" '{ printf "dec_opt(?%s)%*s %s;\n", $2, 32 - length($2), "->", tolower($2) }'
%%
%% dec_opt(?NETLINK_ROUTE)                 -> netlink_route;
%% dec_opt(?NETLINK_UNUSED)                -> netlink_unused;
%% dec_opt(?NETLINK_USERSOCK)              -> netlink_usersock;
%% dec_opt(?NETLINK_FIREWALL)              -> netlink_firewall;
%% dec_opt(?NETLINK_INET_DIAG)             -> netlink_inet_diag;
%% dec_opt(?NETLINK_NFLOG)                 -> netlink_nflog;
%% dec_opt(?NETLINK_XFRM)                  -> netlink_xfrm;
%% dec_opt(?NETLINK_SELINUX)               -> netlink_selinux;
%% dec_opt(?NETLINK_ISCSI)                 -> netlink_iscsi;
%% dec_opt(?NETLINK_AUDIT)                 -> netlink_audit;
%% dec_opt(?NETLINK_FIB_LOOKUP)            -> netlink_fib_lookup;
%% dec_opt(?NETLINK_CONNECTOR)             -> netlink_connector;
%% dec_opt(?NETLINK_NETFILTER)             -> netlink_netfilter;
%% dec_opt(?NETLINK_IP6_FW)                -> netlink_ip6_fw;
%% dec_opt(?NETLINK_DNRTMSG)               -> netlink_dnrtmsg;
%% dec_opt(?NETLINK_KOBJECT_UEVENT)        -> netlink_kobject_uevent;
%% dec_opt(?NETLINK_GENERIC)               -> netlink_generic;
%% dec_opt(?NETLINK_SCSITRANSPORT)         -> netlink_scsitransport;
%% dec_opt(?NETLINK_ECRYPTFS)              -> netlink_ecryptfs;
%% dec_opt(?NETLINK_ADD_MEMBERSHIP)        -> netlink_add_membership;
%% dec_opt(?NETLINK_DROP_MEMBERSHIP)       -> netlink_drop_membership;
%% dec_opt(?NETLINK_PKTINFO)               -> netlink_pktinfo;
%% dec_opt(?NETLINK_BROADCAST_ERROR)       -> netlink_broadcast_error;
%% dec_opt(?NETLINK_NO_ENOBUFS)            -> netlink_no_enobufs;
%% dec_opt(?SOL_NETLINK)                   -> sol_netlink;
%% dec_opt(?NFNLGRP_NONE)                  -> nfnlgrp_none;
%% dec_opt(?NFNLGRP_CONNTRACK_NEW)         -> nfnlgrp_conntrack_new;
%% dec_opt(?NFNLGRP_CONNTRACK_UPDATE)      -> nfnlgrp_conntrack_update;
%% dec_opt(?NFNLGRP_CONNTRACK_DESTROY)     -> nfnlgrp_conntrack_destroy;
%% dec_opt(?NFNLGRP_CONNTRACK_EXP_NEW)     -> nfnlgrp_conntrack_exp_new;
%% dec_opt(?NFNLGRP_CONNTRACK_EXP_UPDATE)  -> nfnlgrp_conntrack_exp_update;
%% dec_opt(?NFNLGRP_CONNTRACK_EXP_DESTROY) -> nfnlgrp_conntrack_exp_destroy.

-define(NFNL_SUBSYS_NONE,0).
-define(NFNL_SUBSYS_CTNETLINK,1).
-define(NFNL_SUBSYS_CTNETLINK_EXP,2).
-define(NFNL_SUBSYS_QUEUE,3).
-define(NFNL_SUBSYS_ULOG,4).
-define(NFNL_SUBSYS_COUNT,5).

%% grep "^-define(NFNL_SUB" src/netlink.erl | awk -F"[(,]" '{ printf "dec_nfnl_subsys(?%s)%*s %s;\n", $2, 32 - length($2), "->", tolower(substr($2,13)) }'
dec_nfnl_subsys(?NFNL_SUBSYS_NONE)              -> none;
dec_nfnl_subsys(?NFNL_SUBSYS_CTNETLINK)         -> ctnetlink;
dec_nfnl_subsys(?NFNL_SUBSYS_CTNETLINK_EXP)     -> ctnetlink_exp;
dec_nfnl_subsys(?NFNL_SUBSYS_QUEUE)             -> queue;
dec_nfnl_subsys(?NFNL_SUBSYS_ULOG)              -> ulog;
dec_nfnl_subsys(?NFNL_SUBSYS_COUNT)             -> count;
dec_nfnl_subsys(SubSys) when is_integer(SubSys) -> SubSys.


create_table() ->
    ets:new(?TAB, [named_table, public]).

emit_enum(Type, Cnt, [{C, DType}|T]) ->
    ets:insert(?TAB, {{Type, Cnt}, C, DType}),
    ets:insert(?TAB, {{Type, C}, Cnt, DType}),
    emit_enum(Type, Cnt + 1, T);
emit_enum(_, _, []) ->
    ok.

gen_const([{Type, Consts}|T]) ->
    io:format("insert: ~p ~p~n", [Type, Consts]),
    emit_enum(Type, 0, Consts),
    gen_const(T);
gen_const([]) ->
    ok.

define_consts() ->
    [{{ctnetlink}, [
                    {unspec, none},
                    {tuple_orig, tuple},
                    {tuple_reply, tuple},
                    {status, flag},
                    {protoinfo, protoinfo},
                    {help, none},
                    {nat_src, none},
                    {timeout, uint32},
                    {mark, uint32},
                    {counters_orig, none},
                    {counters_reply, none},
                    {use, none},
                    {id, uint32},
                    {nat_dst, none},
                    {tuple_master, nested},
                    {nat_seq_adj_orig, none},
                    {nat_seq_adj_reply, none},
                    {secmark, uint32}
                 ]},
     {{ctnetlink, status}, [
                            {expected, flag},
                            {seen_reply, flag},
                            {assured, flag},
                            {confirmed, flag},
                            {src_nat, flag},
                            {dst_nat, flag},
                            {seq_adjust, flag},
                            {src_nat_done, flag},
                            {dst_nat_done, flag},
                            {dying, flag},
                            {fixed_timeout, flag}
                          ]},
     {{ctnetlink, tuple}, [
                {unspec, none},
                {ip, ip},
                {proto, proto}
               ]},
     {{ctnetlink, tuple, ip}, [
                               {unspec, none},
                               {v4_src, inet},
                               {v4_dst, inet},
                               {v6_src, inet6},
                               {v6_dst, inet6}
                              ]},
     {{ctnetlink, tuple, proto}, [
                                  {unspec, none},
                                  {num, protocol},
                                  {src_port, uint16},
                                  {dst_port, uint16},
                                  {icmp_id, none},
                                  {icmp_type, none},
                                  {icmp_code, none},
                                  {icmpv6_id, none},
                                  {icmpv6_type, none},
                                  {icmpv6_code, none}
                              ]},
     {{ctnetlink, protoinfo}, [
                               {unspec, none},
                               {tcp, tcp},
                               {dccp, dccp},
                               {sctp, sctp}
                              ]},

     {{ctnetlink, protoinfo, tcp}, [
                                    {unspec, none},
                                    {state, atom},
                                    {wscale_original, uint8},
                                    {wscale_reply, uint8},
                                    {flags_original, uint16},
                                    {flags_reply, uint16}
                                   ]},

     {{ctnetlink, protoinfo, tcp, state}, [
                                           {none, atom},
                                           {syn_sent, atom},
                                           {syn_recv, atom},
                                           {established, atom},
                                           {fin_wait, atom},
                                           {close_wait, atom},
                                           {last_ack, atom},
                                           {time_wait, atom},
                                           {close, atom},
                                           {listen, atom},
                                           {max, atom},
                                           {ignore, atom}
                                          ]}
    ].

dec_netlink(Type, Attr) ->
    case ets:lookup(?TAB, {Type, Attr}) of
        [{_, Id, DType}] -> {Id, DType};
        _ -> {none, none}
    end.

sockaddr_nl(Family, Pid, Groups) ->
    sockaddr_nl({Family, Pid, Groups}).

sockaddr_nl({Family, Pid, Groups}) when is_atom(Family) ->
    sockaddr_nl({gen_socket:family(Family), Pid, Groups});
sockaddr_nl({Family, Pid, Groups}) ->
    << Family:8, 0:8, Pid:32, Groups:32 >>;
sockaddr_nl(<< Family:8, _Pad:8, Pid:32, Groups:32 >> = Bin) when is_binary(Bin) ->
    {gen_socket:family(Family), Pid, Groups}.

setsockoption(Socket, Level, OptName, Val) when is_atom(Level) ->
    setsockoption(Socket, enc_opt(Level), OptName, Val);
setsockoption(Socket, Level, OptName, Val) when is_atom(OptName) ->
    setsockoption(Socket, Level, enc_opt(OptName), Val);
setsockoption(Socket, Level, OptName, Val) when is_atom(Val) ->
    setsockoption(Socket, Level, OptName, enc_opt(Val));
setsockoption(Socket, Level, OptName, Val) when is_integer(Val) ->
    gen_socket:setsockoption(Socket, Level, OptName, Val).

start() ->
    {ok, Socket} = gen_socket:socket(netlink, raw, ?NETLINK_NETFILTER),
    ok = gen_socket:bind(Socket, sockaddr_nl(netlink, 0, -1)),

    ok = gen_socket:setsockoption(Socket, sol_socket, so_sndbuf, 32768),
    ok = gen_socket:setsockoption(Socket, sol_socket, so_rcvbuf, 32768),

    ok = setsockoption(Socket, sol_netlink, netlink_add_membership, nfnlgrp_conntrack_new),
    ok = setsockoption(Socket, sol_netlink, netlink_add_membership, nfnlgrp_conntrack_update),
    ok = setsockoption(Socket, sol_netlink, netlink_add_membership, nfnlgrp_conntrack_destroy),

    %% UDP is close enough (connection less, datagram oriented), so we can use the driver from it
    {ok, _S} = gen_udp:open(0, [binary, {fd, Socket}]),

    loop(Socket).

dec_flag(Type, << F:1/bits, R/bits >>, Cnt, Acc) ->
    case F of
        <<1:1>> -> {Flag, _} = dec_netlink(Type, Cnt),
                   dec_flag(Type, R, Cnt - 1, [Flag | Acc]);
        _ -> dec_flag(Type, R, Cnt - 1, Acc)
    end;
dec_flag(_Type, << >>, _Cnt, Acc) ->
    Acc.
                     
nl_dec_nl_attr(Type, Attr, flag, false, << Val/binary >>) ->
    {Attr, dec_flag(Type, Val, bit_size(Val) - 1, [])};
nl_dec_nl_attr(Type, Attr, atom, false, << Val:8 >>) ->
    {Atom, _} = dec_netlink(Type, Val),
    {Attr, Atom};
nl_dec_nl_attr(_Type, Attr, uint8, false, << Val:8 >>) ->
    {Attr, Val};
nl_dec_nl_attr(_Type, Attr, uint16, false, << Val:16 >>) ->
    {Attr, Val};
nl_dec_nl_attr(_Type, Attr, uint32, false, << Val:32 >>) ->
    {Attr, Val};
nl_dec_nl_attr(_Type, Attr, protocol, false, << Proto:8 >>) ->
    {Attr,  gen_socket:protocol(Proto)};
nl_dec_nl_attr(_Type, Attr, inet, false, << A:8, B:8, C:8, D:8 >>) ->
    {Attr, {A, B, C, D}};
nl_dec_nl_attr(_Type, Attr, inet6, false, <<A:16, B:16, C:16, D:16, E:16, F:16, G:16, H:16>>) ->
    {Attr, {A,B,C,D,E,F,G,H}};
nl_dec_nl_attr(Type, Attr, _NestedType, true, Data) ->
    { Attr, nl_dec_nla(Type, Data) };
nl_dec_nl_attr(Type, Attr, DType, _NestedType, Data) ->
    io:format("nl_dec_nl_attr (wildcard): ~p ~p ~p~n", [Type, Attr, DType]),
    {Type, Data}.

pad_len(Block, Size) ->
    (Block - (Size rem Block)) rem Block.

nl_dec_nla(Type0, << Len:16/native-integer, NlaType:16/native-integer, Rest/binary >>, Acc) ->
    PLen = Len - 4,
    Padding = pad_len(4, PLen),
    << Data:PLen/bytes, _Pad:Padding/bytes, NewRest/binary >> = Rest,

    Nested = (NlaType band 16#8000) /= 0,
    {NewAttr, DType} = dec_netlink(Type0, NlaType band 16#7FFF),
    NewType = case Nested of
                  true  -> erlang:append_element(Type0, DType);
                  false -> erlang:append_element(Type0, NewAttr)
              end,
    H = nl_dec_nl_attr(NewType, NewAttr, DType, Nested, Data),

    nl_dec_nla(Type0, NewRest, [H | Acc]);

nl_dec_nla(_Type, << >>, Acc) ->
    Acc.

nl_dec_nla(Type, Data) ->
    nl_dec_nla(Type, Data, []).

nl_dec_payload({ctnetlink} = Type, << Family:8, Version:8, ResId:16/native-integer, Data/binary >>) ->
    { gen_socket:family(Family), Version, ResId, nl_dec_nla(Type, Data) };

nl_dec_payload(_SubSys, Data) ->
    Data.

nlmsg_ok(DataLen, MsgLen) ->
    (DataLen >= 16) and (MsgLen >= 16) and (MsgLen =< DataLen).

nl_ct_dec(<< _IpHdr:5/bytes, Len:32/native-integer, Type:16/native-integer, Flags:16/native-integer, Seq:32/native-integer, Pid:32/native-integer, Data/binary >> = Msg) ->
    case nlmsg_ok(size(Msg) - 5, Len) of
        true -> 
            SubSys = dec_nfnl_subsys(Type bsr 8),
            MsgType = Type band 16#00FF,
            { SubSys, MsgType, Flags, Seq, Pid, nl_dec_payload({SubSys}, Data) };
        _ ->
            { error, format }
    end.

% Echo back whatever data we receive on Socket.
loop(Socket) ->
    receive
        {udp, _S, _IP, _Port, Data} ->
            io:format("got: ~p~ndec: ~p~n", [Data, nl_ct_dec(Data)])
    end,
    loop(Socket).
