%% Copyright 2010-2013, Travelping GmbH <info@travelping.com>

%% Permission is hereby granted, free of charge, to any person obtaining a
%% copy of this software and associated documentation files (the "Software"),
%% to deal in the Software without restriction, including without limitation
%% the rights to use, copy, modify, merge, publish, distribute, sublicense,
%% and/or sell copies of the Software, and to permit persons to whom the
%% Software is furnished to do so, subject to the following conditions:

%% The above copyright notice and this permission notice shall be included in
%% all copies or substantial portions of the Software.

%% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
%% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
%% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
%% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
%% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
%% FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
%% DEALINGS IN THE SOFTWARE.

-module(netlink).
-behaviour(gen_server).

-compile(inline).
-compile(inline_list_funcs).

-export([start/0, start/2, start/3,
	 start_link/0, start_link/2, start_link/3,
	 stop/0, stop/1]).
-export([subscribe/2, subscribe/3,
	 send/2, send/3,
	 request/2, request/3]).

-export([init/1, handle_info/2, handle_cast/2, handle_call/3, terminate/2, code_change/3]).

-export([nl_ct_dec/1, nl_rt_dec/1,
	 nl_rt_enc/1, nl_ct_enc/1,
	 enc_nlmsghdr/5, rtnl_wilddump/2]).
-export([sockaddr_nl/3, setsockopt/4]).
-export([rcvbufsiz/2]).
-export([notify/3]).

-include_lib("gen_socket/include/gen_socket.hrl").
-include("netlink.hrl").

-define(SERVER, ?MODULE).
-define(TAB, ?MODULE).

-record(subscription, {
    pid                 :: pid(),
    types               :: [ct | rt | s]
}).

