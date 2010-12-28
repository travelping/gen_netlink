-module(netlink).

-export([start/0, nl_dec/1]).

-include("gen_socket.hrl").

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

-define(CTA_UNSPEC,0).
-define(CTA_TUPLE_ORIG,1).
-define(CTA_TUPLE_REPLY,2).
-define(CTA_STATUS,3).
-define(CTA_PROTOINFO,4).
-define(CTA_HELP,5).
-define(CTA_NAT_SRC,6).
-define(CTA_TIMEOUT,7).
-define(CTA_MARK,8).
-define(CTA_COUNTERS_ORIG,9).
-define(CTA_COUNTERS_REPLY,10).
-define(CTA_USE,11).
-define(CTA_ID,12).
-define(CTA_NAT_DST,13).
-define(CTA_TUPLE_MASTER,14).
-define(CTA_NAT_SEQ_ADJ_ORIG,15).
-define(CTA_NAT_SEQ_ADJ_REPLY,16).
-define(CTA_SECMARK,17).

%% grep "^-define(CTA_" src/netlink.erl | awk -F"[(,]" '{ printf "dec_cta_type(?%s)%*s %s;\n", $2, 32 - length($2), "->", tolower(substr($2,5)) }'
dec_cta_type(?CTA_UNSPEC)                    -> unspec;
dec_cta_type(?CTA_TUPLE_ORIG)                -> tuple_orig;
dec_cta_type(?CTA_TUPLE_REPLY)               -> tuple_reply;
dec_cta_type(?CTA_STATUS)                    -> status;
dec_cta_type(?CTA_PROTOINFO)                 -> protoinfo;
dec_cta_type(?CTA_HELP)                      -> help;
dec_cta_type(?CTA_NAT_SRC)                   -> nat_src;
dec_cta_type(?CTA_TIMEOUT)                   -> timeout;
dec_cta_type(?CTA_MARK)                      -> mark;
dec_cta_type(?CTA_COUNTERS_ORIG)             -> counters_orig;
dec_cta_type(?CTA_COUNTERS_REPLY)            -> counters_reply;
dec_cta_type(?CTA_USE)                       -> use;
dec_cta_type(?CTA_ID)                        -> id;
dec_cta_type(?CTA_NAT_DST)                   -> nat_dst;
dec_cta_type(?CTA_TUPLE_MASTER)              -> tuple_master;
dec_cta_type(?CTA_NAT_SEQ_ADJ_ORIG)          -> nat_seq_adj_orig;
dec_cta_type(?CTA_NAT_SEQ_ADJ_REPLY)         -> nat_seq_adj_reply;
dec_cta_type(?CTA_SECMARK)                   -> secmark.

-define(CTA_TUPLE_UNSPEC,0).
-define(CTA_TUPLE_IP,1).
-define(CTA_TUPLE_PROTO,2).

dec_cta_tuple(?CTA_TUPLE_UNSPEC) -> unspec;
dec_cta_tuple(?CTA_TUPLE_IP)     -> ip;
dec_cta_tuple(?CTA_TUPLE_PROTO)  -> proto.

-define(CTA_IP_UNSPEC,0).
-define(CTA_IP_V4_SRC,1).
-define(CTA_IP_V4_DST,2).
-define(CTA_IP_V6_SRC,3).
-define(CTA_IP_V6_DST,4).

%% grep "^-define(CTA_IP" src/netlink.erl | awk -F"[(,]" '{ printf "dec_cta_ip(?%s)%*s %s;\n", $2, 32 - length($2), "->", tolower(substr($2,8)) }'
dec_cta_ip(?CTA_IP_UNSPEC)                 -> unspec;
dec_cta_ip(?CTA_IP_V4_SRC)                 -> v4_src;
dec_cta_ip(?CTA_IP_V4_DST)                 -> v4_dst;
dec_cta_ip(?CTA_IP_V6_SRC)                 -> v6_src;
dec_cta_ip(?CTA_IP_V6_DST)                 -> v6_dst.

-define(CTA_PROTO_UNSPEC,0).
-define(CTA_PROTO_NUM,1).
-define(CTA_PROTO_SRC_PORT,2).
-define(CTA_PROTO_DST_PORT,3).
-define(CTA_PROTO_ICMP_ID,4).
-define(CTA_PROTO_ICMP_TYPE,5).
-define(CTA_PROTO_ICMP_CODE,6).
-define(CTA_PROTO_ICMPV6_ID,7).
-define(CTA_PROTO_ICMPV6_TYPE,8).
-define(CTA_PROTO_ICMPV6_CODE,9).

