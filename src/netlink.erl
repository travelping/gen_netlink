%% Copyright 2010-2012, Travelping GmbH <info@travelping.com>

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

-export([start/0, start_link/0, stop/0]).
-export([subscribe/2, send/2, request/2]).

-export([init/1, handle_info/2, handle_cast/2, handle_call/3, terminate/2, code_change/3]).

-export([nl_ct_dec_udp/1, nl_ct_dec/1, nl_rt_dec_udp/1, nl_rt_dec/1,
		 nl_rt_enc/1, nl_ct_enc/1,
		 dec_netlink/2,
		 create_table/0, gen_const/1, define_consts/0, enc_nlmsghdr/5, rtnl_wilddump/2]).
-export([sockaddr_nl/3, setsockoption/4]).
-export([rcvbufsiz/2]).
-export([notify/3]).

-include_lib("gen_socket/include/gen_socket.hrl").
-include("netlink.hrl").

-define(TAB, ?MODULE).

-record(subscription, {
    pid                 :: pid(),
    types               :: [ct | rt | s]
}).

-record(state, {
    subscribers = []    :: [#subscription{}],
    ct                  :: gen_udp:socket(),
    rt                  :: gen_udp:socket(),

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

create_table() ->
    ets:new(?TAB, [named_table, public]).

emit_enum(Type, _Cnt, C, {flag, X}) when is_integer(X) ->
    ets:insert(?TAB, {{Type, X}, C, flag}),
    ets:insert(?TAB, {{Type, C}, X, flag});
emit_enum(Type, Cnt, C, DType) ->
    ets:insert(?TAB, {{Type, Cnt}, C, DType}),
    ets:insert(?TAB, {{Type, C}, Cnt, DType}).

emit_enums(Type, Cnt, [{C, DType}|T]) ->
    emit_enum(Type, Cnt, C, DType),
    emit_enums(Type, Cnt + 1, T);
emit_enums(_, _, []) ->
    ok.

gen_const([{Type, Consts}|T]) ->
    emit_enums(Type, 0, Consts),
    gen_const(T);
gen_const([]) ->
    ok.

define_consts() ->
    [{rtm_msgtype, [
                    {noop,         {flag, ?NLMSG_NOOP}},
                    {error,        {flag, ?NLMSG_ERROR}},
                    {done,         {flag, ?NLMSG_DONE}},
                    {overrun,      {flag, ?NLMSG_OVERRUN}},
                    {newlink,      {flag, ?RTM_NEWLINK}},
                    {dellink,      {flag, ?RTM_DELLINK}},
                    {getlink,      {flag, ?RTM_GETLINK}},
                    {setlink,      {flag, ?RTM_SETLINK}},
                    {newaddr,      {flag, ?RTM_NEWADDR}},
                    {deladdr,      {flag, ?RTM_DELADDR}},
                    {getaddr,      {flag, ?RTM_GETADDR}},
                    {newroute,     {flag, ?RTM_NEWROUTE}},
                    {delroute,     {flag, ?RTM_DELROUTE}},
                    {getroute,     {flag, ?RTM_GETROUTE}},
                    {newneigh,     {flag, ?RTM_NEWNEIGH}},
                    {delneigh,     {flag, ?RTM_DELNEIGH}},
                    {getneigh,     {flag, ?RTM_GETNEIGH}},
                    {newrule,      {flag, ?RTM_NEWRULE}},
                    {delrule,      {flag, ?RTM_DELRULE}},
                    {getrule,      {flag, ?RTM_GETRULE}},
                    {newqdisc,     {flag, ?RTM_NEWQDISC}},
                    {delqdisc,     {flag, ?RTM_DELQDISC}},
                    {getqdisc,     {flag, ?RTM_GETQDISC}},
                    {newtclass,    {flag, ?RTM_NEWTCLASS}},
                    {deltclass,    {flag, ?RTM_DELTCLASS}},
                    {gettclass,    {flag, ?RTM_GETTCLASS}},
                    {newtfilter,   {flag, ?RTM_NEWTFILTER}},
                    {deltfilter,   {flag, ?RTM_DELTFILTER}},
                    {gettfilter,   {flag, ?RTM_GETTFILTER}},
                    {newaction,    {flag, ?RTM_NEWACTION}},
                    {delaction,    {flag, ?RTM_DELACTION}},
                    {getaction,    {flag, ?RTM_GETACTION}},
                    {newprefix,    {flag, ?RTM_NEWPREFIX}},
                    {getmulticast, {flag, ?RTM_GETMULTICAST}},
                    {getanycast,   {flag, ?RTM_GETANYCAST}},
                    {newneightbl,  {flag, ?RTM_NEWNEIGHTBL}},
                    {getneightbl,  {flag, ?RTM_GETNEIGHTBL}},
                    {setneightbl,  {flag, ?RTM_SETNEIGHTBL}},
                    {newnduseropt, {flag, ?RTM_NEWNDUSEROPT}},
                    {newaddrlabel, {flag, ?RTM_NEWADDRLABEL}},
                    {deladdrlabel, {flag, ?RTM_DELADDRLABEL}},
                    {getaddrlabel, {flag, ?RTM_GETADDRLABEL}},
                    {getdcb,       {flag, ?RTM_GETDCB}},
                    {setdcb,       {flag, ?RTM_SETDCB}}
                 ]},
     {nlm_flags, [
                  {request, {flag,  0}},
                  {multi,   {flag,  1}},
                  {ack,     {flag,  2}},
                  {echo,    {flag,  3}}
                 ]},
     {nlm_get_flags, [
                      {request, {flag,  0}},
                      {multi,   {flag,  1}},
                      {ack,     {flag,  2}},
                      {echo,    {flag,  3}},
                      {root,    {flag,  8}},
                      {match,   {flag,  9}},
                      {atomic,  {flag, 10}}
                 ]},
     {nlm_new_flags, [
                      {request, {flag,  0}},
                      {multi,   {flag,  1}},
                      {ack,     {flag,  2}},
                      {echo,    {flag,  3}},
                      {replace, {flag,  8}},
                      {excl,    {flag,  9}},
                      {create,  {flag, 10}},
                      {append,  {flag, 11}}
                 ]},
     {iff_flags, [
                    {up, flag},
                    {broadcast, flag},
                    {debug, flag},
                    {loopback, flag},
                    {pointopoint, flag},
                    {notrailers, flag},
                    {running, flag},
                    {noarp, flag},
                    {promisc, flag},
                    {allmulti, flag},
                    {master, flag},
                    {slave, flag},
                    {multicast, flag},
                    {portsel, flag},
                    {automedia, flag},
                    {dynamic, flag},
                    {lower_up, flag},
                    {dormant, flag},
                    {echo, flag}
                 ]},
	 {{ctm_msgtype, netlink}, [
							{noop,         {flag, ?NLMSG_NOOP}},
							{error,        {flag, ?NLMSG_ERROR}},
							{done,         {flag, ?NLMSG_DONE}},
							{overrun,      {flag, ?NLMSG_OVERRUN}}
						   ]},
	 {{ctm_msgtype, ctnetlink}, [
								 {new,         {flag, ?IPCTNL_MSG_CT_NEW}},
								 {get,         {flag, ?IPCTNL_MSG_CT_GET}},
								 {delete,      {flag, ?IPCTNL_MSG_CT_DELETE}},
								 {get_ctrzero, {flag, ?IPCTNL_MSG_CT_GET_CTRZERO}}
								]},
	 {{ctm_msgtype, ctnetlink_exp}, [
									 {new,         {flag, ?IPCTNL_MSG_EXP_NEW}},
									 {get,         {flag, ?IPCTNL_MSG_EXP_GET}},
									 {delete,      {flag, ?IPCTNL_MSG_EXP_DELETE}}
									]},
     {{ctnetlink}, [
                    {unspec, none},
                    {tuple_orig, tuple},
                    {tuple_reply, tuple},
                    {status, flag32},
                    {protoinfo, protoinfo},
                    {help, help},
                    {nat_src, none},
                    {timeout, uint32},
                    {mark, uint32},
                    {counters_orig, counters},
                    {counters_reply, counters},
                    {use, uint32},
                    {id, uint32},
                    {nat_dst, none},
                    {tuple_master, tuple},
                    {nat_seq_adj_orig, nat_seq_adj},
                    {nat_seq_adj_reply, nat_seq_adj},
                    {secmark, uint32},                    %% obsolete sine 2.6.36....?
					{zone, uint16},
					{secctx, none},
					{timestamp, timestamp}
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
                               {v4_src, addr},
                               {v4_dst, addr},
                               {v6_src, addr},
                               {v6_dst, addr}
                              ]},
     {{ctnetlink, tuple, proto}, [
                                  {unspec, none},
                                  {num, protocol},
                                  {src_port, uint16},
                                  {dst_port, uint16},
                                  {icmp_id, uint16},
                                  {icmp_type, uint8},
                                  {icmp_code, uint8},
                                  {icmpv6_id, none},
                                  {icmpv6_type, none},
                                  {icmpv6_code, none}
                              ]},
	 {{ctnetlink, nat_seq_adj}, [
								 {unspec, none},
								 {correction_pos, uint32},
								 {offset_before, uint32},
								 {offset_after, uint32}
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
                                           {none, flag},
                                           {syn_sent, flag},
                                           {syn_recv, flag},
                                           {established, flag},
                                           {fin_wait, flag},
                                           {close_wait, flag},
                                           {last_ack, flag},
                                           {time_wait, flag},
                                           {close, flag},
                                           {listen, flag},
                                           {max, flag},
                                           {ignore, flag}
                                          ]},
     {{ctnetlink, help}, [
						  {unspec, none},
						  {name, string}
						 ]},
     {{ctnetlink, counters}, [
                              {unspec, none},
                              {packets, uint64},
                              {bytes, uint64},
                              {packets32, uint32},
                              {bytes32, uint32}
                             ]},
     {{ctnetlink, timestamp}, [
						  {unspec, none},
						  {start, uint64},
						  {stop, uint64}
						 ]},
     {{ctnetlink_exp}, [
						{unspec, none},
						{master, tuple},
						{tuple, tuple},
						{mask, tuple},
						{timeout, uint32},
						{id, uint32},
						{help_name, string},
						{zone, uint16},
						{flags, flag32}
					   ]},
     {{ctnetlink_exp, tuple}, [
                {unspec, none},
                {ip, ip},
                {proto, proto}
               ]},
     {{ctnetlink_exp, tuple, ip}, [
                               {unspec, none},
                               {v4_src, addr},
                               {v4_dst, addr},
                               {v6_src, addr},
                               {v6_dst, addr}
                              ]},
     {{ctnetlink_exp, tuple, proto}, [
                                  {unspec, none},
                                  {num, protocol},
                                  {src_port, uint16},
                                  {dst_port, uint16},
                                  {icmp_id, uint16},
                                  {icmp_type, uint8},
                                  {icmp_code, uint8},
                                  {icmpv6_id, none},
                                  {icmpv6_type, none},
                                  {icmpv6_code, none}
                              ]},
     {{ctnetlink_exp, flags}, [
                            {permanent, flag},
                            {inactive, flag},
                            {userspace, flag}
                          ]},
      {{rtnetlink, neigh}, [
                           {unspec, none},
                           {dst, addr},
                           {lladdr, mac},
                           {cacheinfo, huint32_array},
                           {probes, huint32}
                 ]},
     {{rtnetlink, rtm_type}, [
							  {unspec,      flag},
							  {unicast,     flag},
							  {local,       flag},
							  {broadcast,   flag},
							  {anycast,     flag},
							  {multicast,   flag},
							  {blackhole,   flag},
							  {unreachable, flag},
							  {prohibit,    flag},
							  {throw,       flag},
							  {nat,         flag},
							  {xresolve,    flag}
							 ]},
	 {{rtnetlink, rtm_protocol}, [
								  {unspec,   {flag, 0}},
								  {redirect, {flag, 1}},
								  {kernel,   {flag, 2}},
								  {boot,     {flag, 3}},
								  {static,   {flag, 4}},
								  {gated,    {flag, 8}},
								  {ra,       {flag, 9}},
								  {mrt,      {flag, 10}},
								  {zebra,    {flag, 11}},
								  {bird,     {flag, 12}},
								  {dnrouted, {flag, 13}},
								  {xorp,     {flag, 14}},
								  {ntk,      {flag, 15}},
								  {dhcp,     {flag, 16}}
							 ]},
	 {{rtnetlink, rtm_scope}, [
							   {universe, {flag, 0}},
							   {site,     {flag, 200}},
							   {link,     {flag, 253}},
							   {host,     {flag, 254}},
							   {nowhere,  {flag, 255}}
							  ]},
	 {{rtnetlink, rtm_flags}, [
							   {notify,   {flag, 16#100}},
							   {cloned,   {flag, 16#200}},
							   {equalize, {flag, 16#400}},
							   {prefix,   {flag, 16#800}}
							  ]},
	 {{rtnetlink, rtm_table}, [
							   {unspec,  {flag, 0}},
							   {compat,  {flag, 252}},
							   {default, {flag, 253}},
							   {main,    {flag, 254}},
							   {local,   {flag, 255}}
							 ]},
     {{rtnetlink, route}, [
                           {unspec, none},
                           {dst, addr},
                           {src, addr},
                           {iif, huint32},
                           {oif, huint32},
                           {gateway, addr},
                           {priority, huint32},
                           {prefsrc, addr},
                           {metrics, {nested, metrics}},
                           {multipath, none},
                           {protoinfo, none},
                           {flow, huint32},
                           {cacheinfo, huint32_array},
                           {session, none},
                           {mp_algo, none},
                           {table, huint32}
                          ]},
     {{rtnetlink, route, metrics}, [
                                    {unspec, none},
                                    {lock, huint32},
                                    {mtu, huint32},
                                    {window, huint32},
                                    {rtt, huint32},
                                    {rttvar, huint32},
                                    {ssthresh, huint32},
                                    {cwnd, huint32},
                                    {advmss, huint32},
                                    {reordering, huint32},
                                    {hoplimit, huint32},
                                    {initcwnd, huint32},
                                    {features, huint32},
                                    {rto_min, huint32},
                                    {initrwnd, huint32}
                          ]},
     {{rtnetlink, addr}, [
                                {unspec, none},
                                {address, addr},
                                {local, addr},
                                {label, string},
                                {broadcast, addr},
                                {anycast, addr},
                                {cacheinfo, huint32_array},
                                {multicast, addr}
                               ]},
     {{rtnetlink, link}, [
                          {unspec, none},
                          {address, mac},
                          {broadcast, mac},
                          {ifname, string},
                          {mtu, huint32},
                          {link, huint32},
                          {qdisc, string},
                          {stats, huint32_array},
                          {cost, none},
                          {priority, none},
                          {master, none},
                          {wireless, none},
                          {protinfo, {nested, protinfo}},
                          {txqlen, huint32},
                          {map, if_map},
                          {weight, none},
                          {operstate, atom},
                          {linkmode, atom},
                          {linkinfo, {nested, linkinfo}},
                          {net_ns_pid, none},
                          {ifalias, string},
                          {num_vf, huint32},
                          {vfinfo_list, none},
                          {stats64, huint64_array},
                          {vf_ports, none}
                         ]},
     {{rtnetlink, link, operstate}, [
                                     {unknown, atom},
                                     {notpresent, atom},
                                     {down, atom},
                                     {lowerlayerdown, atom},
                                     {testing, atom},
                                     {dormant, atom},
                                     {up, atom}
                                    ]},
     {{rtnetlink, link, linkmode}, [
                                     {default, atom},
                                     {dormant, atom}
                                    ]},
     {{rtnetlink, link, linkinfo}, [
                                    {unspec, none},
                                    {kind, string},
                                    {data, binary},
                                    {xstats, binary}
                                    ]},
     {{rtnetlink, link, protinfo, inet6}, [
                                            {unspec, none},
                                            {flags, hflag32},
                                            {conf, hsint32_array},
                                            {stats, huint64_array},
                                            {mcast, none},
                                            {cacheinfo, huint32_array},
                                            {icmp6stats, huint64_array}
                                           ]},
     {{rtnetlink, link, protinfo, inet6, flags}, [
                                                  {rs_sent, {flag, 4}},
                                                  {ra_rcvd, {flag, 5}},
                                                  {ra_managed, {flag, 6}},
                                                  {ra_othercon, {flag, 7}},
                                                  {ready, {flag, 31}}
                                                 ]},
     {{rtnetlink, prefix}, [
                            {unspec, none},
                            {address, addr},
                            {cacheinfo, huint32_array}
                           ]}
    ].


dec_netlink(Type, Attr) ->
    case ets:lookup(?TAB, {Type, Attr}) of
        [{_, Id, DType}] -> {Id, DType};
        _ -> {none, none}
    end.

dec_rtm_msgtype(Type) ->
    {MsgType, _} = dec_netlink(rtm_msgtype, Type),
    MsgType.

dec_rtm_type(RtmType) ->
    {Type, _} = dec_netlink({rtnetlink, rtm_type}, RtmType),
    Type.

dec_rtm_protocol(RtmProto) ->
    case dec_netlink({rtnetlink, rtm_protocol}, RtmProto) of
		{Proto, flag} -> Proto;
		_ -> RtmProto
	end.

dec_rtm_scope(RtmScope) ->
    case dec_netlink({rtnetlink, rtm_scope}, RtmScope) of
		{Scope, flag} -> Scope;
		_ -> RtmScope
	end.

dec_rtm_table(RtmTable) ->
    case dec_netlink({rtnetlink, rtm_table}, RtmTable) of
		{Table, flag} -> Table;
		_ -> RtmTable
	end.

ipctnl_msg(SubSys, Type) ->
	{MsgType, _} = dec_netlink({ctm_msgtype, SubSys}, Type),
    MsgType.

sockaddr_nl(Family, Pid, Groups) ->
    sockaddr_nl({Family, Pid, Groups}).

-spec sockaddr_nl({atom()|integer(),integer(),integer()}) -> binary();
				 (binary()) -> {atom()|integer(),integer(),integer()}.
sockaddr_nl({Family, Pid, Groups}) when is_atom(Family) ->
    sockaddr_nl({gen_socket:family(Family), Pid, Groups});
sockaddr_nl({Family, Pid, Groups}) ->
    << Family:8, 0:8, Pid:32, Groups:32 >>;
sockaddr_nl(<< Family:8, _Pad:8, Pid:32, Groups:32 >>) ->
    {gen_socket:family(Family), Pid, Groups}.

setsockoption(Socket, Level, OptName, Val) when is_atom(Level) ->
    setsockoption(Socket, enc_opt(Level), OptName, Val);
setsockoption(Socket, Level, OptName, Val) when is_atom(OptName) ->
    setsockoption(Socket, Level, enc_opt(OptName), Val);
setsockoption(Socket, Level, OptName, Val) when is_atom(Val) ->
    setsockoption(Socket, Level, OptName, enc_opt(Val));
setsockoption(Socket, Level, OptName, Val) when is_integer(Val) ->
    gen_socket:setsockoption(Socket, Level, OptName, Val).

rcvbufsiz(Socket, BufSiz) ->
    case gen_socket:setsockoption(Socket, sol_socket, so_rcvbufforce, BufSiz) of
	ok -> ok;
	_ -> gen_socket:setsockoption(Socket, sol_socket, so_rcvbuf, BufSiz)
    end.

enc_flags(Type, Flags) ->
	lists:foldl(fun(Flag, R) ->
						{Val,flag} = dec_netlink(Type, Flag),
						R + (1 bsl Val)
				end, 0, Flags).
enc_iff_flags(Flags) ->
	enc_flags(iff_flags, Flags).

dec_flag(_Type, 0, _Cnt, Acc) ->
    Acc;
dec_flag(Type, F, Cnt, Acc) ->
    case F rem 2 of
        1 -> {Flag, _} = dec_netlink(Type, Cnt),
             dec_flag(Type, F bsr 1, Cnt + 1, [Flag | Acc]);
        _ -> dec_flag(Type, F bsr 1, Cnt + 1, Acc)
    end.

dec_flags(Type, Flag) ->
     dec_flag(Type, Flag, 0, []).

dec_iff_flags(Flag) ->
     dec_flags(iff_flags, Flag).

enc_nla(NlaType, Data) ->
	pad_to(4, <<(size(Data)+4):16/native-integer, NlaType:16/native-integer, Data/binary>>).
enc_nla_nested(NlaType, Data) ->
	pad_to(4, <<(size(Data)+4):16/native-integer, (NlaType bor 16#8000):16/native-integer, Data/binary>>).

nl_enc_nl_attr(_Family, Type, NlaType, flag8, false, {_, Flag}) ->
	enc_nla(NlaType, <<(enc_flags(Type, Flag)):8>>);
nl_enc_nl_attr(_Family, Type, NlaType, flag16, false, {_, Flag}) ->
	enc_nla(NlaType, <<(enc_flags(Type, Flag)):16>>);
nl_enc_nl_attr(_Family, Type, NlaType, flag32, false, {_, Flag}) ->
	enc_nla(NlaType, <<(enc_flags(Type, Flag)):32>>);
nl_enc_nl_attr(_Family, Type, NlaType, hflag8, false, {_, Flag}) ->
	enc_nla(NlaType, <<(enc_flags(Type, Flag)):8>>);
nl_enc_nl_attr(_Family, Type, NlaType, hflag16, false, {_, Flag}) ->
	enc_nla(NlaType, <<(enc_flags(Type, Flag)):16/native-integer>>);
nl_enc_nl_attr(_Family, Type, NlaType, hflag32, false, {_, Flag}) ->
	enc_nla(NlaType, <<(enc_flags(Type, Flag)):32/native-integer>>);

nl_enc_nl_attr(_Family, Type, NlaType, atom, false, {_, Atom}) ->
	{Val, _} = dec_netlink(Type, Atom),
	enc_nla(NlaType, <<Val:8>>);
nl_enc_nl_attr(_Family, _Type, NlaType, binary, _Nested, {_, Data}) ->
	enc_nla(NlaType, Data);
nl_enc_nl_attr(_Family, _Type, NlaType, string, false, {_, String}) ->
	enc_nla(NlaType, <<(list_to_binary(String))/binary, 0>>);
nl_enc_nl_attr(_Family, _Type, NlaType, uint8, false, {_, Val}) ->
	enc_nla(NlaType, <<Val:8>>);
nl_enc_nl_attr(_Family, _Type, NlaType, uint16, false, {_, Val}) ->
	enc_nla(NlaType, <<Val:16>>);
nl_enc_nl_attr(_Family, _Type, NlaType, uint32, false, {_, Val}) ->
	enc_nla(NlaType, <<Val:32>>);
nl_enc_nl_attr(_Family, _Type, NlaType, uint64, false, {_, Val}) ->
	enc_nla(NlaType, <<Val:64>>);
nl_enc_nl_attr(_Family, _Type, NlaType, huint16, false, {_, Val}) ->
	enc_nla(NlaType, <<Val:16/native-integer>>);
nl_enc_nl_attr(_Family, _Type, NlaType, huint32, false, {_, Val}) ->
	enc_nla(NlaType, <<Val:32/native-integer>>);
nl_enc_nl_attr(_Family, _Type, NlaType, huint64, false, {_, Val}) ->
	enc_nla(NlaType, <<Val:64/native-integer>>);

nl_enc_nl_attr(_Family, _Type, NlaType, protocol, false, {_, Proto}) ->
	enc_nla(NlaType, <<(gen_socket:protocol(Proto)):8>>);
nl_enc_nl_attr(_Family, _Type, NlaType, mac, false, {_, {A, B, C, D, E, F}}) ->
	enc_nla(NlaType, << A:8, B:8, C:8, D:8, E:8, F:8 >>);
nl_enc_nl_attr(inet, _Type, NlaType, addr, false, {_, {A, B, C, D}}) ->
	enc_nla(NlaType, << A:8, B:8, C:8, D:8 >>);
nl_enc_nl_attr(inet6, _Type, NlaType, addr, false, {_, {A,B,C,D,E,F,G,H}}) ->
	enc_nla(NlaType, <<A:16, B:16, C:16, D:16, E:16, F:16, G:16, H:16>>);

nl_enc_nl_attr(Family, Type, NlaType, protinfo, true, {_, Req}) ->
	io:format("nl_enc_nl_attr (protinfo): ~w ~w ~w~n", [Type, NlaType, Req]),
	enc_nla(NlaType, nl_enc_nla(Family, erlang:append_element(Type, Family), Req));
nl_enc_nl_attr(Family, Type, NlaType, NestedType, true, {_, Req}) ->
	NewType = setelement(size(Type), Type, NestedType),
    io:format("nl_enc_nl_attr (nested #1): ~w ~w ~w ~w ~w~n", [Type, NewType, NlaType, NestedType, Req]),
	enc_nla(NlaType, nl_enc_nla(Family, NewType, Req));

nl_enc_nl_attr(_Family, _Type, NlaType, if_map, false, {_, MemStart, MemEnd, BaseAddr, Irq, Dma, Port}) ->
	%% WARNING: THIS might be broken, compiler specific aligment must be take into consideration
	enc_nla(NlaType, << MemStart:64/native-integer, MemEnd:64/native-integer,
						BaseAddr:64/native-integer, Irq:16/native-integer,
						Dma:8, Port:8, 0:32 >>);

nl_enc_nl_attr(_Family, _Type, NlaType, hsint32_array, false, Req) ->
	enc_nla(NlaType, << <<H:4/native-signed-integer-unit:8>> || H <- tl(tuple_to_list(Req)) >>);
nl_enc_nl_attr(_Family, _Type, NlaType, huint32_array, false, Req) ->
	enc_nla(NlaType, << <<H:4/native-integer-unit:8>> || H <- tl(tuple_to_list(Req)) >>);
nl_enc_nl_attr(_Family, _Type, NlaType, huint64_array, false, Req) ->
	enc_nla(NlaType, << <<H:8/native-integer-unit:8>> || H <- tl(tuple_to_list(Req)) >>);

nl_enc_nl_attr(Family, Type, NlaType, NestedType, Nested, {NType, Req})
  when is_list(Req) ->
	NewType = setelement(size(Type), Type, NestedType),
    io:format("nl_enc_nl_attr (nested #2): ~w ~w ~w ~w ~w ~w~n", [NewType, NlaType, NestedType, Nested, NType, Req]),
	enc_nla_nested(NlaType, nl_enc_nla(Family, NewType, Req));
nl_enc_nl_attr(Family, Type, NlaType, DType, Nested, Data) ->
    io:format("nl_enc_nl_attr (wildcard): ~w, ~w, ~w, ~w, ~w, ~w~n", [Family, Type, NlaType, DType, Nested, Data]),
    {Type, Data}.

nl_dec_nl_attr(_Family, Type, Attr, flag8, false, << Flag:8 >>) ->
    {Attr, dec_flags(Type, Flag)};
nl_dec_nl_attr(_Family, Type, Attr, flag16, false, << Flag:16 >>) ->
    {Attr, dec_flags(Type, Flag)};
nl_dec_nl_attr(_Family, Type, Attr, flag32, false, << Flag:32 >>) ->
    {Attr, dec_flags(Type, Flag)};
nl_dec_nl_attr(_Family, Type, Attr, hflag8, false, << Flag:8 >>) ->
    {Attr, dec_flags(Type, Flag)};
nl_dec_nl_attr(_Family, Type, Attr, hflag16, false, << Flag:16/native-integer >>) ->
    {Attr, dec_flags(Type, Flag)};
nl_dec_nl_attr(_Family, Type, Attr, hflag32, false, << Flag:32/native-integer >>) ->
    {Attr, dec_flags(Type, Flag)};

nl_dec_nl_attr(_Family, Type, Attr, atom, false, << Val:8 >>) ->
    {Atom, _} = dec_netlink(Type, Val),
    {Attr, Atom};
nl_dec_nl_attr(_Family, _Type, Attr, binary, _Nested, Val) ->
    {Attr, Val};
nl_dec_nl_attr(_Family, _Type, Attr, string, false, Val) ->
    {Attr, binary_to_list(binary:part(Val, 0, size(Val) - 1))};
nl_dec_nl_attr(_Family, _Type, Attr, uint8, false, << Val:8 >>) ->
    {Attr, Val};
nl_dec_nl_attr(_Family, _Type, Attr, uint16, false, << Val:16 >>) ->
    {Attr, Val};
nl_dec_nl_attr(_Family, _Type, Attr, uint32, false, << Val:32 >>) ->
    {Attr, Val};
nl_dec_nl_attr(_Family, _Type, Attr, uint64, false, << Val:64 >>) ->
    {Attr, Val};
nl_dec_nl_attr(_Family, _Type, Attr, huint16, false, << Val:16/native-integer >>) ->
    {Attr, Val};
nl_dec_nl_attr(_Family, _Type, Attr, huint32, false, << Val:32/native-integer >>) ->
    {Attr, Val};
nl_dec_nl_attr(_Family, _Type, Attr, huint64, false, << Val:64/native-integer >>) ->
    {Attr, Val};
nl_dec_nl_attr(_Family, _Type, Attr, protocol, false, << Proto:8 >>) ->
    {Attr,  gen_socket:protocol(Proto)};
nl_dec_nl_attr(_Family, _Type, Attr, mac, false, << A:8, B:8, C:8, D:8, E:8, F:8 >>) ->
    {Attr, {A, B, C, D, E, F}};
nl_dec_nl_attr(inet, _Type, Attr, addr, false, << A:8, B:8, C:8, D:8 >>) ->
    {Attr, {A, B, C, D}};
nl_dec_nl_attr(inet6, _Type, Attr, addr, false, <<A:16, B:16, C:16, D:16, E:16, F:16, G:16, H:16>>) ->
    {Attr, {A,B,C,D,E,F,G,H}};

nl_dec_nl_attr(Family, Type, Attr, protinfo, true, Data) ->
    { Attr, nl_dec_nla(Family, erlang:append_element(Type, Family), Data) };
nl_dec_nl_attr(Family, Type, Attr, _NestedType, true, Data) ->
    { Attr, nl_dec_nla(Family, Type, Data) };

nl_dec_nl_attr(_Family, _Type, Attr, if_map, false, << MemStart:64/native-integer, MemEnd:64/native-integer,
                                                       BaseAddr:64/native-integer, Irq:16/native-integer,
                                                       Dma:8, Port:8, _Pad/binary >> = D) ->
	io:format("map: ~w~n", [D]),
	%% WARNING: THIS might be broken, compiler specific aligment must be take into consideration
    {Attr, MemStart, MemEnd, BaseAddr, Irq, Dma, Port};

nl_dec_nl_attr(_Family, _Type, Attr, hsint32_array, false, Data) ->
    list_to_tuple([Attr | [ H || <<H:4/native-signed-integer-unit:8>> <= Data ]]);
nl_dec_nl_attr(_Family, _Type, Attr, huint32_array, false, Data) ->
    list_to_tuple([Attr | [ H || <<H:4/native-integer-unit:8>> <= Data ]]);
nl_dec_nl_attr(_Family, _Type, Attr, huint64_array, false, Data) ->
    list_to_tuple([Attr | [ H || <<H:8/native-integer-unit:8>> <= Data ]]);

nl_dec_nl_attr(_Family, Type, Attr, DType, Nested, Data) ->
    io:format("nl_dec_nl_attr (wildcard): ~p ~p ~p ~p ~p~n", [Type, Attr, DType, Nested, size(Data)]),
    {Type, Data}.

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

nl_dec_nla(Family, Type0, << Len:16/native-integer, NlaType:16/native-integer, Rest/binary >>, Acc) ->
    PLen = Len - 4,
    Padding = pad_len(4, PLen),
    << Data:PLen/bytes, _Pad:Padding/bytes, NewRest/binary >> = Rest,

    {NewAttr, DType} = dec_netlink(Type0, NlaType band 16#7FFF),

    {Nested, DType1} = case DType of
                           {nested, T} -> {true, T};
                           T -> { (NlaType band 16#8000) /= 0, T }
                       end,
    NewType = case Nested of
                  true  -> erlang:append_element(Type0, DType1);
                  false -> erlang:append_element(Type0, NewAttr)
              end,
    H = nl_dec_nl_attr(Family, NewType, NewAttr, DType1, Nested, Data),

    nl_dec_nla(Family, Type0, NewRest, [H | Acc]);

nl_dec_nla(_Family, _Type, << >>, Acc) ->
    lists:reverse(Acc).

nl_dec_nla(Family, Type, Data) ->
    nl_dec_nla(Family, Type, Data, []).

nl_enc_nla(_Family, _Type, [], Acc) ->
    list_to_binary(lists:reverse(Acc));

nl_enc_nla(Family, Type, [Head|Rest], Acc) ->
	io:format("nl_enc_nla: ~w, ~w, ~w~n", [Family, Type, Head]),

	{AttrId, DType} = netlink:dec_netlink(Type, element(1, Head)),
    {Nested, DType1} = case DType of
                           {nested, T} -> {true, T};
                           T -> {false, T}
                       end,

    NewType = erlang:append_element(Type, element(1, Head)),
	io:format("AttrId: ~w, DType: ~w, Nested: ~w, DType1: ~w, NewType: ~w~n", [AttrId, DType, Nested, DType1, NewType]),
    H = nl_enc_nl_attr(Family, NewType, AttrId, DType1, Nested, Head),

	nl_enc_nla(Family, Type, Rest, [H |Acc]).

nl_enc_nla(Family, Type, Req) ->
    nl_enc_nla(Family, Type, Req, []).

nl_enc_payload(Type, _MsgType, {Family, Version, ResId, Req})
  when Type == {ctnetlink}; Type == {ctnetlink_exp} ->
    Fam = gen_socket:family(Family),
	Data = nl_enc_nla(Family, Type, Req),
	<< Fam:8, Version:8, ResId:16/native-integer, Data/binary >>;

nl_enc_payload({rtnetlink}, MsgType, {Family, IfIndex, State, Flags, NdmType, Req})
  when MsgType == newneigh; MsgType == delneigh ->
    Fam = gen_socket:family(Family),
	Data = nl_enc_nla(Family, {rtnetlink,neigh}, Req),
	<< Fam:8, 0:8, 0:16, IfIndex:32/native-signed-integer, State:16/native-integer, Flags:8, NdmType:8, Data/binary >>;

nl_enc_payload({rtnetlink}, MsgType, {Family, PrefixLen, Flags, Scope, Index, Req})
  when MsgType == newaddr; MsgType == deladdr ->
    Fam = gen_socket:family(Family),
    Data = nl_enc_nla(Family, {rtnetlink,addr}, Req),
	<< Fam:8, PrefixLen:8, Flags:8, Scope:8, Index:32/native-integer, Data/binary >>;

nl_enc_payload({rtnetlink}, MsgType, {Family, DstLen, SrcLen, Tos, Table, Protocol, Scope, RtmType, Flags, Req})
  when MsgType == newroute; MsgType == delroute ; MsgType == getroute ->
    Fam = gen_socket:family(Family),
	Proto = gen_socket:protocol(Protocol),
	Data = nl_enc_nla(Family, {rtnetlink,route}, Req),
	<< Fam:8, DstLen:8, SrcLen:8, Tos:8, Table:8, Proto:8, Scope:8, RtmType:8, Flags:32/native-integer, Data/binary >>;

nl_enc_payload({rtnetlink}, MsgType, {Family, Type, Index, Flags, Change, Req})
  when MsgType == newlink; MsgType == dellink ->
	Fam = gen_socket:family(Family),
	Type0 = gen_socket:arphdr(Type),
	Flags0 = enc_iff_flags(Flags),
	Change0 = enc_iff_flags(Change),
	Data = nl_enc_nla(Family, {rtnetlink,link}, Req),
	<<Fam:8, 0:8, Type0:16/native-integer, Index:32/native-integer, Flags0:32/native-integer, Change0:32/native-integer, Data/binary >>;

nl_enc_payload({rtnetlink}, MsgType,{Family, IfIndex, PfxType, PfxLen, Flags, Req})
  when MsgType == newprefix; MsgType == delprefix ->
    Fam = gen_socket:family(Family),
	Data = nl_enc_nla(Family, {rtnetlink,prefix}, Req),
	<< Fam:8, 0:8, 0:16, IfIndex:32/native-signed-integer, PfxType:8, PfxLen:8, Flags:8, 0:8, Data/binary >>;

nl_enc_payload(_, _, Data)
  when is_binary(Data) ->
	Data.

nl_dec_payload(_Type, done, << Length:32/native-integer >>) ->
	Length;

nl_dec_payload(Type, _MsgType, << Family:8, Version:8, ResId:16/native-integer, Data/binary >>)
  when Type == {ctnetlink}; Type == {ctnetlink_exp} ->
    Fam = gen_socket:family(Family),
    { Fam, Version, ResId, nl_dec_nla(Fam, Type, Data) };

nl_dec_payload({rtnetlink}, MsgType, << Family:8, _Pad1:8, _Pad2:16, IfIndex:32/native-signed-integer, State:16/native-integer, Flags:8, NdmType:8, Data/binary >>)
  when MsgType == newneigh; MsgType == delneigh ->
    Fam = gen_socket:family(Family),
    { Fam, IfIndex, State, Flags, NdmType, nl_dec_nla(Fam, {rtnetlink,neigh}, Data) };

nl_dec_payload({rtnetlink}, MsgType, << Family:8, DstLen:8, SrcLen:8, Tos:8, Table:8, Protocol:8, Scope:8, RtmType:8, Flags:32/native-integer, Data/binary >>)
  when MsgType == newroute; MsgType == delroute ->
    Fam = gen_socket:family(Family),
    { Fam, DstLen, SrcLen, Tos, dec_rtm_table(Table), dec_rtm_protocol(Protocol), dec_rtm_scope(Scope), dec_rtm_type(RtmType), dec_flags({rtnetlink, rtm_flags}, Flags), nl_dec_nla(Fam, {rtnetlink,route}, Data) };

nl_dec_payload({rtnetlink}, MsgType, << Family:8, PrefixLen:8, Flags:8, Scope:8, Index:32/native-integer, Data/binary >>)
  when MsgType == newaddr; MsgType == deladdr ->
    Fam = gen_socket:family(Family),
    { Fam, PrefixLen, Flags, Scope, Index, nl_dec_nla(Fam, {rtnetlink,addr}, Data) };

nl_dec_payload({rtnetlink}, MsgType, << Family:8, _Pad:8, Type:16/native-integer, Index:32/native-integer, Flags:32/native-integer, Change:32/native-integer, Data/binary >>)
  when MsgType == newlink; MsgType == dellink ->
    Fam = gen_socket:family(Family),
    { Fam, gen_socket:arphdr(Type), Index, dec_iff_flags(Flags), dec_iff_flags(Change), nl_dec_nla(Fam, {rtnetlink,link}, Data) };

nl_dec_payload({rtnetlink}, MsgType, << Family:8, _Pad1:8, _Pad2:16, IfIndex:32/native-signed-integer, PfxType:8, PfxLen:8, Flags:8, _Pad3:8, Data/binary >>)
  when MsgType == newprefix; MsgType == delprefix ->
    Fam = gen_socket:family(Family),
    { Fam, IfIndex, PfxType, PfxLen, Flags, nl_dec_nla(Fam, {rtnetlink,prefix}, Data) };

nl_dec_payload(_SubSys, _MsgType, Data) ->
    Data.

nlmsg_ok(DataLen, MsgLen) ->
    (DataLen >= 16) and (MsgLen >= 16) and (MsgLen =< DataLen).

nl_ct_dec_udp(<< _IpHdr:5/bytes, Data/binary >>) ->
	nl_ct_dec(Data).

-spec nl_ct_dec(binary()) -> [{'error',_} | #ctnetlink{} | #ctnetlink_exp{}].
nl_ct_dec(Msg) ->
    nl_ct_dec(Msg, []).

nl_ct_dec(<< Len:32/native-integer, Type:16/native-integer, Flags:16/native-integer, Seq:32/native-integer, Pid:32/native-integer, Data/binary >> = Msg, Acc) ->
    {DecodedMsg, Next} = case nlmsg_ok(size(Msg), Len) of
							 true ->
                                 PayLoadLen = Len - 16,
                                 << PayLoad:PayLoadLen/bytes, NextMsg/binary >> = Data,

								 SubSys = nfnl_subsys(Type bsr 8),
								 MsgType = ipctnl_msg(SubSys, Type band 16#00FF),
								 Flags0 = case MsgType of
											  new -> dec_flags(nlm_new_flags, Flags);
											  _   -> dec_flags(nlm_get_flags, Flags)
										  end,
								 {{ SubSys, MsgType, Flags0, Seq, Pid, nl_dec_payload({SubSys}, MsgType, PayLoad) }, NextMsg};
							 _ ->
								 {{ error, format }, << >>}
						 end,
    nl_ct_dec(Next, [DecodedMsg | Acc]);

nl_ct_dec(<< >>, Acc) ->
    lists:reverse(Acc).

nl_rt_dec_udp(<< _IpHdr:5/bytes, Data/binary >>) ->
    nl_rt_dec(Data).

-spec nl_rt_dec(binary()) -> [{'error',_} | #rtnetlink{}].
nl_rt_dec(Msg) ->
    nl_rt_dec(Msg, []).

nl_rt_dec(<< Len:32/native-integer, Type:16/native-integer, Flags:16/native-integer, Seq:32/native-integer, Pid:32/native-integer, Data/binary >> = Msg, Acc) ->
    {DecodedMsg, Next} = case nlmsg_ok(size(Msg), Len) of
                             true ->
                                 PayLoadLen = Len - 16,
                                 << PayLoad:PayLoadLen/bytes, NextMsg/binary >> = Data,
                                 MsgType = dec_rtm_msgtype(Type),
                                 {{ rtnetlink, MsgType, dec_flags(nlm_flags, Flags), Seq, Pid, nl_dec_payload({rtnetlink}, MsgType, PayLoad) }, NextMsg};
                             _ ->
                                 {{ error, format }, << >>}
                 end,
    nl_rt_dec(Next, [DecodedMsg | Acc]);

nl_rt_dec(<< >>, Acc) ->
    lists:reverse(Acc).

enc_flags(Type, [F|T], Ret) ->
    V = case dec_netlink(Type, F) of
            {X, _} when is_integer(X) -> 1 bsl X;
            _ -> 0
        end,
    enc_flags(Type, T, V bor Ret);
enc_flags(_Type, [], Ret) ->
    Ret.

enc_nlmsghdr_flags(Type, Flags) when
      Type == getlink; Type == getaddr; Type == getroute; Type == getneigh;
      Type == getrule; Type == getqdisc; Type == gettclass; Type == gettfilter;
      Type == getaction; Type == getmulticast; Type == getanycast; Type == getneightbl;
      Type == getaddrlabel; Type == getdcb ->
    enc_flags(nlm_get_flags, Flags, 0);
enc_nlmsghdr_flags(Type, Flags) when
      Type == newlink; Type == newaddr; Type == newroute; Type == newneigh;
      Type == newrule; Type == newqdisc; Type == newtclass; Type == newtfilter;
      Type == newaction; Type == newprefix; Type == newneightbl; Type == newnduseropt;
      Type == newaddrlabel ->
    enc_flags(nlm_new_flags, Flags, 0);
enc_nlmsghdr_flags(_Type, Flags) ->
    enc_flags(nlm_flags, Flags, 0).

enc_nlmsghdr(Type, Flags, Seq, Pid, Req) when is_list(Flags) ->
    enc_nlmsghdr(Type, enc_nlmsghdr_flags(Type, Flags), Seq, Pid, Req);
enc_nlmsghdr(Type, Flags, Seq, Pid, Req) when is_atom(Type) ->
    {NumType, _} = dec_netlink(rtm_msgtype, Type),
    enc_nlmsghdr(NumType, Flags, Seq, Pid, Req);
enc_nlmsghdr(Type, Flags, Seq, Pid, Req) when is_integer(Flags), is_binary(Req) ->
    Payload = pad_to(4, Req),
    Len = 16 + byte_size(Payload),
    << Len:32/native-integer, Type:16/native-integer, Flags:16/native-integer, Seq:32/native-integer, Pid:32/native-integer, Payload/binary >>.

nl_rt_enc({rtnetlink, MsgType, Flags, Seq, Pid, PayLoad}) ->
	Data = nl_enc_payload({rtnetlink}, MsgType, PayLoad),
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
	nl_ct_enc({SubSys, ipctnl_msg(SubSys, MsgType), Flags, Seq, Pid, PayLoad});

nl_ct_enc({SubSys, MsgType, Flags, Seq, Pid, PayLoad})
  when is_atom(SubSys), is_integer(MsgType) ->
	Data = nl_enc_payload({SubSys}, MsgType, PayLoad),
	Type = (nfnl_subsys(SubSys) bsl 8) bor MsgType,
	Flags0 = case ipctnl_msg(SubSys, MsgType) of
				 new -> enc_flags(nlm_new_flags, Flags);
				 _ ->   enc_flags(nlm_get_flags, Flags)
			 end,
	enc_nlmsghdr(Type, Flags0, Seq, Pid, Data).

rtnl_wilddump(Family, Type) ->
    NumFamily = gen_socket:family(Family),
    enc_nlmsghdr(Type, [root, match, request], 0, 0, << NumFamily:8 >>).

%%
%% API implementation
%%

start() ->
    gen_server:start({local, ?MODULE}, ?MODULE, [], []).

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

stop() ->
    gen_server:cast(?MODULE, stop).

-spec send(atom(), binary()) -> ok.
send(SubSys, Msg) ->
    gen_server:cast(?MODULE, {send, SubSys, Msg}).

subscribe(Pid, Types) ->
    gen_server:call(?MODULE, {subscribe, #subscription{pid = Pid, types = Types}}).

-spec request(atom(), netlink_record()) -> {ok, [netlink_record(), ...]} | {error, term()}.
request(SubSys, Msg) ->
    gen_server:call(?MODULE, {request, SubSys, Msg}).

%%
%% gen_server callbacks
%%

init(_Args) ->
    create_table(),
    gen_const(define_consts()),

    {ok, CtNl} = gen_socket:socket(netlink, raw, ?NETLINK_NETFILTER),
    ok = gen_socket:bind(CtNl, sockaddr_nl(netlink, 0, -1)),

    ok = gen_socket:setsockoption(CtNl, sol_socket, so_sndbuf, 32768),
    ok = rcvbufsiz(CtNl, 128 * 1024),

    ok = setsockoption(CtNl, sol_netlink, netlink_add_membership, nfnlgrp_conntrack_new),
    ok = setsockoption(CtNl, sol_netlink, netlink_add_membership, nfnlgrp_conntrack_update),
    ok = setsockoption(CtNl, sol_netlink, netlink_add_membership, nfnlgrp_conntrack_destroy),
    ok = setsockoption(CtNl, sol_netlink, netlink_add_membership, nfnlgrp_conntrack_exp_new),
    ok = setsockoption(CtNl, sol_netlink, netlink_add_membership, nfnlgrp_conntrack_exp_update),
    ok = setsockoption(CtNl, sol_netlink, netlink_add_membership, nfnlgrp_conntrack_exp_destroy),

    %% UDP is close enough (connection less, datagram oriented), so we can use the driver from it
    {ok, Ct} = gen_udp:open(0, [binary, {fd, CtNl}]),

    {ok, RtNl} = gen_socket:socket(netlink, raw, ?NETLINK_ROUTE),
    ok = gen_socket:bind(RtNl, sockaddr_nl(netlink, 0, -1)),

    ok = gen_socket:setsockoption(RtNl, sol_socket, so_sndbuf, 32768),
    ok = rcvbufsiz(RtNl, 128 * 1024),

    ok = setsockoption(RtNl, sol_netlink, netlink_add_membership, rtnlgrp_link),
    ok = setsockoption(RtNl, sol_netlink, netlink_add_membership, rtnlgrp_notify),
    ok = setsockoption(RtNl, sol_netlink, netlink_add_membership, rtnlgrp_ipv4_ifaddr),
    ok = setsockoption(RtNl, sol_netlink, netlink_add_membership, rtnlgrp_ipv4_route),

    %% UDP is close enough (connection less, datagram oriented), so we can use the driver from it
    {ok, Rt} = gen_udp:open(0, [binary, {fd, RtNl}]),

    {ok, #state{
        ct = Ct, rt = Rt,
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

handle_call({request, rt, Msg}, From, #state{rt = Rt, curseq = Seq} = State) ->
    Req = nl_rt_enc(prepare_request(Msg, Seq)),
    case inet:getfd(Rt) of
        {ok, Fd} ->
            NewState = register_request(Seq, From, State),
            gen_socket:send(Fd, Req, 0),
            {noreply, NewState};
        _ ->
            {reply, {error, socket}, State}
    end;

handle_call({request, ct, Msg}, From, #state{ct = Ct, curseq = Seq} = State) ->
    Req = nl_ct_enc(prepare_request(Msg, Seq)),
    case inet:getfd(Ct) of
        {ok, Fd} ->
            NewState = register_request(Seq, From, State),
            gen_socket:send(Fd, Req, 0),
            {noreply, NewState};
        _ ->
            {reply, {error, socket}, State}
    end.

handle_cast({send, rt, Msg}, #state{rt = Rt} = State) ->
    R = case inet:getfd(Rt) of
            {ok, Fd} -> gen_socket:send(Fd, Msg, 0);
            _ -> {error, invalid}
        end,
    io:format("Send: ~p~n", [R]),
    {noreply, State};

handle_cast({send, ct, Msg}, #state{ct = Ct} = State) ->
    R = case inet:getfd(Ct) of
            {ok, Fd} -> gen_socket:send(Fd, Msg, 0);
            _ -> {error, invalid}
        end,
    io:format("Send: ~p~n", [R]),
    {noreply, State};

handle_cast(stop, State) ->
	{stop, normal, State}.

handle_info({udp, Ct, _IP, _port, Data}, #state{ct = Ct, rt = _Rt, subscribers = Sub} = State) ->
    %% io:format("got ~p~ndec: ~p~n", [Data, nl_ct_dec_udp(Data)]),
    Subs = lists:filter(fun(Elem) ->
                                lists:member(ct, Elem#subscription.types)
                        end, Sub),
    NewState = handle_messages(ctnetlink, nl_ct_dec_udp(Data), Subs, State),

    {noreply, NewState};

handle_info({udp, Rt, _IP, _Port, Data}, #state{rt = Rt, ct = _Ct, subscribers = Sub} = State) ->
    %% io:format("got ~p~ndec: ~p~n", [Data, nl_rt_dec_udp(Data)]),
    Subs = lists:filter(fun(Elem) ->
                                lists:member(rt, Elem#subscription.types)
                        end, Sub),
    NewState = handle_messages(rtnetlink, nl_rt_dec_udp(Data), Subs, State),

    {noreply, NewState};

handle_info({udp, S, _IP, _Port, _Data}, #state{subscribers = Sub} = State) ->
    %% io:format("got on Socket ~p~n", [S]),
    Subs = lists:filter(fun(Elem) ->
                                lists:member(s, Elem#subscription.types)
                        end, Sub),
    spawn(?MODULE, notify, [s, Subs, S]),
    {noreply, State};

handle_info({'DOWN', _Ref, process, Pid, _Reason}, #state{subscribers = Sub} = State) ->
    io:format("~p:Unsubscribe ~p~n", [?MODULE, Pid]),
    {noreply, State#state{subscribers = lists:delete(Pid, Sub)}};

handle_info(Msg, {_Ct, _Rt} = State) ->
    io:format("got Message ~p~n", [Msg]),
    {noreply, State}.

terminate(Reason, _State) ->
    io:format("~p terminate:~p~n", [?MODULE, Reason]),
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

%%
%% gen_server internal functions
%%

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

    case Type of
        done ->
            {done, lists:reverse(MsgBuf), Rest};
        _ ->
            case proplists:get_bool(multi, Flags) of
                false -> {done, [Msg], Rest};
                true  -> process_maybe_multipart(Rest, [Msg | MsgBuf])
            end
    end.

-spec handle_messages(atom(), InputMsgs :: [netlink_record() | #netlink{}],
                      [#subscription{}], #state{}) -> #state{}.

handle_messages(_SubSys, [], _Subs, State) ->
    State#state{msgbuf = []};
handle_messages(SubSys, Msgs, Subs, State) ->
    case process_maybe_multipart(Msgs, State#state.msgbuf) of
        {incomplete, MsgBuf} ->
            State#state{msgbuf = MsgBuf};
        {done, MsgGrp, Rest} ->
            NewState = case is_request_reply(MsgGrp, State) of
                true  -> send_request_reply(MsgGrp, State);
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

-spec is_request_reply(MaybeReply :: [netlink_record(), ...], #state{}) -> boolean().
is_request_reply([Msg | _Rest], #state{requests = Request}) ->
    MsgSeq = element(4, Msg),
    gb_trees:is_defined(MsgSeq, Request).

-spec send_request_reply([netlink_record(), ...], #state{}) -> #state{}.
send_request_reply([Msg | _Rest] = Reply, #state{requests = Requests} = State) ->
    ReqSeq = element(4, Msg),
    From = gb_trees:get(ReqSeq, Requests),

    gen_server:reply(From, {ok, Reply}),
    State#state{requests = gb_trees:delete(ReqSeq, Requests)}.

