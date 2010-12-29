-module(netlink).

-export([start/0, nl_ct_dec/1, nl_rt_dec/1, dec_netlink/2, create_table/0, gen_const/1, define_consts/0]).

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

%% grep "^-define(NFNL_SUB" src/netlink.erl | awk -F"[(,]" '{ printf "dec_nfnl_subsys(?%s)%*s %s;\n", $2, 32 - length($2), "->", tolower(substr($2,13)) }'
dec_nfnl_subsys(?NFNL_SUBSYS_NONE)              -> none;
dec_nfnl_subsys(?NFNL_SUBSYS_CTNETLINK)         -> ctnetlink;
dec_nfnl_subsys(?NFNL_SUBSYS_CTNETLINK_EXP)     -> ctnetlink_exp;
dec_nfnl_subsys(?NFNL_SUBSYS_QUEUE)             -> queue;
dec_nfnl_subsys(?NFNL_SUBSYS_ULOG)              -> ulog;
dec_nfnl_subsys(?NFNL_SUBSYS_COUNT)             -> count;
dec_nfnl_subsys(SubSys) when is_integer(SubSys) -> SubSys.

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

%% grep "^-define(RTM_" src/netlink.erl | awk -F"[(,]" '{ printf "dec_rtm_msgtype(?%s)%*s %s;\n", $2, 23 - length($2), "->", tolower(substr($2,5)) }'
dec_rtm_msgtype(?RTM_NEWLINK)          -> newlink;
dec_rtm_msgtype(?RTM_DELLINK)          -> dellink;
dec_rtm_msgtype(?RTM_GETLINK)          -> getlink;
dec_rtm_msgtype(?RTM_SETLINK)          -> setlink;
dec_rtm_msgtype(?RTM_NEWADDR)          -> newaddr;
dec_rtm_msgtype(?RTM_DELADDR)          -> deladdr;
dec_rtm_msgtype(?RTM_GETADDR)          -> getaddr;
dec_rtm_msgtype(?RTM_NEWROUTE)         -> newroute;
dec_rtm_msgtype(?RTM_DELROUTE)         -> delroute;
dec_rtm_msgtype(?RTM_GETROUTE)         -> getroute;
dec_rtm_msgtype(?RTM_NEWNEIGH)         -> newneigh;
dec_rtm_msgtype(?RTM_DELNEIGH)         -> delneigh;
dec_rtm_msgtype(?RTM_GETNEIGH)         -> getneigh;
dec_rtm_msgtype(?RTM_NEWRULE)          -> newrule;
dec_rtm_msgtype(?RTM_DELRULE)          -> delrule;
dec_rtm_msgtype(?RTM_GETRULE)          -> getrule;
dec_rtm_msgtype(?RTM_NEWQDISC)         -> newqdisc;
dec_rtm_msgtype(?RTM_DELQDISC)         -> delqdisc;
dec_rtm_msgtype(?RTM_GETQDISC)         -> getqdisc;
dec_rtm_msgtype(?RTM_NEWTCLASS)        -> newtclass;
dec_rtm_msgtype(?RTM_DELTCLASS)        -> deltclass;
dec_rtm_msgtype(?RTM_GETTCLASS)        -> gettclass;
dec_rtm_msgtype(?RTM_NEWTFILTER)       -> newtfilter;
dec_rtm_msgtype(?RTM_DELTFILTER)       -> deltfilter;
dec_rtm_msgtype(?RTM_GETTFILTER)       -> gettfilter;
dec_rtm_msgtype(?RTM_NEWACTION)        -> newaction;
dec_rtm_msgtype(?RTM_DELACTION)        -> delaction;
dec_rtm_msgtype(?RTM_GETACTION)        -> getaction;
dec_rtm_msgtype(?RTM_NEWPREFIX)        -> newprefix;
dec_rtm_msgtype(?RTM_GETMULTICAST)     -> getmulticast;
dec_rtm_msgtype(?RTM_GETANYCAST)       -> getanycast;
dec_rtm_msgtype(?RTM_NEWNEIGHTBL)      -> newneightbl;
dec_rtm_msgtype(?RTM_GETNEIGHTBL)      -> getneightbl;
dec_rtm_msgtype(?RTM_SETNEIGHTBL)      -> setneightbl;
dec_rtm_msgtype(?RTM_NEWNDUSEROPT)     -> newnduseropt;
dec_rtm_msgtype(?RTM_NEWADDRLABEL)     -> newaddrlabel;
dec_rtm_msgtype(?RTM_DELADDRLABEL)     -> deladdrlabel;
dec_rtm_msgtype(?RTM_GETADDRLABEL)     -> getaddrlabel;
dec_rtm_msgtype(?RTM_GETDCB)           -> getdcb;
dec_rtm_msgtype(?RTM_SETDCB)           -> setdcb.

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
    io:format("insert: ~p ~p~n", [Type, Consts]),
    emit_enums(Type, 0, Consts),
    gen_const(T);