-record(state, {
    subscribers = []    :: [#subscription{}],
    ct                  :: gen_socket:socket(),
    rt                  :: gen_socket:socket(),

    msgbuf = []         :: [netlink_record()],
    curseq = 16#FF      :: non_neg_integer(),
    requests            :: gb_tree()
}).

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

-define(RTNLGRP_NONE, 0).
-define(RTNLGRP_LINK, 1).
-define(RTNLGRP_NOTIFY, 2).
-define(RTNLGRP_NEIGH, 3).
-define(RTNLGRP_TC, 4).
-define(RTNLGRP_IPV4_IFADDR, 4).
-define(RTNLGRP_IPV4_MROUTE, 5).
-define(RTNLGRP_IPV4_ROUTE, 6).
-define(RTNLGRP_IPV4_RULE, 7).
-define(RTNLGRP_IPV6_IFADDR, 8).
-define(RTNLGRP_IPV6_MROUTE, 9).
-define(RTNLGRP_IPV6_ROUTE, 10).
-define(RTNLGRP_IPV6_IFINFO, 11).
-define(RTNLGRP_DECnet_IFADDR, 12).
-define(RTNLGRP_NOP2,13).
-define(RTNLGRP_DECnet_ROUTE, 14).
-define(RTNLGRP_DECnet_RULE, 15).
-define(RTNLGRP_NOP4, 16).
-define(RTNLGRP_IPV6_PREFIX, 17).
-define(RTNLGRP_IPV6_RULE, 18).
-define(RTNLGRP_ND_USEROPT, 19).
-define(RTNLGRP_PHONET_IFADDR, 20).
-define(RTNLGRP_PHONET_ROUTE, 21).

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
enc_opt(nfnlgrp_conntrack_exp_destroy) -> ?NFNLGRP_CONNTRACK_EXP_DESTROY;
enc_opt(rtnlgrp_none)                  -> ?RTNLGRP_NONE;
enc_opt(rtnlgrp_link)                  -> ?RTNLGRP_LINK;
enc_opt(rtnlgrp_notify)                -> ?RTNLGRP_NOTIFY;
enc_opt(rtnlgrp_neigh)                 -> ?RTNLGRP_NEIGH;
enc_opt(rtnlgrp_tc)                    -> ?RTNLGRP_TC;
enc_opt(rtnlgrp_ipv4_ifaddr)           -> ?RTNLGRP_IPV4_IFADDR;
enc_opt(rtnlgrp_ipv4_mroute)           -> ?RTNLGRP_IPV4_MROUTE;
enc_opt(rtnlgrp_ipv4_route)            -> ?RTNLGRP_IPV4_ROUTE;
enc_opt(rtnlgrp_ipv4_rule)             -> ?RTNLGRP_IPV4_RULE;
enc_opt(rtnlgrp_ipv6_ifaddr)           -> ?RTNLGRP_IPV6_IFADDR;
enc_opt(rtnlgrp_ipv6_mroute)           -> ?RTNLGRP_IPV6_MROUTE;
enc_opt(rtnlgrp_ipv6_route)            -> ?RTNLGRP_IPV6_ROUTE;
enc_opt(rtnlgrp_ipv6_ifinfo)           -> ?RTNLGRP_IPV6_IFINFO;
enc_opt(rtnlgrp_decnet_ifaddr)         -> ?RTNLGRP_DECnet_IFADDR;
enc_opt(rtnlgrp_nop2)                  -> ?RTNLGRP_NOP2;
enc_opt(rtnlgrp_decnet_route)          -> ?RTNLGRP_DECnet_ROUTE;
enc_opt(rtnlgrp_decnet_rule)           -> ?RTNLGRP_DECnet_RULE;
enc_opt(rtnlgrp_nop4)                  -> ?RTNLGRP_NOP4;
enc_opt(rtnlgrp_ipv6_prefix)           -> ?RTNLGRP_IPV6_PREFIX;
enc_opt(rtnlgrp_ipv6_rule)             -> ?RTNLGRP_IPV6_RULE;
enc_opt(rtnlgrp_nd_useropt)            -> ?RTNLGRP_ND_USEROPT;
enc_opt(rtnlgrp_phonet_ifaddr)         -> ?RTNLGRP_PHONET_IFADDR;
enc_opt(rtnlgrp_phonet_route)          -> ?RTNLGRP_PHONET_ROUTE.

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

%% grep "^-define(NFNL_SUB" src/netlink.erl | awk -F"[(,]" '{ printf "nfnl_subsys(?%s)%*s %s;\n", $2, 32 - length($2), "->", tolower(substr($2,13)) }'
nfnl_subsys(?NFNL_SUBSYS_NONE)              -> netlink;
nfnl_subsys(?NFNL_SUBSYS_CTNETLINK)         -> ctnetlink;
nfnl_subsys(?NFNL_SUBSYS_CTNETLINK_EXP)     -> ctnetlink_exp;
nfnl_subsys(?NFNL_SUBSYS_QUEUE)             -> queue;
nfnl_subsys(?NFNL_SUBSYS_ULOG)              -> ulog;
nfnl_subsys(?NFNL_SUBSYS_COUNT)             -> count;
nfnl_subsys(SubSys) when is_integer(SubSys) -> SubSys;

nfnl_subsys(netlink)           -> ?NFNL_SUBSYS_NONE;
nfnl_subsys(ctnetlink)         -> ?NFNL_SUBSYS_CTNETLINK;
nfnl_subsys(ctnetlink_exp)     -> ?NFNL_SUBSYS_CTNETLINK_EXP;
nfnl_subsys(queue)             -> ?NFNL_SUBSYS_QUEUE;
nfnl_subsys(ulog)              -> ?NFNL_SUBSYS_ULOG;
nfnl_subsys(count)             -> ?NFNL_SUBSYS_COUNT.

-define(NLMSG_NOOP, 1).
-define(NLMSG_ERROR, 2).
-define(NLMSG_DONE, 3).
-define(NLMSG_OVERRUN, 4).

-define(RTM_NEWLINK, 16).
-define(RTM_DELLINK, 17).
-define(RTM_GETLINK, 18).
-define(RTM_SETLINK, 19).
-define(RTM_NEWADDR, 20).
-define(RTM_DELADDR, 21).
-define(RTM_GETADDR, 22).
-define(RTM_NEWROUTE, 24).
-define(RTM_DELROUTE, 25).
-define(RTM_GETROUTE, 26).
-define(RTM_NEWNEIGH, 28).
-define(RTM_DELNEIGH, 29).
-define(RTM_GETNEIGH, 30).
-define(RTM_NEWRULE, 32).
-define(RTM_DELRULE, 33).
-define(RTM_GETRULE, 34).
-define(RTM_NEWQDISC, 36).
-define(RTM_DELQDISC, 37).
-define(RTM_GETQDISC, 38).
-define(RTM_NEWTCLASS, 40).
-define(RTM_DELTCLASS, 41).
-define(RTM_GETTCLASS, 42).
-define(RTM_NEWTFILTER, 44).
-define(RTM_DELTFILTER, 45).
-define(RTM_GETTFILTER, 46).
-define(RTM_NEWACTION, 48).
-define(RTM_DELACTION, 49).
-define(RTM_GETACTION, 50).
-define(RTM_NEWPREFIX, 52).
-define(RTM_GETMULTICAST, 58).
-define(RTM_GETANYCAST, 62).
-define(RTM_NEWNEIGHTBL, 64).
-define(RTM_GETNEIGHTBL, 66).
-define(RTM_SETNEIGHTBL, 67).
-define(RTM_NEWNDUSEROPT, 68).
-define(RTM_NEWADDRLABEL, 72).
-define(RTM_DELADDRLABEL, 73).
-define(RTM_GETADDRLABEL, 74).
-define(RTM_GETDCB, 78).
-define(RTM_SETDCB, 79).

-define(IPCTNL_MSG_CT_NEW, 0).
-define(IPCTNL_MSG_CT_GET, 1).
-define(IPCTNL_MSG_CT_DELETE, 2).
-define(IPCTNL_MSG_CT_GET_CTRZERO, 3).

-define(IPCTNL_MSG_EXP_NEW, 0).
-define(IPCTNL_MSG_EXP_GET, 1).
-define(IPCTNL_MSG_EXP_DELETE, 2).

-include("netlink_decoder_gen.hrl").

dec_rtm_msgtype(Type) ->
    decode_rtm_msgtype(Type).

dec_rtm_type(RtmType) ->
    decode_rtnetlink_rtm_type(RtmType).

dec_rtm_protocol(RtmProto) ->
    decode_rtnetlink_rtm_protocol(RtmProto).

dec_rtm_scope(RtmScope) ->
    decode_rtnetlink_rtm_scope(RtmScope).

dec_rtm_table(RtmTable) ->
    decode_rtnetlink_rtm_table(RtmTable).

%% decode_rtnetlink_link_protinfo(inet, Type, Value) ->
%%     decode_rtnetlink_link_protinfo_inet(inet, Type, Value);
decode_rtnetlink_link_protinfo(inet6, Type, Value) ->
    decode_rtnetlink_link_protinfo_inet6(inet6, Type, Value);
decode_rtnetlink_link_protinfo(Family, Type, Value) ->
    {decode_rtnetlink_link_protinfo, Family, Type, Value}.

decode_ctnetlink_protoinfo_dccp(Family, Type, Value) ->
    {decode_ctnetlink_protoinfo_dccp, Family, Type, Value}.
decode_ctnetlink_protoinfo_sctp(Family, Type, Value) ->
    {decode_ctnetlink_protoinfo_sctp, Family, Type, Value}.

decode_ipctnl_msg(netlink, Type) ->
    decode_ctm_msgtype_netlink(Type);
decode_ipctnl_msg(ctnetlink, Type) ->
    decode_ctm_msgtype_ctnetlink(Type);
decode_ipctnl_msg(ctnetlink_exp, Type) ->
    decode_ctm_msgtype_ctnetlink_exp(Type).

decode_nlm_msg_flags(new, Flags) ->
    decode_flag(flag_info_nlm_new_flags(), Flags);
decode_nlm_msg_flags(_, Flags) ->
    decode_flag(flag_info_nlm_get_flags(), Flags).

decode_rtnetlink_rtm_flags(Flags) ->
    decode_flag(flag_info_rtnetlink_rtm_flags(), Flags).

decode_nlm_flags(Type, Flags) when
      Type == getlink; Type == getaddr; Type == getroute; Type == getneigh;
      Type == getrule; Type == getqdisc; Type == gettclass; Type == gettfilter;
      Type == getaction; Type == getmulticast; Type == getanycast; Type == getneightbl;
      Type == getaddrlabel; Type == getdcb ->
    decode_flag(flag_info_nlm_get_flags(), Flags);

decode_nlm_flags(Type, Flags) when
      Type == newlink; Type == newaddr; Type == newroute; Type == newneigh;
      Type == newrule; Type == newqdisc; Type == newtclass; Type == newtfilter;
      Type == newaction; Type == newprefix; Type == newneightbl; Type == newnduseropt;
      Type == newaddrlabel ->
    decode_flag(flag_info_nlm_new_flags(), Flags);

decode_nlm_flags(_Type, Flags) ->
    decode_flag(flag_info_nlm_flags(), Flags).

decode_iff_flags(Flags) ->
    decode_flag(flag_info_iff_flags(), Flags).

encode_iff_flags(Flags) ->
    encode_flag(flag_info_iff_flags(), Flags).

encode_rtnetlink_rtm_flags(Flags) ->
    encode_flag(flag_info_rtnetlink_rtm_flags(), Flags).

encode_rtnetlink_link_protinfo(inet6, Value) ->
    encode_rtnetlink_link_protinfo_inet6(inet6, Value);
encode_rtnetlink_link_protinfo(Family, Value) ->
    io:format("encode_rtnetlink_link_protinfo: ~p~n", {Family, Value}).

encode_ctnetlink_protoinfo_dccp(Family, Value) ->
    io:format("encode_ctnetlink: ~p~n", {Family, Value}).

encode_ctnetlink_protoinfo_sctp(Family, Value) ->
    io:format("encode_ctnetlink_protoinfo_sctp: ~p~n", {Family, Value}).

encode_ipctnl_msg(netlink, Type) ->
    encode_ctm_msgtype_netlink(Type);
encode_ipctnl_msg(ctnetlink, Type) ->
    encode_ctm_msgtype_ctnetlink(Type);
encode_ipctnl_msg(ctnetlink_exp, Type) ->
    encode_ctm_msgtype_ctnetlink_exp(Type).

sockaddr_nl(Family, Pid, Groups) ->
    sockaddr_nl({Family, Pid, Groups}).

-spec sockaddr_nl({atom()|integer(),integer(),integer()}) -> binary();
				 (binary()) -> {atom()|integer(),integer(),integer()}.
sockaddr_nl({Family, Pid, Groups}) when is_atom(Family) ->
    sockaddr_nl({gen_socket:family(Family), Pid, Groups});
sockaddr_nl({Family, Pid, Groups}) ->
    << Family:16/native-integer, 0:16, Pid:32/native-integer, Groups:32/native-integer >>;
sockaddr_nl(<< Family:16/native-integer, _Pad:16, Pid:32/native-integer, Groups:32/native-integer >>) ->
    {gen_socket:family(Family), Pid, Groups}.

setsockopt(Socket, Level, OptName, Val) when is_atom(Level) ->
    setsockopt(Socket, enc_opt(Level), OptName, Val);
setsockopt(Socket, Level, OptName, Val) when is_atom(OptName) ->
    setsockopt(Socket, Level, enc_opt(OptName), Val);
setsockopt(Socket, Level, OptName, Val) when is_atom(Val) ->
    setsockopt(Socket, Level, OptName, enc_opt(Val));
setsockopt(Socket, Level, OptName, Val) when is_integer(Val) ->
    gen_socket:setsockopt(Socket, Level, OptName, Val).

rcvbufsiz(Socket, BufSiz) ->
    case gen_socket:setsockopt(Socket, sol_socket, rcvbufforce, BufSiz) of
	ok -> ok;
	_ -> gen_socket:setsockopt(Socket, sol_socket, rcvbuf, BufSiz)
    end.

encode_flag(_Type, [], Value) ->
    Value;
encode_flag(Type, [Flag|Next], Value) when is_integer(Flag) ->
    encode_flag(Type, Next, Value bor Flag);
encode_flag(Type, [Flag|Next], Value) when is_atom(Flag) ->
    case lists:keyfind(Flag, 2, Type) of
	{Pos, _} ->
	    encode_flag(Type, Next, Value bor Pos);
	_ ->
	    encode_flag(Type, Next, Value)
    end.

encode_flag(Type, Flag) ->
    io:format("encode_flag: ~p, ~p~n", [Type, Flag]),
    encode_flag(Type, Flag, 0).


decode_flag([], 0, Acc) ->
    Acc;
decode_flag([], Flag, Acc) ->
    [Flag|Acc];
decode_flag([{Pos, V}|Rest], Flag, Acc) ->
    if Pos band Flag /= 0 ->
	    decode_flag(Rest, Flag bxor Pos, [V|Acc]);
       true ->
	    decode_flag(Rest, Flag, Acc)
    end.

decode_flag(Type, Flag) ->
    decode_flag(Type, Flag, []).

enc_nla(NlaType, Data) ->
	pad_to(4, <<(size(Data)+4):16/native-integer, NlaType:16/native-integer, Data/binary>>).

encode_none(NlaType, Data) ->
	enc_nla(NlaType, Data).

encode_binary(NlaType, Data) ->
	enc_nla(NlaType, Data).

encode_string(NlaType, String) ->
	enc_nla(NlaType, <<(list_to_binary(String))/binary, 0>>).

encode_uint8(NlaType, Val) ->
	enc_nla(NlaType, <<Val:8>>).
encode_uint16(NlaType, Val) ->
	enc_nla(NlaType, <<Val:16>>).
encode_uint32(NlaType, Val) ->
	enc_nla(NlaType, <<Val:32>>).
encode_uint64(NlaType, Val) ->
	enc_nla(NlaType, <<Val:64>>).
%% encode_huint16(NlaType, Val) ->
%% 	enc_nla(NlaType, <<Val:16/native-integer>>).
encode_huint32(NlaType, Val) ->
	enc_nla(NlaType, <<Val:32/native-integer>>).
%% encode_huint64(NlaType, Val) ->
%% 	enc_nla(NlaType, <<Val:64/native-integer>>).

encode_protocol(NlaType, Proto) ->
	enc_nla(NlaType, <<(gen_socket:protocol(Proto)):8>>).
encode_mac(NlaType, {A, B, C, D, E, F}) ->
	enc_nla(NlaType, << A:8, B:8, C:8, D:8, E:8, F:8 >>);
encode_mac(NlaType, MAC) when is_binary(MAC), size(MAC) == 6 ->
	enc_nla(NlaType, MAC).

encode_addr(NlaType, {A, B, C, D}) ->
	enc_nla(NlaType, << A:8, B:8, C:8, D:8 >>);
encode_addr(NlaType, {A,B,C,D,E,F,G,H}) ->
	enc_nla(NlaType, <<A:16, B:16, C:16, D:16, E:16, F:16, G:16, H:16>>).

encode_if_map(NlaType, {_Attr, MemStart, MemEnd, BaseAddr, Irq, Dma, Port}) ->
    %% WARNING: THIS might be broken, compiler specific aligment must be take into consideration
    enc_nla(NlaType, << MemStart:64/native-integer, MemEnd:64/native-integer,
			BaseAddr:64/native-integer, Irq:16/native-integer,
			Dma:8, Port:8, 0:32 >>).

encode_hsint32_array(NlaType, Req) ->
    enc_nla(NlaType, << <<H:4/native-signed-integer-unit:8>> || H <- tl(tuple_to_list(Req)) >>).

encode_huint32_array(NlaType, Req) ->
    enc_nla(NlaType, << <<H:4/native-integer-unit:8>> || H <- tl(tuple_to_list(Req)) >>).

encode_huint64_array(NlaType, Req) ->
    enc_nla(NlaType, << <<H:8/native-integer-unit:8>> || H <- tl(tuple_to_list(Req)) >>).

%%
%% decoder
%%

decode_binary(Val) ->
    Val.
decode_none(Val) ->
    Val.
decode_string(Val) ->
    binary_to_list(binary:part(Val, 0, size(Val) - 1)).
decode_uint8(<< Val:8 >>) ->
    Val.
decode_uint16(<< Val:16 >>) ->
    Val.
decode_uint32(<< Val:32 >>) ->
    Val.
decode_uint64(<< Val:64 >>) ->
    Val.
%% decode_huint16(<< Val:16/native-integer >>) ->
%%     Val.
decode_huint32(<< Val:32/native-integer >>) ->
    Val.
%% decode_huint64(<< Val:64/native-integer >>) ->
%%     Val.

decode_protocol(<< Proto:8 >>) ->
    gen_socket:protocol(Proto).
decode_mac(MAC) when size(MAC) == 6 ->
    MAC.
decode_addr(<< A:8, B:8, C:8, D:8 >>) ->
    {A, B, C, D};
decode_addr(<<A:16, B:16, C:16, D:16, E:16, F:16, G:16, H:16>>) ->
    {A,B,C,D,E,F,G,H}.

decode_if_map(Attr, << MemStart:64/native-integer, MemEnd:64/native-integer,
		       BaseAddr:64/native-integer, Irq:16/native-integer,
		       Dma:8, Port:8, _Pad/binary >> = D) ->
    %% WARNING: THIS might be broken, compiler specific aligment must be take into consideration
    {Attr, MemStart, MemEnd, BaseAddr, Irq, Dma, Port}.

decode_hsint32_array(Attr, Data) ->
    list_to_tuple([Attr | [ H || <<H:4/native-signed-integer-unit:8>> <= Data ]]).
%% decode_huint64_array(Attr, Data) ->
%%     list_to_tuple([Attr | [ H || <<H:8/native-signed-integer-unit:8>> <= Data ]]).

decode_huint32_array(Attr, Data) ->
    list_to_tuple([Attr | [ H || <<H:4/native-integer-unit:8>> <= Data ]]).
decode_huint64_array(Attr, Data) ->
    list_to_tuple([Attr | [ H || <<H:8/native-integer-unit:8>> <= Data ]]).

%%
%% pad binary to specific length
%%   -> http://www.erlang.org/pipermail/erlang-questions/2008-December/040709.html
%%
pad_to(Width, Binary) ->
     case (Width - size(Binary) rem Width) rem Width of
         0 -> Binary;
         N -> <<Binary/binary, 0:(N*8)>>
     end.

pad_len(Block, Size) ->
    (Block - (Size rem Block)) rem Block.

nl_dec_nla(Family, Fun, << Len:16/native-integer, NlaType:16/native-integer, Rest/binary >>, Acc) ->
    PLen = Len - 4,
    Padding = pad_len(4, PLen),
    << Data:PLen/bytes, _Pad:Padding/bytes, NewRest/binary >> = Rest,

    H = Fun(Family, NlaType band 16#7FFF, Data),
    nl_dec_nla(Family, Fun, NewRest, [H | Acc]);

nl_dec_nla(_Family, _Fun, << >>, Acc) ->
    lists:reverse(Acc).

nl_dec_nla(Family, Fun, Data)
  when is_function(Fun, 3) ->
    nl_dec_nla(Family, Fun, Data, []).

nl_enc_nla(_Family, _Fun, [], Acc) ->
    list_to_binary(lists:reverse(Acc));
nl_enc_nla(Family, Fun, [Head|Rest], Acc) ->
    io:format("nl_enc_nla: ~w, ~w~n", [Family, Head]),
    H = Fun(Family, Head),
    nl_enc_nla(Family, Fun, Rest, [H|Acc]).

nl_enc_nla(Family, Fun, Req) when is_function(Fun, 2) ->
    nl_enc_nla(Family, Fun, Req, []).

nl_enc_payload(ctnetlink, _MsgType, {Family, Version, ResId, Req}) ->
    Fam = gen_socket:family(Family),
    Data = nl_enc_nla(Family, fun encode_ctnetlink/2, Req),
    << Fam:8, Version:8, ResId:16/native-integer, Data/binary >>;

nl_enc_payload(ctnetlink_exp, _MsgType, {Family, Version, ResId, Req}) ->
    Fam = gen_socket:family(Family),
	Data = nl_enc_nla(Family, fun encode_ctnetlink_exp/2, Req),
	<< Fam:8, Version:8, ResId:16/native-integer, Data/binary >>;

nl_enc_payload(rtnetlink, MsgType, {Family, IfIndex, State, Flags, NdmType, Req})
  when MsgType == getneigh; MsgType == newneigh; MsgType == delneigh ->
    Fam = gen_socket:family(Family),
    Data = nl_enc_nla(Family, fun encode_rtnetlink_neigh/2, Req),
    << Fam:8, 0:8, 0:16, IfIndex:32/native-signed-integer, State:16/native-integer, Flags:8, NdmType:8, Data/binary >>;

nl_enc_payload(rtnetlink, MsgType, {Family, PrefixLen, Flags, Scope, Index, Req})
  when MsgType == newaddr; MsgType == deladdr ->
    Fam = gen_socket:family(Family),
    Data = nl_enc_nla(Family, fun encode_rtnetlink_addr/2, Req),
    << Fam:8, PrefixLen:8, Flags:8, Scope:8, Index:32/native-integer, Data/binary >>;

nl_enc_payload(rtnetlink, MsgType, {Family, DstLen, SrcLen, Tos, Table, Protocol, Scope, RtmType, Flags, Req})
  when MsgType == newroute; MsgType == delroute ; MsgType == getroute ->
    Fam = gen_socket:family(Family),
    io:format("nl_enc_payload: ~p~n", [{Family, DstLen, SrcLen, Tos, Table, Protocol, Scope, RtmType, Flags, Req}]),
    io:format("~p, ~p, ~p, ~p, ~p~n", [encode_rtnetlink_rtm_table(Table),
				       encode_rtnetlink_rtm_protocol(Protocol),
				       encode_rtnetlink_rtm_scope(Scope),
				       encode_rtnetlink_rtm_type(RtmType),
				       encode_rtnetlink_rtm_flags(Flags)]),

    Data = nl_enc_nla(Family, fun encode_rtnetlink_route/2, Req),
    << Fam:8, DstLen:8, SrcLen:8, Tos:8,
       (encode_rtnetlink_rtm_table(Table)):8,
       (encode_rtnetlink_rtm_protocol(Protocol)):8,
       (encode_rtnetlink_rtm_scope(Scope)):8,
       (encode_rtnetlink_rtm_type(RtmType)):8,
       (encode_rtnetlink_rtm_flags(Flags)):32/native-integer, Data/binary >>;

nl_enc_payload(rtnetlink, MsgType, {Family, Type, Index, Flags, Change, Req})
  when MsgType == newlink; MsgType == dellink ->
	Fam = gen_socket:family(Family),
	Type0 = gen_socket:arphdr(Type),
	Flags0 = encode_iff_flags(Flags),
	Change0 = encode_iff_flags(Change),
	Data = nl_enc_nla(Family, fun encode_rtnetlink_link/2, Req),
	<<Fam:8, 0:8, Type0:16/native-integer, Index:32/native-integer, Flags0:32/native-integer, Change0:32/native-integer, Data/binary >>;

nl_enc_payload(rtnetlink, MsgType,{Family, IfIndex, PfxType, PfxLen, Flags, Req})
  when MsgType == newprefix; MsgType == delprefix ->
    Fam = gen_socket:family(Family),
	Data = nl_enc_nla(Family, fun encode_rtnetlink_prefix/2, Req),
	<< Fam:8, 0:8, 0:16, IfIndex:32/native-signed-integer, PfxType:8, PfxLen:8, Flags:8, 0:8, Data/binary >>;

nl_enc_payload(_, _, Data)
  when is_binary(Data) ->
	Data.

nl_dec_payload(_Type, done, << Length:32/native-integer >>) ->
	Length;

nl_dec_payload(ctnetlink, _MsgType, << Family:8, Version:8, ResId:16/native-integer, Data/binary >>) ->
    Fam = gen_socket:family(Family),
    { Fam, Version, ResId, nl_dec_nla(Fam, fun decode_ctnetlink/3, Data) };

nl_dec_payload(ctnetlink_exp, _MsgType, << Family:8, Version:8, ResId:16/native-integer, Data/binary >>) ->
    Fam = gen_socket:family(Family),
    { Fam, Version, ResId, nl_dec_nla(Fam, fun decode_ctnetlink_exp/3, Data) };

nl_dec_payload(rtnetlink, MsgType, << Family:8, _Pad1:8, _Pad2:16, IfIndex:32/native-signed-integer, State:16/native-integer, Flags:8, NdmType:8, Data/binary >>)
  when MsgType == getneigh; MsgType == newneigh; MsgType == delneigh ->
    Fam = gen_socket:family(Family),
    { Fam, IfIndex, State, Flags, NdmType, nl_dec_nla(Fam, fun decode_rtnetlink_neigh/3, Data) };

nl_dec_payload(rtnetlink, MsgType, << Family:8, DstLen:8, SrcLen:8, Tos:8, Table:8, Protocol:8, Scope:8, RtmType:8, Flags:32/native-integer, Data/binary >>)
  when MsgType == newroute; MsgType == delroute; MsgType == getroute ->
    Fam = gen_socket:family(Family),
    { Fam, DstLen, SrcLen, Tos, dec_rtm_table(Table), dec_rtm_protocol(Protocol), dec_rtm_scope(Scope), dec_rtm_type(RtmType), decode_rtnetlink_rtm_flags(Flags), nl_dec_nla(Fam, fun decode_rtnetlink_route/3, Data) };

nl_dec_payload(rtnetlink, MsgType, << Family:8, PrefixLen:8, Flags:8, Scope:8, Index:32/native-integer, Data/binary >>)
  when MsgType == newaddr; MsgType == deladdr ->
    Fam = gen_socket:family(Family),
    { Fam, PrefixLen, Flags, Scope, Index, nl_dec_nla(Fam, fun decode_rtnetlink_addr/3, Data) };

nl_dec_payload(rtnetlink, MsgType, << Family:8, _Pad:8, Type:16/native-integer, Index:32/native-integer, Flags:32/native-integer, Change:32/native-integer, Data/binary >>)
  when MsgType == newlink; MsgType == dellink ->
    Fam = gen_socket:family(Family),
    { Fam, gen_socket:arphdr(Type), Index, decode_iff_flags(Flags), decode_iff_flags(Change), nl_dec_nla(Fam, fun decode_rtnetlink_link/3, Data) };

nl_dec_payload(rtnetlink, MsgType, << Family:8, _Pad1:8, _Pad2:16, IfIndex:32/native-signed-integer, PfxType:8, PfxLen:8, Flags:8, _Pad3:8, Data/binary >>)
  when MsgType == newprefix; MsgType == delprefix ->
    Fam = gen_socket:family(Family),
    { Fam, IfIndex, PfxType, PfxLen, Flags, nl_dec_nla(Fam, fun decode_rtnetlink_prefix/3, Data) };

nl_dec_payload(_SubSys, _MsgType, Data) ->
    Data.

nlmsg_ok(DataLen, MsgLen) ->
    (DataLen >= 16) and (MsgLen >= 16) and (MsgLen =< DataLen).

-spec nl_ct_dec(binary()) -> [{'error',_} | #ctnetlink{} | #ctnetlink_exp{}].
nl_ct_dec(Msg) ->
    nl_ct_dec(Msg, []).

nl_ct_dec(<< Len:32/native-integer, Type:16/native-integer, Flags:16/native-integer, Seq:32/native-integer, Pid:32/native-integer, Data/binary >> = Msg, Acc) ->
    {DecodedMsg, Next} = case nlmsg_ok(size(Msg), Len) of
			     true ->
                                 PayLoadLen = Len - 16,
                                 << PayLoad:PayLoadLen/bytes, NextMsg/binary >> = Data,

				 SubSys = nfnl_subsys(Type bsr 8),
				 MsgType = decode_ipctnl_msg(SubSys, Type band 16#00FF),
				 Flags0 = decode_nlm_msg_flags(MsgType, Flags),
				 {{ SubSys, MsgType, Flags0, Seq, Pid, nl_dec_payload(SubSys, MsgType, PayLoad) }, NextMsg};
			     _ ->
				 {{ error, format }, << >>}
			 end,
    nl_ct_dec(Next, [DecodedMsg | Acc]);

nl_ct_dec(<< >>, Acc) ->
    lists:reverse(Acc).

-spec nl_rt_dec(binary()) -> [{'error',_} | #rtnetlink{}].
nl_rt_dec(Msg) ->
    nl_rt_dec(Msg, []).

nl_rt_dec(<< Len:32/native-integer, Type:16/native-integer, Flags:16/native-integer, Seq:32/native-integer, Pid:32/native-integer, Data/binary >> = Msg, Acc) ->
    {DecodedMsg, Next} = case nlmsg_ok(size(Msg), Len) of
                             true ->
                                 PayLoadLen = Len - 16,
                                 << PayLoad:PayLoadLen/bytes, NextMsg/binary >> = Data,
                                 MsgType = dec_rtm_msgtype(Type),
                                 {{ rtnetlink, MsgType, decode_nlm_flags(MsgType, Flags), Seq, Pid, nl_dec_payload(rtnetlink, MsgType, PayLoad) }, NextMsg};
                             _ ->
                                 {{ error, format }, << >>}
                 end,
    nl_rt_dec(Next, [DecodedMsg | Acc]);

nl_rt_dec(<< >>, Acc) ->
    lists:reverse(Acc).

enc_nlmsghdr_flags(Type, Flags) when
      Type == getlink; Type == getaddr; Type == getroute; Type == getneigh;
      Type == getrule; Type == getqdisc; Type == gettclass; Type == gettfilter;
      Type == getaction; Type == getmulticast; Type == getanycast; Type == getneightbl;
      Type == getaddrlabel; Type == getdcb ->
    encode_flag(flag_info_nlm_get_flags(), Flags);
enc_nlmsghdr_flags(Type, Flags) when
      Type == newlink; Type == newaddr; Type == newroute; Type == newneigh;
      Type == newrule; Type == newqdisc; Type == newtclass; Type == newtfilter;
      Type == newaction; Type == newprefix; Type == newneightbl; Type == newnduseropt;
      Type == newaddrlabel ->
    encode_flag(flag_info_nlm_new_flags(), Flags);
enc_nlmsghdr_flags(_Type, Flags) ->
    encode_flag(flag_info_nlm_flags(), Flags).

enc_nlmsghdr(Type, Flags, Seq, Pid, Req) when is_list(Flags) ->
    enc_nlmsghdr(Type, enc_nlmsghdr_flags(Type, Flags), Seq, Pid, Req);
enc_nlmsghdr(Type, Flags, Seq, Pid, Req) when is_atom(Type) ->
    enc_nlmsghdr(encode_rtm_msgtype(Type), Flags, Seq, Pid, Req);
enc_nlmsghdr(Type, Flags, Seq, Pid, Req) when is_integer(Flags), is_binary(Req) ->
    Payload = pad_to(4, Req),
    Len = 16 + byte_size(Payload),
    << Len:32/native-integer, Type:16/native-integer, Flags:16/native-integer, Seq:32/native-integer, Pid:32/native-integer, Payload/binary >>.

nl_rt_enc({rtnetlink, MsgType, Flags, Seq, Pid, PayLoad}) ->
	Data = nl_enc_payload(rtnetlink, MsgType, PayLoad),
	enc_nlmsghdr(MsgType, Flags, Seq, Pid, Data);
nl_rt_enc(Msg)
  when is_list(Msg) ->
	nl_rt_enc(Msg, []).

nl_rt_enc([], Acc) ->
	list_to_binary(lists:reverse(Acc));
nl_rt_enc([Head|Rest], Acc) ->
	nl_rt_enc(Rest, [nl_rt_enc(Head)|Acc]).

nl_ct_enc([], Acc) ->
	list_to_binary(lists:reverse(Acc));
nl_ct_enc([Head|Rest], Acc) ->
	nl_ct_enc(Rest, [nl_ct_enc(Head)|Acc]).

nl_ct_enc(Msg)
  when is_list(Msg) ->
	nl_ct_enc(Msg, []);

nl_ct_enc({SubSys, MsgType, Flags, Seq, Pid, PayLoad})
  when is_atom(SubSys), is_atom(MsgType) ->
	nl_ct_enc({SubSys, encode_ipctnl_msg(SubSys, MsgType), Flags, Seq, Pid, PayLoad});

nl_ct_enc({SubSys, MsgType, Flags, Seq, Pid, PayLoad})
  when is_atom(SubSys), is_integer(MsgType) ->
	Data = nl_enc_payload(SubSys, MsgType, PayLoad),
	Type = (nfnl_subsys(SubSys) bsl 8) bor MsgType,
	enc_nlmsghdr(Type, Flags, Seq, Pid, Data).

rtnl_wilddump(Family, Type) ->
    NumFamily = gen_socket:family(Family),
    enc_nlmsghdr(Type, [root, match, request], 0, 0, << NumFamily:8 >>).

%%
%% API implementation
%%

start() ->
    start({local, ?SERVER}, [], []).

start(Args, Options) ->
    gen_server:start(?MODULE, Args, Options).

start(ServerName, Args, Options) ->
    gen_server:start(ServerName, ?MODULE, Args, Options).

start_link() ->
    start_link({local, ?SERVER}, [], []).

start_link(Args, Options) ->
    gen_server:start_link(?MODULE, Args, Options).

start_link(ServerName, Args, Options) ->
    gen_server:start_link(ServerName, ?MODULE, Args, Options).

stop() ->
    stop(?SERVER).

stop(ServerName) ->
    gen_server:cast(ServerName, stop).

-spec send(atom(), binary()) -> ok.
send(SubSys, Msg) ->
    send(?SERVER, SubSys, Msg).

-spec send(atom() | pid(), atom(), binary()) -> ok.
send(ServerName, SubSys, Msg) ->
    gen_server:cast(ServerName, {send, SubSys, Msg}).

subscribe(Pid, Types) ->
    subscribe(?SERVER, Pid, Types).

subscribe(ServerName, Pid, Types) ->
    gen_server:call(ServerName, {subscribe, #subscription{pid = Pid, types = Types}}).

-spec request(atom(), netlink_record()) -> {ok, [netlink_record(), ...]} | {error, term()}.
request(SubSys, Msg) ->
    request(?SERVER, SubSys, Msg).

-spec request(atom() | pid(), atom(), netlink_record()) -> {ok, [netlink_record(), ...]} | {error, term()}.
request(ServerName, SubSys, Msg) ->
    gen_server:call(ServerName, {request, SubSys, Msg}).

%%
%% gen_server callbacks
%%

init(Opts) ->
    {ok, CtNl} = socket(netlink, raw, ?NETLINK_NETFILTER, Opts),
    ok = gen_socket:bind(CtNl, sockaddr_nl(netlink, 0, -1)),
    ok = gen_socket:input_event(CtNl, true),

    ok = gen_socket:setsockopt(CtNl, sol_socket, sndbuf, 32768),
    ok = rcvbufsiz(CtNl, 128 * 1024),

    ok = setsockopt(CtNl, sol_netlink, netlink_add_membership, nfnlgrp_conntrack_new),
    ok = setsockopt(CtNl, sol_netlink, netlink_add_membership, nfnlgrp_conntrack_update),
    ok = setsockopt(CtNl, sol_netlink, netlink_add_membership, nfnlgrp_conntrack_destroy),
    ok = setsockopt(CtNl, sol_netlink, netlink_add_membership, nfnlgrp_conntrack_exp_new),
    ok = setsockopt(CtNl, sol_netlink, netlink_add_membership, nfnlgrp_conntrack_exp_update),
    ok = setsockopt(CtNl, sol_netlink, netlink_add_membership, nfnlgrp_conntrack_exp_destroy),

    {ok, RtNl} = socket(netlink, raw, ?NETLINK_ROUTE, Opts),
    ok = gen_socket:bind(RtNl, sockaddr_nl(netlink, 0, -1)),
    ok = gen_socket:input_event(RtNl, true),

    ok = gen_socket:setsockopt(RtNl, sol_socket, sndbuf, 32768),
    ok = rcvbufsiz(RtNl, 128 * 1024),

    ok = setsockopt(RtNl, sol_netlink, netlink_add_membership, rtnlgrp_link),
    ok = setsockopt(RtNl, sol_netlink, netlink_add_membership, rtnlgrp_notify),
    ok = setsockopt(RtNl, sol_netlink, netlink_add_membership, rtnlgrp_neigh),
    ok = setsockopt(RtNl, sol_netlink, netlink_add_membership, rtnlgrp_ipv4_ifaddr),
    ok = setsockopt(RtNl, sol_netlink, netlink_add_membership, rtnlgrp_ipv4_route),
    ok = setsockopt(RtNl, sol_netlink, netlink_add_membership, rtnlgrp_ipv6_ifaddr),
    ok = setsockopt(RtNl, sol_netlink, netlink_add_membership, rtnlgrp_ipv6_route),

    {ok, #state{
        ct = CtNl, rt = RtNl,
        requests = gb_trees:empty()
    }}.

handle_call({subscribe, #subscription{pid = Pid} = Subscription}, _From, #state{subscribers = Sub} = State) ->
    case lists:keymember(Pid, #subscription.pid, Sub) of
        true ->
            NewSub = lists:keyreplace(Pid, #subscription.pid, Sub, Subscription),
            {reply, ok, State#state{subscribers = NewSub}};
        false ->
            io:format("~p:Subscribe ~p~n", [?MODULE, Pid]),
            monitor(process, Pid),
            {reply, ok, State#state{subscribers = [Subscription|Sub]}}
    end;

handle_call({request, rt, Msg}, From, #state{rt = RtNl, curseq = Seq} = State) ->
    Req = nl_rt_enc(prepare_request(Msg, Seq)),
    NewState = register_request(Seq, From, State),
    gen_socket:send(RtNl, Req),
    {noreply, NewState};

handle_call({request, ct, Msg}, From, #state{ct = CtNl, curseq = Seq} = State) ->
    Req = nl_ct_enc(prepare_request(Msg, Seq)),
    NewState = register_request(Seq, From, State),
    gen_socket:send(CtNl, Req),
    {noreply, NewState}.

handle_cast({send, rt, Msg}, #state{rt = RtNl} = State) ->
    gen_socket:send(RtNl, Msg),
    {noreply, State};

handle_cast({send, ct, Msg}, #state{ct = CtNl} = State) ->
    gen_socket:send(CtNl, Msg),
    {noreply, State};

handle_cast(stop, State) ->
	{stop, normal, State}.

handle_info({Socket, input_ready}, #state{ct = Socket} = State0) ->
    State = handle_socket_data(Socket, ct, ctnetlink, fun nl_ct_dec/1, State0),
    ok = gen_socket:input_event(Socket, true),
    {noreply, State};

handle_info({Socket, input_ready}, #state{rt = Socket} = State0) ->
    State = handle_socket_data(Socket, rt, rtnetlink, fun nl_rt_dec/1, State0),
    ok = gen_socket:input_event(Socket, true),
    {noreply, State};

handle_info({Socket, input_ready}, State0) ->
    State = handle_socket_data(Socket, {s, Socket}, raw, fun(X) -> {Socket, X} end, State0),
    ok = gen_socket:input_event(Socket, true),
    {noreply, State};

handle_info({'DOWN', _Ref, process, Pid, _Reason}, #state{subscribers = Sub} = State) ->
    io:format("~p:Unsubscribe ~p~n", [?MODULE, Pid]),
    {noreply, State#state{subscribers = lists:delete(Pid, Sub)}};

handle_info(Msg, State) ->
    io:format("got Message ~p~n", [Msg]),
    {noreply, State}.

terminate(Reason, _State) ->
    io:format("~p terminate:~p~n", [?MODULE, Reason]),
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

handle_socket_data(Socket, NlType, SubscriptionType, Decode, #state{subscribers = Sub} = State) ->
    case gen_socket:recvfrom(Socket, 128 * 1024) of
	{ok, _Sender, Data} ->
	    %%  io:format("~p got: ~p~n", [NlType, Decode(Data)]),
	    Subs = lists:filter(fun(Elem) ->
					lists:member(NlType, Elem#subscription.types)
				end, Sub),
	    handle_messages(SubscriptionType, Decode(Data), Subs, State);

	Other ->
	    io:format("~p: ~p~n", [NlType, Other]),
	    State
    end.

%%
%% gen_server internal functions
%%

notify(_SubSys, _Pids, []) ->
    ok;
notify(SubSys, Pids, Msgs) ->
    lists:foreach(fun(Pid) -> Pid#subscription.pid ! {SubSys, Msgs} end, Pids).

-spec process_maybe_multipart(InputMsgs :: [netlink_record() | #netlink{}],
                              MsgBuf    :: [netlink_record()]) ->
        {incomplete, NewMsgBuf :: [netlink_record()]} |
        {done, MsgGrp :: [netlink_record()], RestInput :: [netlink_record() | #netlink{}]}.

process_maybe_multipart([], MsgBuf) ->
    {incomplete, MsgBuf};
process_maybe_multipart([Msg | Rest], MsgBuf) ->
    Type = element(2, Msg),     % Msg may be arbitrary netlink record
    Flags = element(3, Msg),
    MsgSeq = element(4, Msg),

    case Type of
        done ->
            {done, MsgSeq, lists:reverse(MsgBuf), Rest};
        _ ->
            case proplists:get_bool(multi, Flags) of
                false -> {done, MsgSeq, [Msg], Rest};
                true  -> process_maybe_multipart(Rest, [Msg | MsgBuf])
            end
    end.

-spec handle_messages(atom(), InputMsgs :: [netlink_record() | #netlink{}],
                      [#subscription{}], #state{}) -> #state{}.

handle_messages(raw, Msg, Subs, State) ->
    spawn(?MODULE, notify, [s, Subs, Msg]),
    State;
handle_messages(_SubSys, [], _Subs, State) ->
    State#state{msgbuf = []};
handle_messages(SubSys, Msgs, Subs, State) ->
    case process_maybe_multipart(Msgs, State#state.msgbuf) of
        {incomplete, MsgBuf} ->
            State#state{msgbuf = MsgBuf};
        {done, MsgSeq, MsgGrp, Rest} ->
            NewState = case is_request_reply(MsgSeq, State) of
                true  -> send_request_reply(MsgSeq, MsgGrp, State);
                false -> spawn(?MODULE, notify, [SubSys, Subs, MsgGrp]),
                         State
            end,
            handle_messages(SubSys, Rest, Subs, NewState#state{msgbuf = []})
    end.

-spec prepare_request(netlink_record(), non_neg_integer()) -> netlink_record().
prepare_request(Msg0, Seq) ->
    % Msg0 may be arbitrary netlink record
    Flags = element(3, Msg0),
    Msg1 = setelement(3, Msg0, [request | Flags]),
    setelement(4, Msg1, Seq).

register_request(Seq, From, #state{requests = Requests} = State) ->
    NextSeq = case (Seq + 1) rem 16#FFFFFFFF of
        0 -> 16#FF;
        X -> X
    end,
    State#state{
        requests = gb_trees:insert(Seq, From, Requests),
        curseq = NextSeq
    }.

-spec is_request_reply(integer(), #state{}) -> boolean().
is_request_reply(MsgSeq, #state{requests = Request}) ->
    gb_trees:is_defined(MsgSeq, Request).

-spec send_request_reply(integer(), [netlink_record(), ...], #state{}) -> #state{}.
send_request_reply(MsgSeq, Reply, #state{requests = Requests} = State) ->
    From = gb_trees:get(MsgSeq, Requests),

    gen_server:reply(From, {ok, Reply}),
    State#state{requests = gb_trees:delete(MsgSeq, Requests)}.

socket(Family, Type, Protocol, Opts) ->
    case proplists:get_value(netns, Opts) of
	undefined ->
	    gen_socket:socket(Family, Type, Protocol);
	NetNs ->
	    gen_socket:socketat(NetNs, Family, Type, Protocol)
    end.