%% grep "^-define(CTA_PROTO_" src/netlink.erl | awk -F"[(,]" '{ printf "dec_cta_proto(?%s)%*s %s;\n", $2, 32 - length($2), "->", tolower(substr($2,11)) }'
dec_cta_proto(?CTA_PROTO_UNSPEC)              -> unspec;
dec_cta_proto(?CTA_PROTO_NUM)                 -> num;
dec_cta_proto(?CTA_PROTO_SRC_PORT)            -> src_port;
dec_cta_proto(?CTA_PROTO_DST_PORT)            -> dst_port;
dec_cta_proto(?CTA_PROTO_ICMP_ID)             -> icmp_id;
dec_cta_proto(?CTA_PROTO_ICMP_TYPE)           -> icmp_type;
dec_cta_proto(?CTA_PROTO_ICMP_CODE)           -> icmp_code;
dec_cta_proto(?CTA_PROTO_ICMPV6_ID)           -> icmpv6_id;
dec_cta_proto(?CTA_PROTO_ICMPV6_TYPE)         -> icmpv6_type;
dec_cta_proto(?CTA_PROTO_ICMPV6_CODE)         -> icmpv6_code.

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

nl_dec_ct_ip(Type, _Nested, << A:8, B:8, C:8, D:8 >>) when Type == v4_src; Type == v4_dst ->
    {Type, {A, B, C, D}};
nl_dec_ct_ip(Type, _Nested, <<A:16, B:16, C:16, D:16, E:16, F:16, G:16, H:16>>) when Type == v6_src; Type == v6_dst ->
    {Type, {A,B,C,D,E,F,G,H}}.

nl_dec_ct_proto(Type, _Nested, << Proto:8 >>) when Type == num ->
    {Type, gen_socket:protocol(Proto)};
nl_dec_ct_proto(Type, _Nested, << Port:16 >>) when Type == src_port; Type == dst_port ->
    {Type, Port};
nl_dec_ct_proto(Type, _Nested, Data) ->
    {Type, Data}.

nl_dec_ct_tuples(ip, _Nested, Data) ->
    {ip, nl_dec_nla(fun(T, N, D) -> nl_dec_ct_ip(dec_cta_ip(T), N, D) end, Data, [])};
nl_dec_ct_tuples(proto, _Nested, Data) ->
    {proto, nl_dec_nla(fun(T, N, D) -> nl_dec_ct_proto(dec_cta_proto(T), N, D) end, Data, [])};
nl_dec_ct_tuples(Type, _Nested, Data) ->
    {Type, Data}.

nl_dec_ct_attr(Type, _Nested, << Val:32 >> ) when Type == id; Type == timeout; Type == mark; Type == secmark ->
    {Type, Val};
nl_dec_ct_attr(Type, true, Data) when Type == tuple_master; Type == tuple_orig; Type == tuple_reply ->
    {Type, nl_dec_nla(fun(T, N, D) -> nl_dec_ct_tuples(dec_cta_tuple(T), N, D) end, Data, [])};
nl_dec_ct_attr(Type, _Nested, Data) ->
    {Type, Data}.

pad_len(Block, Size) ->
    (Block - (Size rem Block)) rem Block.

nl_dec_nla(F, << Len:16/native-integer, Type:16/native-integer, Rest/binary >>, Acc) ->
    PLen = Len - 4,
    Padding = pad_len(4, PLen),
    << Data:PLen/bytes, Pad:Padding/bytes, NewRest/binary >> = Rest,
    nl_dec_nla(F, NewRest, [F(Type band 16#7FFF, (Type band 16#8000) /= 0, Data) | Acc]);
nl_dec_nla(_F, << >>, Acc) ->
    Acc.

nl_dec_payload(ctnetlink, _MsgType, << Family:8, Version:8, ResId:16/native-integer, Data/binary >>) ->
    { gen_socket:family(Family), Version, ResId, nl_dec_nla(fun(T, N, D) -> nl_dec_ct_attr(dec_cta_type(T), N, D) end, Data, []) };

nl_dec_payload(_SubSys, _MsgType, Data) ->
    Data.

nlmsg_ok(DataLen, MsgLen) ->
    (DataLen >= 16) and (MsgLen >= 16) and (MsgLen =< DataLen).

nl_dec(<< _Junk:5/bytes, Len:32/native-integer, Type:16/native-integer, Flags:16/native-integer, Seq:32/native-integer, Pid:32/native-integer, Data/binary >> = Msg) ->
    case nlmsg_ok(size(Msg) - 5, Len) of
        true -> 
            SubSys = dec_nfnl_subsys(Type bsr 8),
            MsgType = Type band 16#00FF,
            { SubSys, MsgType, Flags, Seq, Pid, nl_dec_payload(SubSys, MsgType, Data) };
        _ ->
            { error, format }
    end.

% Echo back whatever data we receive on Socket.
loop(Socket) ->
    receive
        {udp, _S, _IP, _Port, Data} ->
            io:format("got: ~p~ndec: ~p~n", [Data, nl_dec(Data)])
    end,
    loop(Socket).