gen_const([]) ->
    ok.

define_consts() ->
    [{{iff_flags}, [
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
     {{ctnetlink}, [
                    {unspec, none},
                    {tuple_orig, tuple},
                    {tuple_reply, tuple},
                    {status, flag},
                    {protoinfo, protoinfo},
                    {help, none},
                    {nat_src, none},
                    {timeout, uint32},
                    {mark, uint32},
                    {counters_orig, counters},
                    {counters_reply, counters},
                    {use, none},
                    {id, uint32},
                    {nat_dst, none},
                    {tuple_master, tuple},
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
                                          ]},
     {{ctnetlink, counters}, [
                              {unspec, none},
                              {packets, uint64},
                              {bytes, uint64},
                              {packets32, uint32},
                              {bytes32, uint32}
                             ]},
     {{rtnetlink, neigh}, [
                           {unspec, none},
                           {dst, addr},
                           {lladdr, mac},
                           {cacheinfo, huint32_array},
                           {probes, huint32}
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
                          {linkmode, huint32},
                          {linkinfo, none},
                          {net_ns_pid, none},
                          {ifalias, none},
                          {num_vf, none},
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
     {{rtnetlink, link, protinfo, inet6}, [
                                            {unspec, none},
                                            {flags, hflag},
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
    %% {ok, CtNl} = gen_socket:socket(netlink, raw, ?NETLINK_NETFILTER),
    %% ok = gen_socket:bind(CtNl, sockaddr_nl(netlink, 0, -1)),

    %% ok = gen_socket:setsockoption(CtNl, sol_socket, so_sndbuf, 32768),
    %% ok = gen_socket:setsockoption(CtNl, sol_socket, so_rcvbuf, 32768),

    %% ok = setsockoption(CtNl, sol_netlink, netlink_add_membership, nfnlgrp_conntrack_new),
    %% ok = setsockoption(CtNl, sol_netlink, netlink_add_membership, nfnlgrp_conntrack_update),
    %% ok = setsockoption(CtNl, sol_netlink, netlink_add_membership, nfnlgrp_conntrack_destroy),

    %% %% UDP is close enough (connection less, datagram oriented), so we can use the driver from it
    %% {ok, Ct} = gen_udp:open(0, [binary, {fd, CtNl}]),

    {ok, RtNl} = gen_socket:socket(netlink, raw, ?NETLINK_ROUTE),
    ok = gen_socket:bind(RtNl, sockaddr_nl(netlink, 0, -1)),

    ok = gen_socket:setsockoption(RtNl, sol_socket, so_sndbuf, 32768),
    ok = gen_socket:setsockoption(RtNl, sol_socket, so_rcvbuf, 32768),

    ok = setsockoption(RtNl, sol_netlink, netlink_add_membership, rtnlgrp_link),
    ok = setsockoption(RtNl, sol_netlink, netlink_add_membership, rtnlgrp_notify),
    ok = setsockoption(RtNl, sol_netlink, netlink_add_membership, rtnlgrp_ipv4_ifaddr),
    ok = setsockoption(RtNl, sol_netlink, netlink_add_membership, rtnlgrp_ipv4_route),

    %% UDP is close enough (connection less, datagram oriented), so we can use the driver from it
    {ok, Rt} = gen_udp:open(0, [binary, {fd, RtNl}]),

    loop(undef, Rt).

dec_flag(_Type, 0, _Cnt, Acc) ->
    Acc;
dec_flag(Type, F, Cnt, Acc) ->
    case F rem 2 of
        1 -> {Flag, _} = dec_netlink(Type, Cnt),
             dec_flag(Type, F bsr 1, Cnt + 1, [Flag | Acc]);
        _ -> dec_flag(Type, F bsr 1, Cnt + 1, Acc)
    end.

dec_iff_flags(Flag) ->
     dec_flag({iff_flags}, Flag, 0, []).
                     
nl_dec_nl_attr(_Family, Type, Attr, flag, false, << Flag:8 >>) ->
    {Attr, dec_flag(Type, Flag, 0, [])};
nl_dec_nl_attr(_Family, Type, Attr, flag, false, << Flag:16 >>) ->
    {Attr, dec_flag(Type, Flag, 0, [])};
nl_dec_nl_attr(_Family, Type, Attr, flag, false, << Flag:32 >>) ->
    {Attr, dec_flag(Type, Flag, 0, [])};
nl_dec_nl_attr(_Family, Type, Attr, hflag, false, << Flag:8 >>) ->
    {Attr, dec_flag(Type, Flag, 0, [])};
nl_dec_nl_attr(_Family, Type, Attr, hflag, false, << Flag:16/native-integer >>) ->
    {Attr, dec_flag(Type, Flag, 0, [])};
nl_dec_nl_attr(_Family, Type, Attr, hflag, false, << Flag:32/native-integer >>) ->
    {Attr, dec_flag(Type, Flag, 0, [])};

nl_dec_nl_attr(_Family, Type, Attr, atom, false, << Val:8 >>) ->
    {Atom, _} = dec_netlink(Type, Val),
    {Attr, Atom};
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
                                              Dma:8, Port:8 >>) ->
    {Attr, MemStart, MemEnd, BaseAddr, Irq, Dma, Port};

nl_dec_nl_attr(_Family, _Type, Attr, hsint32_array, false, Data) ->
    list_to_tuple([Attr | [ H || <<H:4/native-signed-integer-unit:8>> <= Data ]]);
nl_dec_nl_attr(_Family, _Type, Attr, huint32_array, false, Data) ->
    list_to_tuple([Attr | [ H || <<H:4/native-integer-unit:8>> <= Data ]]);
nl_dec_nl_attr(_Family, _Type, Attr, huint64_array, false, Data) ->
    list_to_tuple([Attr | [ H || <<H:8/native-integer-unit:8>> <= Data ]]);

nl_dec_nl_attr(_Family, Type, Attr, DType, _NestedType, Data) ->
    io:format("nl_dec_nl_attr (wildcard): ~p ~p ~p~n", [Type, Attr, DType]),
    {Type, Data}.

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
    Acc.

nl_dec_nla(Family, Type, Data) ->
    nl_dec_nla(Family, Type, Data, []).

nl_dec_payload({ctnetlink} = Type, _MsgType, << Family:8, Version:8, ResId:16/native-integer, Data/binary >>) ->
    Fam = gen_socket:family(Family),
    { Fam, Version, ResId, nl_dec_nla(Fam, Type, Data) };

nl_dec_payload({rtnetlink}, MsgType, << Family:8, _Pad1:8, _Pad2:16, IfIndex:32/native-signed-integer, State:16/native-integer, Flags:8, NdmType:8, Data/binary >>) 
  when MsgType == newneigh; MsgType == delneigh ->
    Fam = gen_socket:family(Family),
    { Fam, IfIndex, State, Flags, NdmType, nl_dec_nla(Fam, {rtnetlink,neigh}, Data) };

nl_dec_payload({rtnetlink}, MsgType, << Family:8, DstLen:8, SrcLen:8, Tos:8, Table:8, Protocol:8, Scope:8, RtmType:8, Flags:32/native-integer, Data/binary >>) 
  when MsgType == newroute; MsgType == delroute ->
    Fam = gen_socket:family(Family),
    { Fam, DstLen, SrcLen, Tos, Table, gen_socket:protocol(Protocol), Scope, RtmType, Flags, nl_dec_nla(Fam, {rtnetlink,route}, Data) };

nl_dec_payload({rtnetlink}, MsgType, << Family:8, PrefixLen:8, Flags:8, Scope:8, Index:32/native-integer, Data/binary >>) 
  when MsgType == newaddr; MsgType == deladdr ->
    Fam = gen_socket:family(Family),
    { Fam, PrefixLen, Flags, Scope, Index, nl_dec_nla(Fam, {rtnetlink,addr}, Data) };

nl_dec_payload({rtnetlink}, MsgType, << Family:8, _Pad:8, Type:16/native-integer, Index:32/native-integer, Flags:32/native-integer, Change:32/native-integer, Data/binary >>) 
  when MsgType == newlink; MsgType == dellink ->
    Fam = gen_socket:family(Family),
    { Fam, Type, Index, dec_iff_flags(Flags), dec_iff_flags(Change), nl_dec_nla(Fam, {rtnetlink,link}, Data) };

nl_dec_payload({rtnetlink}, MsgType, << Family:8, _Pad1:8, _Pad2:16, IfIndex:32/native-signed-integer, PfxType:8, PfxLen:8, Flags:8, _Pad3:8, Data/binary >>)
  when MsgType == newprefix; MsgType == delprefix ->
    Fam = gen_socket:family(Family),
    { Fam, IfIndex, PfxType, PfxLen, Flags, nl_dec_nla(Fam, {rtnetlink,prefix}, Data) };

nl_dec_payload(_SubSys, _MsgType, Data) ->
    Data.

nlmsg_ok(DataLen, MsgLen) ->
    (DataLen >= 16) and (MsgLen >= 16) and (MsgLen =< DataLen).

nl_ct_dec(<< _IpHdr:5/bytes, Len:32/native-integer, Type:16/native-integer, Flags:16/native-integer, Seq:32/native-integer, Pid:32/native-integer, Data/binary >> = Msg) ->
    case nlmsg_ok(size(Msg) - 5, Len) of
        true -> 
            SubSys = dec_nfnl_subsys(Type bsr 8),
            MsgType = Type band 16#00FF,
            { SubSys, MsgType, Flags, Seq, Pid, nl_dec_payload({SubSys}, MsgType, Data) };
        _ ->
            { error, format }
    end.

nl_rt_dec(<< _IpHdr:5/bytes, Len:32/native-integer, Type:16/native-integer, Flags:16/native-integer, Seq:32/native-integer, Pid:32/native-integer, Data/binary >> = Msg) ->
    case nlmsg_ok(size(Msg) - 5, Len) of
        true -> 
            MsgType = dec_rtm_msgtype(Type),
            { rtnetlink, MsgType, Flags, Seq, Pid, nl_dec_payload({rtnetlink}, MsgType, Data) };
        _ ->
            { error, format }
    end.

% Echo back whatever data we receive on Socket.
loop(Ct, Rt) ->
    receive
        {udp, Ct, _IP, _port, Data} ->
            io:format("got ~p~ndec: ~p~n", [Data, nl_ct_dec(Data)]);
        {udp, Rt, _IP, _Port, Data} ->
            io:format("got ~p~ndec: ~p~n", [Data, nl_rt_dec(Data)]);
        {udp, S, _IP, _Port, _Data} ->
            io:format("got on Socket ~p~n", [S])
    end,
    loop(Ct, Rt).
