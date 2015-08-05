%%
%% This file is auto-generated. DO NOT EDIT
%%

%% ============================

flag_info_nlm_flags() ->
    [{1,request},{2,multi},{4,ack},{8,echo},{16,dump_intr}].

flag_info_nlm_get_flags() ->
    [{1,request},
     {2,multi},
     {4,ack},
     {8,echo},
     {16,dump_intr},
     {256,root},
     {512,match},
     {1024,atomic}].

flag_info_nlm_new_flags() ->
    [{1,request},
     {2,multi},
     {4,ack},
     {8,echo},
     {16,dump_intr},
     {256,replace},
     {512,excl},
     {1024,create},
     {2048,append}].

flag_info_iff_flags() ->
    [{1,up},
     {2,broadcast},
     {4,debug},
     {8,loopback},
     {16,pointopoint},
     {32,notrailers},
     {64,running},
     {128,noarp},
     {256,promisc},
     {512,allmulti},
     {1024,master},
     {2048,slave},
     {4096,multicast},
     {8192,portsel},
     {16384,automedia},
     {32768,dynamic},
     {65536,lower_up},
     {131072,dormant},
     {262144,echo}].

flag_info_ctnetlink_status() ->
    [{1,expected},
     {2,seen_reply},
     {4,assured},
     {8,confirmed},
     {16,src_nat},
     {32,dst_nat},
     {64,seq_adjust},
     {128,src_nat_done},
     {256,dst_nat_done},
     {512,dying},
     {1024,fixed_timeout}].

flag_info_ctnetlink_exp_flags() ->
    [{1,permanent},{2,inactive},{4,userspace}].

flag_info_rtnetlink_rtm_flags() ->
    [{256,notify},{512,cloned},{1024,equalize},{2048,prefix}].

flag_info_rtnetlink_link_protinfo_inet6_flags() ->
    [{16,rs_sent},
     {32,ra_rcvd},
     {64,ra_managed},
     {128,ra_othercon},
     {2147483648,ready}].

%% ============================

decode_rtm_msgtype(?NLMSG_NOOP) ->
    noop;

decode_rtm_msgtype(?NLMSG_ERROR) ->
    error;

decode_rtm_msgtype(?NLMSG_DONE) ->
    done;

decode_rtm_msgtype(?NLMSG_OVERRUN) ->
    overrun;

decode_rtm_msgtype(?RTM_NEWLINK) ->
    newlink;

decode_rtm_msgtype(?RTM_DELLINK) ->
    dellink;

decode_rtm_msgtype(?RTM_GETLINK) ->
    getlink;

decode_rtm_msgtype(?RTM_SETLINK) ->
    setlink;

decode_rtm_msgtype(?RTM_NEWADDR) ->
    newaddr;

decode_rtm_msgtype(?RTM_DELADDR) ->
    deladdr;

decode_rtm_msgtype(?RTM_GETADDR) ->
    getaddr;

decode_rtm_msgtype(?RTM_NEWROUTE) ->
    newroute;

decode_rtm_msgtype(?RTM_DELROUTE) ->
    delroute;

decode_rtm_msgtype(?RTM_GETROUTE) ->
    getroute;

decode_rtm_msgtype(?RTM_NEWNEIGH) ->
    newneigh;

decode_rtm_msgtype(?RTM_DELNEIGH) ->
    delneigh;

decode_rtm_msgtype(?RTM_GETNEIGH) ->
    getneigh;

decode_rtm_msgtype(?RTM_NEWRULE) ->
    newrule;

decode_rtm_msgtype(?RTM_DELRULE) ->
    delrule;

decode_rtm_msgtype(?RTM_GETRULE) ->
    getrule;

decode_rtm_msgtype(?RTM_NEWQDISC) ->
    newqdisc;

decode_rtm_msgtype(?RTM_DELQDISC) ->
    delqdisc;

decode_rtm_msgtype(?RTM_GETQDISC) ->
    getqdisc;

decode_rtm_msgtype(?RTM_NEWTCLASS) ->
    newtclass;

decode_rtm_msgtype(?RTM_DELTCLASS) ->
    deltclass;

decode_rtm_msgtype(?RTM_GETTCLASS) ->
    gettclass;

decode_rtm_msgtype(?RTM_NEWTFILTER) ->
    newtfilter;

decode_rtm_msgtype(?RTM_DELTFILTER) ->
    deltfilter;

decode_rtm_msgtype(?RTM_GETTFILTER) ->
    gettfilter;

decode_rtm_msgtype(?RTM_NEWACTION) ->
    newaction;

decode_rtm_msgtype(?RTM_DELACTION) ->
    delaction;

decode_rtm_msgtype(?RTM_GETACTION) ->
    getaction;

decode_rtm_msgtype(?RTM_NEWPREFIX) ->
    newprefix;

decode_rtm_msgtype(?RTM_GETMULTICAST) ->
    getmulticast;

decode_rtm_msgtype(?RTM_GETANYCAST) ->
    getanycast;

decode_rtm_msgtype(?RTM_NEWNEIGHTBL) ->
    newneightbl;

decode_rtm_msgtype(?RTM_GETNEIGHTBL) ->
    getneightbl;

decode_rtm_msgtype(?RTM_SETNEIGHTBL) ->
    setneightbl;

decode_rtm_msgtype(?RTM_NEWNDUSEROPT) ->
    newnduseropt;

decode_rtm_msgtype(?RTM_NEWADDRLABEL) ->
    newaddrlabel;

decode_rtm_msgtype(?RTM_DELADDRLABEL) ->
    deladdrlabel;

decode_rtm_msgtype(?RTM_GETADDRLABEL) ->
    getaddrlabel;

decode_rtm_msgtype(?RTM_GETDCB) ->
    getdcb;

decode_rtm_msgtype(?RTM_SETDCB) ->
    setdcb;

decode_rtm_msgtype(Value) ->
    Value.

%% ============================

decode_ctm_msgtype_netlink(?NLMSG_NOOP) ->
    noop;

decode_ctm_msgtype_netlink(?NLMSG_ERROR) ->
    error;

decode_ctm_msgtype_netlink(?NLMSG_DONE) ->
    done;

decode_ctm_msgtype_netlink(?NLMSG_OVERRUN) ->
    overrun;

decode_ctm_msgtype_netlink(Value) ->
    Value.

%% ============================

decode_ctm_msgtype_ctnetlink(?IPCTNL_MSG_CT_NEW) ->
    new;

decode_ctm_msgtype_ctnetlink(?IPCTNL_MSG_CT_GET) ->
    get;

decode_ctm_msgtype_ctnetlink(?IPCTNL_MSG_CT_DELETE) ->
    delete;

decode_ctm_msgtype_ctnetlink(?IPCTNL_MSG_CT_GET_CTRZERO) ->
    get_ctrzero;

decode_ctm_msgtype_ctnetlink(Value) ->
    Value.

%% ============================

decode_ctm_msgtype_ctnetlink_exp(?IPCTNL_MSG_EXP_NEW) ->
    new;

decode_ctm_msgtype_ctnetlink_exp(?IPCTNL_MSG_EXP_GET) ->
    get;

decode_ctm_msgtype_ctnetlink_exp(?IPCTNL_MSG_EXP_DELETE) ->
    delete;

decode_ctm_msgtype_ctnetlink_exp(Value) ->
    Value.

%% ============================

decode_ctnetlink(_Family, 0, Value) ->
    {unspec, decode_none(Value)};

decode_ctnetlink(Family, 1, Value) ->
    {tuple_orig, nl_dec_nla(Family, fun decode_ctnetlink_tuple/3, Value)};

decode_ctnetlink(Family, 2, Value) ->
    {tuple_reply, nl_dec_nla(Family, fun decode_ctnetlink_tuple/3, Value)};

decode_ctnetlink(_Family, 3, <<Value:32>>) ->
    {status, decode_flag(flag_info_ctnetlink_status(), Value)};

decode_ctnetlink(Family, 4, Value) ->
    {protoinfo, nl_dec_nla(Family, fun decode_ctnetlink_protoinfo/3, Value)};

decode_ctnetlink(Family, 5, Value) ->
    {help, nl_dec_nla(Family, fun decode_ctnetlink_help/3, Value)};

decode_ctnetlink(_Family, 6, Value) ->
    {nat_src, decode_none(Value)};

decode_ctnetlink(_Family, 7, Value) ->
    {timeout, decode_uint32(Value)};

decode_ctnetlink(_Family, 8, Value) ->
    {mark, decode_uint32(Value)};

decode_ctnetlink(Family, 9, Value) ->
    {counters_orig, nl_dec_nla(Family, fun decode_ctnetlink_counters/3, Value)};

decode_ctnetlink(Family, 10, Value) ->
    {counters_reply, nl_dec_nla(Family, fun decode_ctnetlink_counters/3, Value)};

decode_ctnetlink(_Family, 11, Value) ->
    {use, decode_uint32(Value)};

decode_ctnetlink(_Family, 12, Value) ->
    {id, decode_uint32(Value)};

decode_ctnetlink(_Family, 13, Value) ->
    {nat_dst, decode_none(Value)};

decode_ctnetlink(Family, 14, Value) ->
    {tuple_master, nl_dec_nla(Family, fun decode_ctnetlink_tuple/3, Value)};

decode_ctnetlink(Family, 15, Value) ->
    {nat_seq_adj_orig, nl_dec_nla(Family, fun decode_ctnetlink_nat_seq_adj/3, Value)};

decode_ctnetlink(Family, 16, Value) ->
    {nat_seq_adj_reply, nl_dec_nla(Family, fun decode_ctnetlink_nat_seq_adj/3, Value)};

decode_ctnetlink(_Family, 17, Value) ->
    {secmark, decode_uint32(Value)};

decode_ctnetlink(_Family, 18, Value) ->
    {zone, decode_uint16(Value)};

decode_ctnetlink(_Family, 19, Value) ->
    {secctx, decode_none(Value)};

decode_ctnetlink(Family, 20, Value) ->
    {timestamp, nl_dec_nla(Family, fun decode_ctnetlink_timestamp/3, Value)};

decode_ctnetlink(_Family, Id, Value) ->
    {Id, Value}.

%% ============================

decode_ctnetlink_tuple(_Family, 0, Value) ->
    {unspec, decode_none(Value)};

decode_ctnetlink_tuple(Family, 1, Value) ->
    {ip, nl_dec_nla(Family, fun decode_ctnetlink_tuple_ip/3, Value)};

decode_ctnetlink_tuple(Family, 2, Value) ->
    {proto, nl_dec_nla(Family, fun decode_ctnetlink_tuple_proto/3, Value)};

decode_ctnetlink_tuple(_Family, Id, Value) ->
    {Id, Value}.

%% ============================

decode_ctnetlink_tuple_ip(_Family, 0, Value) ->
    {unspec, decode_none(Value)};

decode_ctnetlink_tuple_ip(_Family, 1, Value) ->
    {v4_src, decode_addr(Value)};

decode_ctnetlink_tuple_ip(_Family, 2, Value) ->
    {v4_dst, decode_addr(Value)};

decode_ctnetlink_tuple_ip(_Family, 3, Value) ->
    {v6_src, decode_addr(Value)};

decode_ctnetlink_tuple_ip(_Family, 4, Value) ->
    {v6_dst, decode_addr(Value)};

decode_ctnetlink_tuple_ip(_Family, Id, Value) ->
    {Id, Value}.

%% ============================

decode_ctnetlink_tuple_proto(_Family, 0, Value) ->
    {unspec, decode_none(Value)};

decode_ctnetlink_tuple_proto(_Family, 1, Value) ->
    {num, decode_protocol(Value)};

decode_ctnetlink_tuple_proto(_Family, 2, Value) ->
    {src_port, decode_uint16(Value)};

decode_ctnetlink_tuple_proto(_Family, 3, Value) ->
    {dst_port, decode_uint16(Value)};

decode_ctnetlink_tuple_proto(_Family, 4, Value) ->
    {icmp_id, decode_uint16(Value)};

decode_ctnetlink_tuple_proto(_Family, 5, Value) ->
    {icmp_type, decode_uint8(Value)};

decode_ctnetlink_tuple_proto(_Family, 6, Value) ->
    {icmp_code, decode_uint8(Value)};

decode_ctnetlink_tuple_proto(_Family, 7, Value) ->
    {icmpv6_id, decode_none(Value)};

decode_ctnetlink_tuple_proto(_Family, 8, Value) ->
    {icmpv6_type, decode_none(Value)};

decode_ctnetlink_tuple_proto(_Family, 9, Value) ->
    {icmpv6_code, decode_none(Value)};

decode_ctnetlink_tuple_proto(_Family, Id, Value) ->
    {Id, Value}.

%% ============================

decode_ctnetlink_nat_seq_adj(_Family, 0, Value) ->
    {unspec, decode_none(Value)};

decode_ctnetlink_nat_seq_adj(_Family, 1, Value) ->
    {correction_pos, decode_uint32(Value)};

decode_ctnetlink_nat_seq_adj(_Family, 2, Value) ->
    {offset_before, decode_uint32(Value)};

decode_ctnetlink_nat_seq_adj(_Family, 3, Value) ->
    {offset_after, decode_uint32(Value)};

decode_ctnetlink_nat_seq_adj(_Family, Id, Value) ->
    {Id, Value}.

%% ============================

decode_ctnetlink_protoinfo(_Family, 0, Value) ->
    {unspec, decode_none(Value)};

decode_ctnetlink_protoinfo(Family, 1, Value) ->
    {tcp, nl_dec_nla(Family, fun decode_ctnetlink_protoinfo_tcp/3, Value)};

decode_ctnetlink_protoinfo(Family, 2, Value) ->
    {dccp, nl_dec_nla(Family, fun decode_ctnetlink_protoinfo_dccp/3, Value)};

decode_ctnetlink_protoinfo(Family, 3, Value) ->
    {sctp, nl_dec_nla(Family, fun decode_ctnetlink_protoinfo_sctp/3, Value)};

decode_ctnetlink_protoinfo(_Family, Id, Value) ->
    {Id, Value}.

%% ============================

decode_ctnetlink_protoinfo_tcp(_Family, 0, Value) ->
    {unspec, decode_none(Value)};

decode_ctnetlink_protoinfo_tcp(_Family, 1, <<Value:8>>) ->
    {state, decode_ctnetlink_protoinfo_tcp_state(Value)};

decode_ctnetlink_protoinfo_tcp(_Family, 2, Value) ->
    {wscale_original, decode_uint8(Value)};

decode_ctnetlink_protoinfo_tcp(_Family, 3, Value) ->
    {wscale_reply, decode_uint8(Value)};

decode_ctnetlink_protoinfo_tcp(_Family, 4, Value) ->
    {flags_original, decode_uint16(Value)};

decode_ctnetlink_protoinfo_tcp(_Family, 5, Value) ->
    {flags_reply, decode_uint16(Value)};

decode_ctnetlink_protoinfo_tcp(_Family, Id, Value) ->
    {Id, Value}.

%% ============================

decode_ctnetlink_protoinfo_tcp_state(0) ->
    none;

decode_ctnetlink_protoinfo_tcp_state(1) ->
    syn_sent;

decode_ctnetlink_protoinfo_tcp_state(2) ->
    syn_recv;

decode_ctnetlink_protoinfo_tcp_state(3) ->
    established;

decode_ctnetlink_protoinfo_tcp_state(4) ->
    fin_wait;

decode_ctnetlink_protoinfo_tcp_state(5) ->
    close_wait;

decode_ctnetlink_protoinfo_tcp_state(6) ->
    last_ack;

decode_ctnetlink_protoinfo_tcp_state(7) ->
    time_wait;

decode_ctnetlink_protoinfo_tcp_state(8) ->
    close;

decode_ctnetlink_protoinfo_tcp_state(9) ->
    listen;

decode_ctnetlink_protoinfo_tcp_state(10) ->
    max;

decode_ctnetlink_protoinfo_tcp_state(11) ->
    ignore;

decode_ctnetlink_protoinfo_tcp_state(Value) ->
    Value.

%% ============================

decode_ctnetlink_help(_Family, 0, Value) ->
    {unspec, decode_none(Value)};

decode_ctnetlink_help(_Family, 1, Value) ->
    {name, decode_string(Value)};

decode_ctnetlink_help(_Family, Id, Value) ->
    {Id, Value}.

%% ============================

decode_ctnetlink_counters(_Family, 0, Value) ->
    {unspec, decode_none(Value)};

decode_ctnetlink_counters(_Family, 1, Value) ->
    {packets, decode_uint64(Value)};

decode_ctnetlink_counters(_Family, 2, Value) ->
    {bytes, decode_uint64(Value)};

decode_ctnetlink_counters(_Family, 3, Value) ->
    {packets32, decode_uint32(Value)};

decode_ctnetlink_counters(_Family, 4, Value) ->
    {bytes32, decode_uint32(Value)};

decode_ctnetlink_counters(_Family, Id, Value) ->
    {Id, Value}.

%% ============================

decode_ctnetlink_timestamp(_Family, 0, Value) ->
    {unspec, decode_none(Value)};

decode_ctnetlink_timestamp(_Family, 1, Value) ->
    {start, decode_uint64(Value)};

decode_ctnetlink_timestamp(_Family, 2, Value) ->
    {stop, decode_uint64(Value)};

decode_ctnetlink_timestamp(_Family, Id, Value) ->
    {Id, Value}.

%% ============================

decode_ctnetlink_exp(_Family, 0, Value) ->
    {unspec, decode_none(Value)};

decode_ctnetlink_exp(Family, 1, Value) ->
    {master, nl_dec_nla(Family, fun decode_ctnetlink_exp_tuple/3, Value)};

decode_ctnetlink_exp(Family, 2, Value) ->
    {tuple, nl_dec_nla(Family, fun decode_ctnetlink_exp_tuple/3, Value)};

decode_ctnetlink_exp(Family, 3, Value) ->
    {mask, nl_dec_nla(Family, fun decode_ctnetlink_exp_tuple/3, Value)};

decode_ctnetlink_exp(_Family, 4, Value) ->
    {timeout, decode_uint32(Value)};

decode_ctnetlink_exp(_Family, 5, Value) ->
    {id, decode_uint32(Value)};

decode_ctnetlink_exp(_Family, 6, Value) ->
    {help_name, decode_string(Value)};

decode_ctnetlink_exp(_Family, 7, Value) ->
    {zone, decode_uint16(Value)};

decode_ctnetlink_exp(_Family, 8, <<Value:32>>) ->
    {flags, decode_flag(flag_info_ctnetlink_exp_flags(), Value)};

decode_ctnetlink_exp(_Family, Id, Value) ->
    {Id, Value}.

%% ============================

decode_ctnetlink_exp_tuple(_Family, 0, Value) ->
    {unspec, decode_none(Value)};

decode_ctnetlink_exp_tuple(Family, 1, Value) ->
    {ip, nl_dec_nla(Family, fun decode_ctnetlink_exp_tuple_ip/3, Value)};

decode_ctnetlink_exp_tuple(Family, 2, Value) ->
    {proto, nl_dec_nla(Family, fun decode_ctnetlink_exp_tuple_proto/3, Value)};

decode_ctnetlink_exp_tuple(_Family, Id, Value) ->
    {Id, Value}.

%% ============================

decode_ctnetlink_exp_tuple_ip(_Family, 0, Value) ->
    {unspec, decode_none(Value)};

decode_ctnetlink_exp_tuple_ip(_Family, 1, Value) ->
    {v4_src, decode_addr(Value)};

decode_ctnetlink_exp_tuple_ip(_Family, 2, Value) ->
    {v4_dst, decode_addr(Value)};

decode_ctnetlink_exp_tuple_ip(_Family, 3, Value) ->
    {v6_src, decode_addr(Value)};

decode_ctnetlink_exp_tuple_ip(_Family, 4, Value) ->
    {v6_dst, decode_addr(Value)};

decode_ctnetlink_exp_tuple_ip(_Family, Id, Value) ->
    {Id, Value}.

%% ============================

decode_ctnetlink_exp_tuple_proto(_Family, 0, Value) ->
    {unspec, decode_none(Value)};

decode_ctnetlink_exp_tuple_proto(_Family, 1, Value) ->
    {num, decode_protocol(Value)};

decode_ctnetlink_exp_tuple_proto(_Family, 2, Value) ->
    {src_port, decode_uint16(Value)};

decode_ctnetlink_exp_tuple_proto(_Family, 3, Value) ->
    {dst_port, decode_uint16(Value)};

decode_ctnetlink_exp_tuple_proto(_Family, 4, Value) ->
    {icmp_id, decode_uint16(Value)};

decode_ctnetlink_exp_tuple_proto(_Family, 5, Value) ->
    {icmp_type, decode_uint8(Value)};

decode_ctnetlink_exp_tuple_proto(_Family, 6, Value) ->
    {icmp_code, decode_uint8(Value)};

decode_ctnetlink_exp_tuple_proto(_Family, 7, Value) ->
    {icmpv6_id, decode_none(Value)};

decode_ctnetlink_exp_tuple_proto(_Family, 8, Value) ->
    {icmpv6_type, decode_none(Value)};

decode_ctnetlink_exp_tuple_proto(_Family, 9, Value) ->
    {icmpv6_code, decode_none(Value)};

decode_ctnetlink_exp_tuple_proto(_Family, Id, Value) ->
    {Id, Value}.

%% ============================

decode_rtnetlink_neigh(_Family, 0, Value) ->
    {unspec, decode_none(Value)};

decode_rtnetlink_neigh(_Family, 1, Value) ->
    {dst, decode_addr(Value)};

decode_rtnetlink_neigh(_Family, 2, Value) ->
    {lladdr, decode_mac(Value)};

decode_rtnetlink_neigh(_Family, 3, Value) ->
    decode_huint32_array(nda_cacheinfo, Value);

decode_rtnetlink_neigh(_Family, 4, Value) ->
    {probes, decode_huint32(Value)};

decode_rtnetlink_neigh(_Family, Id, Value) ->
    {Id, Value}.

%% ============================

decode_rtnetlink_rtm_type(0) ->
    unspec;

decode_rtnetlink_rtm_type(1) ->
    unicast;

decode_rtnetlink_rtm_type(2) ->
    local;

decode_rtnetlink_rtm_type(3) ->
    broadcast;

decode_rtnetlink_rtm_type(4) ->
    anycast;

decode_rtnetlink_rtm_type(5) ->
    multicast;

decode_rtnetlink_rtm_type(6) ->
    blackhole;

decode_rtnetlink_rtm_type(7) ->
    unreachable;

decode_rtnetlink_rtm_type(8) ->
    prohibit;

decode_rtnetlink_rtm_type(9) ->
    throw;

decode_rtnetlink_rtm_type(10) ->
    nat;

decode_rtnetlink_rtm_type(11) ->
    xresolve;

decode_rtnetlink_rtm_type(Value) ->
    Value.

%% ============================

decode_rtnetlink_rtm_protocol(0) ->
    unspec;

decode_rtnetlink_rtm_protocol(1) ->
    redirect;

decode_rtnetlink_rtm_protocol(2) ->
    kernel;

decode_rtnetlink_rtm_protocol(3) ->
    boot;

decode_rtnetlink_rtm_protocol(4) ->
    static;

decode_rtnetlink_rtm_protocol(8) ->
    gated;

decode_rtnetlink_rtm_protocol(9) ->
    ra;

decode_rtnetlink_rtm_protocol(10) ->
    mrt;

decode_rtnetlink_rtm_protocol(11) ->
    zebra;

decode_rtnetlink_rtm_protocol(12) ->
    bird;

decode_rtnetlink_rtm_protocol(13) ->
    dnrouted;

decode_rtnetlink_rtm_protocol(14) ->
    xorp;

decode_rtnetlink_rtm_protocol(15) ->
    ntk;

decode_rtnetlink_rtm_protocol(16) ->
    dhcp;

decode_rtnetlink_rtm_protocol(Value) ->
    Value.

%% ============================

decode_rtnetlink_rtm_scope(0) ->
    universe;

decode_rtnetlink_rtm_scope(200) ->
    site;

decode_rtnetlink_rtm_scope(253) ->
    link;

decode_rtnetlink_rtm_scope(254) ->
    host;

decode_rtnetlink_rtm_scope(255) ->
    nowhere;

decode_rtnetlink_rtm_scope(Value) ->
    Value.

%% ============================

decode_rtnetlink_rtm_table(0) ->
    unspec;

decode_rtnetlink_rtm_table(252) ->
    compat;

decode_rtnetlink_rtm_table(253) ->
    default;

decode_rtnetlink_rtm_table(254) ->
    main;

decode_rtnetlink_rtm_table(255) ->
    local;

decode_rtnetlink_rtm_table(Value) ->
    Value.

%% ============================

decode_rtnetlink_route(_Family, 0, Value) ->
    {unspec, decode_none(Value)};

decode_rtnetlink_route(_Family, 1, Value) ->
    {dst, decode_addr(Value)};

decode_rtnetlink_route(_Family, 2, Value) ->
    {src, decode_addr(Value)};

decode_rtnetlink_route(_Family, 3, Value) ->
    {iif, decode_huint32(Value)};

decode_rtnetlink_route(_Family, 4, Value) ->
    {oif, decode_huint32(Value)};

decode_rtnetlink_route(_Family, 5, Value) ->
    {gateway, decode_addr(Value)};

decode_rtnetlink_route(_Family, 6, Value) ->
    {priority, decode_huint32(Value)};

decode_rtnetlink_route(_Family, 7, Value) ->
    {prefsrc, decode_addr(Value)};

decode_rtnetlink_route(Family, 8, Value) ->
    {metrics, nl_dec_nla(Family, fun decode_rtnetlink_route_metrics/3, Value)};

decode_rtnetlink_route(_Family, 9, Value) ->
    {multipath, decode_none(Value)};

decode_rtnetlink_route(_Family, 10, Value) ->
    {protoinfo, decode_none(Value)};

decode_rtnetlink_route(_Family, 11, Value) ->
    {flow, decode_huint32(Value)};

decode_rtnetlink_route(_Family, 12, Value) ->
    decode_huint32_array(rta_cacheinfo, Value);

decode_rtnetlink_route(_Family, 13, Value) ->
    {session, decode_none(Value)};

decode_rtnetlink_route(_Family, 14, Value) ->
    {mp_algo, decode_none(Value)};

decode_rtnetlink_route(_Family, 15, Value) ->
    {table, decode_huint32(Value)};

decode_rtnetlink_route(_Family, Id, Value) ->
    {Id, Value}.

%% ============================

decode_rtnetlink_route_metrics(_Family, 0, Value) ->
    {unspec, decode_none(Value)};

decode_rtnetlink_route_metrics(_Family, 1, Value) ->
    {lock, decode_huint32(Value)};

decode_rtnetlink_route_metrics(_Family, 2, Value) ->
    {mtu, decode_huint32(Value)};

decode_rtnetlink_route_metrics(_Family, 3, Value) ->
    {window, decode_huint32(Value)};

decode_rtnetlink_route_metrics(_Family, 4, Value) ->
    {rtt, decode_huint32(Value)};

decode_rtnetlink_route_metrics(_Family, 5, Value) ->
    {rttvar, decode_huint32(Value)};

decode_rtnetlink_route_metrics(_Family, 6, Value) ->
    {ssthresh, decode_huint32(Value)};

decode_rtnetlink_route_metrics(_Family, 7, Value) ->
    {cwnd, decode_huint32(Value)};

decode_rtnetlink_route_metrics(_Family, 8, Value) ->
    {advmss, decode_huint32(Value)};

decode_rtnetlink_route_metrics(_Family, 9, Value) ->
    {reordering, decode_huint32(Value)};

decode_rtnetlink_route_metrics(_Family, 10, Value) ->
    {hoplimit, decode_huint32(Value)};

decode_rtnetlink_route_metrics(_Family, 11, Value) ->
    {initcwnd, decode_huint32(Value)};

decode_rtnetlink_route_metrics(_Family, 12, Value) ->
    {features, decode_huint32(Value)};

decode_rtnetlink_route_metrics(_Family, 13, Value) ->
    {rto_min, decode_huint32(Value)};

decode_rtnetlink_route_metrics(_Family, 14, Value) ->
    {initrwnd, decode_huint32(Value)};

decode_rtnetlink_route_metrics(_Family, Id, Value) ->
    {Id, Value}.

%% ============================

decode_rtnetlink_addr(_Family, 0, Value) ->
    {unspec, decode_none(Value)};

decode_rtnetlink_addr(_Family, 1, Value) ->
    {address, decode_addr(Value)};

decode_rtnetlink_addr(_Family, 2, Value) ->
    {local, decode_addr(Value)};

decode_rtnetlink_addr(_Family, 3, Value) ->
    {label, decode_string(Value)};

decode_rtnetlink_addr(_Family, 4, Value) ->
    {broadcast, decode_addr(Value)};

decode_rtnetlink_addr(_Family, 5, Value) ->
    {anycast, decode_addr(Value)};

decode_rtnetlink_addr(_Family, 6, Value) ->
    decode_huint32_array(ifa_cacheinfo, Value);

decode_rtnetlink_addr(_Family, 7, Value) ->
    {multicast, decode_addr(Value)};

decode_rtnetlink_addr(_Family, Id, Value) ->
    {Id, Value}.

%% ============================

decode_rtnetlink_link(_Family, 0, Value) ->
    {unspec, decode_none(Value)};

decode_rtnetlink_link(_Family, 1, Value) ->
    {address, decode_mac(Value)};

decode_rtnetlink_link(_Family, 2, Value) ->
    {broadcast, decode_mac(Value)};

decode_rtnetlink_link(_Family, 3, Value) ->
    {ifname, decode_string(Value)};

decode_rtnetlink_link(_Family, 4, Value) ->
    {mtu, decode_huint32(Value)};

decode_rtnetlink_link(_Family, 5, Value) ->
    {link, decode_huint32(Value)};

decode_rtnetlink_link(_Family, 6, Value) ->
    {qdisc, decode_string(Value)};

decode_rtnetlink_link(_Family, 7, Value) ->
    decode_huint32_array(stats, Value);

decode_rtnetlink_link(_Family, 8, Value) ->
    {cost, decode_none(Value)};

decode_rtnetlink_link(_Family, 9, Value) ->
    {priority, decode_none(Value)};

decode_rtnetlink_link(_Family, 10, Value) ->
    {master, decode_none(Value)};

decode_rtnetlink_link(_Family, 11, Value) ->
    {wireless, decode_none(Value)};

decode_rtnetlink_link(Family, 12, Value) ->
    {protinfo, nl_dec_nla(Family, fun decode_rtnetlink_link_protinfo/3, Value)};

decode_rtnetlink_link(_Family, 13, Value) ->
    {txqlen, decode_huint32(Value)};

decode_rtnetlink_link(_Family, 14, Value) ->
    decode_if_map(map, Value);

decode_rtnetlink_link(_Family, 15, Value) ->
    {weight, decode_none(Value)};

decode_rtnetlink_link(_Family, 16, <<Value:8>>) ->
    {operstate, decode_rtnetlink_link_operstate(Value)};

decode_rtnetlink_link(_Family, 17, <<Value:8>>) ->
    {linkmode, decode_rtnetlink_link_linkmode(Value)};

decode_rtnetlink_link(Family, 18, Value) ->
    {linkinfo, nl_dec_nla(Family, fun decode_rtnetlink_link_linkinfo/3, Value)};

decode_rtnetlink_link(_Family, 19, Value) ->
    {net_ns_pid, decode_none(Value)};

decode_rtnetlink_link(_Family, 20, Value) ->
    {ifalias, decode_string(Value)};

decode_rtnetlink_link(_Family, 21, Value) ->
    {num_vf, decode_huint32(Value)};

decode_rtnetlink_link(_Family, 22, Value) ->
    {vfinfo_list, decode_none(Value)};

decode_rtnetlink_link(_Family, 23, Value) ->
    decode_huint64_array(stats64, Value);

decode_rtnetlink_link(_Family, 24, Value) ->
    {vf_ports, decode_none(Value)};

decode_rtnetlink_link(_Family, 25, Value) ->
    {port_self, decode_none(Value)};

decode_rtnetlink_link(_Family, 26, Value) ->
    {af_spec, decode_none(Value)};

decode_rtnetlink_link(_Family, 27, Value) ->
    {group, decode_none(Value)};

decode_rtnetlink_link(_Family, 28, Value) ->
    {net_ns_fd, decode_none(Value)};

decode_rtnetlink_link(_Family, 29, Value) ->
    {ext_mask, decode_huint32(Value)};

decode_rtnetlink_link(_Family, 30, Value) ->
    {promiscuity, decode_none(Value)};

decode_rtnetlink_link(_Family, 31, Value) ->
    {num_tx_queues, decode_none(Value)};

decode_rtnetlink_link(_Family, 32, Value) ->
    {num_rx_queues, decode_none(Value)};

decode_rtnetlink_link(_Family, 33, Value) ->
    {carrier, decode_none(Value)};

decode_rtnetlink_link(_Family, 34, Value) ->
    {phys_port_id, decode_none(Value)};

decode_rtnetlink_link(_Family, 35, Value) ->
    {carrier_changes, decode_none(Value)};

decode_rtnetlink_link(_Family, Id, Value) ->
    {Id, Value}.

%% ============================

decode_rtnetlink_link_operstate(0) ->
    unknown;

decode_rtnetlink_link_operstate(1) ->
    notpresent;

decode_rtnetlink_link_operstate(2) ->
    down;

decode_rtnetlink_link_operstate(3) ->
    lowerlayerdown;

decode_rtnetlink_link_operstate(4) ->
    testing;

decode_rtnetlink_link_operstate(5) ->
    dormant;

decode_rtnetlink_link_operstate(6) ->
    up;

decode_rtnetlink_link_operstate(Value) ->
    Value.

%% ============================

decode_rtnetlink_link_linkmode(0) ->
    default;

decode_rtnetlink_link_linkmode(1) ->
    dormant;

decode_rtnetlink_link_linkmode(Value) ->
    Value.

%% ============================

decode_rtnetlink_link_linkinfo(_Family, 0, Value) ->
    {unspec, decode_none(Value)};

decode_rtnetlink_link_linkinfo(_Family, 1, Value) ->
    {kind, decode_string(Value)};

decode_rtnetlink_link_linkinfo(_Family, 2, Value) ->
    {data, decode_binary(Value)};

decode_rtnetlink_link_linkinfo(_Family, 3, Value) ->
    {xstats, decode_binary(Value)};

decode_rtnetlink_link_linkinfo(_Family, Id, Value) ->
    {Id, Value}.

%% ============================

decode_rtnetlink_link_protinfo_inet6(_Family, 0, Value) ->
    {unspec, decode_none(Value)};

decode_rtnetlink_link_protinfo_inet6(_Family, 1, <<Value:32/native-integer>>) ->
    {flags, decode_flag(flag_info_rtnetlink_link_protinfo_inet6_flags(), Value)};

decode_rtnetlink_link_protinfo_inet6(_Family, 2, Value) ->
    decode_hsint32_array(conf, Value);

decode_rtnetlink_link_protinfo_inet6(_Family, 3, Value) ->
    decode_huint64_array(stats, Value);

decode_rtnetlink_link_protinfo_inet6(_Family, 4, Value) ->
    {mcast, decode_none(Value)};

decode_rtnetlink_link_protinfo_inet6(_Family, 5, Value) ->
    decode_huint32_array(ifla_cacheinfo, Value);

decode_rtnetlink_link_protinfo_inet6(_Family, 6, Value) ->
    decode_huint64_array(icmp6stats, Value);

decode_rtnetlink_link_protinfo_inet6(_Family, Id, Value) ->
    {Id, Value}.

%% ============================

decode_rtnetlink_prefix(_Family, 0, Value) ->
    {unspec, decode_none(Value)};

decode_rtnetlink_prefix(_Family, 1, Value) ->
    {address, decode_addr(Value)};

decode_rtnetlink_prefix(_Family, 2, Value) ->
    decode_huint32_array(prefix_cacheinfo, Value);

decode_rtnetlink_prefix(_Family, Id, Value) ->
    {Id, Value}.

%% ============================

decode_ctm_msgtype_queue(?NFQNL_MSG_PACKET) ->
    packet;

decode_ctm_msgtype_queue(?NFQNL_MSG_VERDICT) ->
    verdict;

decode_ctm_msgtype_queue(?NFQNL_MSG_CONFIG) ->
    config;

decode_ctm_msgtype_queue(?NFQNL_MSG_VERDICT_BATCH) ->
    verdict_batch;

decode_ctm_msgtype_queue(Value) ->
    Value.

%% ============================

decode_nfqnl_config_cmd(?NFQNL_CFG_CMD_NONE) ->
    none;

decode_nfqnl_config_cmd(?NFQNL_CFG_CMD_BIND) ->
    bind;

decode_nfqnl_config_cmd(?NFQNL_CFG_CMD_UNBIND) ->
    unbind;

decode_nfqnl_config_cmd(?NFQNL_CFG_CMD_PF_BIND) ->
    pf_bind;

decode_nfqnl_config_cmd(?NFQNL_CFG_CMD_PF_UNBIND) ->
    pf_unbind;

decode_nfqnl_config_cmd(Value) ->
    Value.

%% ============================

decode_nfqnl_cfg_msg(_Family, 0, Value) ->
    {unspec, decode_none(Value)};

decode_nfqnl_cfg_msg(_Family, 1, Value) ->
    decode_nfqnl_cfg_msg(cmd, Value);

decode_nfqnl_cfg_msg(_Family, 2, Value) ->
    decode_nfqnl_cfg_msg(params, Value);

decode_nfqnl_cfg_msg(_Family, 3, Value) ->
    {queue_maxlen, decode_none(Value)};

decode_nfqnl_cfg_msg(_Family, 4, Value) ->
    {mask, decode_none(Value)};

decode_nfqnl_cfg_msg(_Family, 5, Value) ->
    {flags, decode_none(Value)};

decode_nfqnl_cfg_msg(_Family, Id, Value) ->
    {Id, Value}.

%% ============================

decode_nfqnl_attr(_Family, 0, Value) ->
    {unspec, decode_none(Value)};

decode_nfqnl_attr(_Family, 1, Value) ->
    decode_nfqnl_attr(packet_hdr, Value);

decode_nfqnl_attr(_Family, 2, Value) ->
    decode_nfqnl_attr(verdict_hdr, Value);

decode_nfqnl_attr(_Family, 3, Value) ->
    {mark, decode_uint32(Value)};

decode_nfqnl_attr(_Family, 4, Value) ->
    decode_nfqnl_attr(timestamp, Value);

decode_nfqnl_attr(_Family, 5, Value) ->
    {ifindex_indev, decode_uint32(Value)};

decode_nfqnl_attr(_Family, 6, Value) ->
    {ifindex_outdev, decode_uint32(Value)};

decode_nfqnl_attr(_Family, 7, Value) ->
    {ifindex_physindev, decode_uint32(Value)};

decode_nfqnl_attr(_Family, 8, Value) ->
    {ifindex_physoutdev, decode_uint32(Value)};

decode_nfqnl_attr(_Family, 9, Value) ->
    decode_nfqnl_attr(hwaddr, Value);

decode_nfqnl_attr(_Family, 10, Value) ->
    {payload, decode_binary(Value)};

decode_nfqnl_attr(_Family, 11, Value) ->
    {ct, decode_none(Value)};

decode_nfqnl_attr(_Family, 12, Value) ->
    {ct_info, decode_none(Value)};

decode_nfqnl_attr(_Family, 13, Value) ->
    {cap_len, decode_uint32(Value)};

decode_nfqnl_attr(_Family, 14, Value) ->
    {skb_info, decode_uint32(Value)};

decode_nfqnl_attr(_Family, 15, Value) ->
    {exp, decode_none(Value)};

decode_nfqnl_attr(_Family, 16, Value) ->
    {uid, decode_uint32(Value)};

decode_nfqnl_attr(_Family, 17, Value) ->
    {gid, decode_uint32(Value)};

decode_nfqnl_attr(_Family, Id, Value) ->
    {Id, Value}.

%% ============================

encode_rtm_msgtype(noop) ->
    ?NLMSG_NOOP;

encode_rtm_msgtype(error) ->
    ?NLMSG_ERROR;

encode_rtm_msgtype(done) ->
    ?NLMSG_DONE;

encode_rtm_msgtype(overrun) ->
    ?NLMSG_OVERRUN;

encode_rtm_msgtype(newlink) ->
    ?RTM_NEWLINK;

encode_rtm_msgtype(dellink) ->
    ?RTM_DELLINK;

encode_rtm_msgtype(getlink) ->
    ?RTM_GETLINK;

encode_rtm_msgtype(setlink) ->
    ?RTM_SETLINK;

encode_rtm_msgtype(newaddr) ->
    ?RTM_NEWADDR;

encode_rtm_msgtype(deladdr) ->
    ?RTM_DELADDR;

encode_rtm_msgtype(getaddr) ->
    ?RTM_GETADDR;

encode_rtm_msgtype(newroute) ->
    ?RTM_NEWROUTE;

encode_rtm_msgtype(delroute) ->
    ?RTM_DELROUTE;

encode_rtm_msgtype(getroute) ->
    ?RTM_GETROUTE;

encode_rtm_msgtype(newneigh) ->
    ?RTM_NEWNEIGH;

encode_rtm_msgtype(delneigh) ->
    ?RTM_DELNEIGH;

encode_rtm_msgtype(getneigh) ->
    ?RTM_GETNEIGH;

encode_rtm_msgtype(newrule) ->
    ?RTM_NEWRULE;

encode_rtm_msgtype(delrule) ->
    ?RTM_DELRULE;

encode_rtm_msgtype(getrule) ->
    ?RTM_GETRULE;

encode_rtm_msgtype(newqdisc) ->
    ?RTM_NEWQDISC;

encode_rtm_msgtype(delqdisc) ->
    ?RTM_DELQDISC;

encode_rtm_msgtype(getqdisc) ->
    ?RTM_GETQDISC;

encode_rtm_msgtype(newtclass) ->
    ?RTM_NEWTCLASS;

encode_rtm_msgtype(deltclass) ->
    ?RTM_DELTCLASS;

encode_rtm_msgtype(gettclass) ->
    ?RTM_GETTCLASS;

encode_rtm_msgtype(newtfilter) ->
    ?RTM_NEWTFILTER;

encode_rtm_msgtype(deltfilter) ->
    ?RTM_DELTFILTER;

encode_rtm_msgtype(gettfilter) ->
    ?RTM_GETTFILTER;

encode_rtm_msgtype(newaction) ->
    ?RTM_NEWACTION;

encode_rtm_msgtype(delaction) ->
    ?RTM_DELACTION;

encode_rtm_msgtype(getaction) ->
    ?RTM_GETACTION;

encode_rtm_msgtype(newprefix) ->
    ?RTM_NEWPREFIX;

encode_rtm_msgtype(getmulticast) ->
    ?RTM_GETMULTICAST;

encode_rtm_msgtype(getanycast) ->
    ?RTM_GETANYCAST;

encode_rtm_msgtype(newneightbl) ->
    ?RTM_NEWNEIGHTBL;

encode_rtm_msgtype(getneightbl) ->
    ?RTM_GETNEIGHTBL;

encode_rtm_msgtype(setneightbl) ->
    ?RTM_SETNEIGHTBL;

encode_rtm_msgtype(newnduseropt) ->
    ?RTM_NEWNDUSEROPT;

encode_rtm_msgtype(newaddrlabel) ->
    ?RTM_NEWADDRLABEL;

encode_rtm_msgtype(deladdrlabel) ->
    ?RTM_DELADDRLABEL;

encode_rtm_msgtype(getaddrlabel) ->
    ?RTM_GETADDRLABEL;

encode_rtm_msgtype(getdcb) ->
    ?RTM_GETDCB;

encode_rtm_msgtype(setdcb) ->
    ?RTM_SETDCB;

encode_rtm_msgtype(Value) when is_integer(Value) ->
    Value.

%% ============================

encode_ctm_msgtype_netlink(noop) ->
    ?NLMSG_NOOP;

encode_ctm_msgtype_netlink(error) ->
    ?NLMSG_ERROR;

encode_ctm_msgtype_netlink(done) ->
    ?NLMSG_DONE;

encode_ctm_msgtype_netlink(overrun) ->
    ?NLMSG_OVERRUN;

encode_ctm_msgtype_netlink(Value) when is_integer(Value) ->
    Value.

%% ============================

encode_ctm_msgtype_ctnetlink(new) ->
    ?IPCTNL_MSG_CT_NEW;

encode_ctm_msgtype_ctnetlink(get) ->
    ?IPCTNL_MSG_CT_GET;

encode_ctm_msgtype_ctnetlink(delete) ->
    ?IPCTNL_MSG_CT_DELETE;

encode_ctm_msgtype_ctnetlink(get_ctrzero) ->
    ?IPCTNL_MSG_CT_GET_CTRZERO;

encode_ctm_msgtype_ctnetlink(Value) when is_integer(Value) ->
    Value.

%% ============================

encode_ctm_msgtype_ctnetlink_exp(new) ->
    ?IPCTNL_MSG_EXP_NEW;

encode_ctm_msgtype_ctnetlink_exp(get) ->
    ?IPCTNL_MSG_EXP_GET;

encode_ctm_msgtype_ctnetlink_exp(delete) ->
    ?IPCTNL_MSG_EXP_DELETE;

encode_ctm_msgtype_ctnetlink_exp(Value) when is_integer(Value) ->
    Value.

%% ============================

encode_ctnetlink(_Family, {unspec, Value}) ->
    encode_none(0, Value);

encode_ctnetlink(Family, {tuple_orig, Value}) ->
    enc_nla(1 bor 16#8000, nl_enc_nla(Family, fun encode_ctnetlink_tuple/2, Value));

encode_ctnetlink(Family, {tuple_reply, Value}) ->
    enc_nla(2 bor 16#8000, nl_enc_nla(Family, fun encode_ctnetlink_tuple/2, Value));

encode_ctnetlink(_Family, {status, Value}) ->
    encode_uint32(3, encode_flag(flag_info_ctnetlink_status(), Value));

encode_ctnetlink(Family, {protoinfo, Value}) ->
    enc_nla(4 bor 16#8000, nl_enc_nla(Family, fun encode_ctnetlink_protoinfo/2, Value));

encode_ctnetlink(Family, {help, Value}) ->
    enc_nla(5 bor 16#8000, nl_enc_nla(Family, fun encode_ctnetlink_help/2, Value));

encode_ctnetlink(_Family, {nat_src, Value}) ->
    encode_none(6, Value);

encode_ctnetlink(_Family, {timeout, Value}) ->
    encode_uint32(7, Value);

encode_ctnetlink(_Family, {mark, Value}) ->
    encode_uint32(8, Value);

encode_ctnetlink(Family, {counters_orig, Value}) ->
    enc_nla(9 bor 16#8000, nl_enc_nla(Family, fun encode_ctnetlink_counters/2, Value));

encode_ctnetlink(Family, {counters_reply, Value}) ->
    enc_nla(10 bor 16#8000, nl_enc_nla(Family, fun encode_ctnetlink_counters/2, Value));

encode_ctnetlink(_Family, {use, Value}) ->
    encode_uint32(11, Value);

encode_ctnetlink(_Family, {id, Value}) ->
    encode_uint32(12, Value);

encode_ctnetlink(_Family, {nat_dst, Value}) ->
    encode_none(13, Value);

encode_ctnetlink(Family, {tuple_master, Value}) ->
    enc_nla(14 bor 16#8000, nl_enc_nla(Family, fun encode_ctnetlink_tuple/2, Value));

encode_ctnetlink(Family, {nat_seq_adj_orig, Value}) ->
    enc_nla(15 bor 16#8000, nl_enc_nla(Family, fun encode_ctnetlink_nat_seq_adj/2, Value));

encode_ctnetlink(Family, {nat_seq_adj_reply, Value}) ->
    enc_nla(16 bor 16#8000, nl_enc_nla(Family, fun encode_ctnetlink_nat_seq_adj/2, Value));

encode_ctnetlink(_Family, {secmark, Value}) ->
    encode_uint32(17, Value);

encode_ctnetlink(_Family, {zone, Value}) ->
    encode_uint16(18, Value);

encode_ctnetlink(_Family, {secctx, Value}) ->
    encode_none(19, Value);

encode_ctnetlink(Family, {timestamp, Value}) ->
    enc_nla(20 bor 16#8000, nl_enc_nla(Family, fun encode_ctnetlink_timestamp/2, Value));

encode_ctnetlink(_Family, {Type, Value})
  when is_integer(Type), is_binary(Value) ->
    enc_nla(Type, Value).

%% ============================

encode_ctnetlink_tuple(_Family, {unspec, Value}) ->
    encode_none(0, Value);

encode_ctnetlink_tuple(Family, {ip, Value}) ->
    enc_nla(1 bor 16#8000, nl_enc_nla(Family, fun encode_ctnetlink_tuple_ip/2, Value));

encode_ctnetlink_tuple(Family, {proto, Value}) ->
    enc_nla(2 bor 16#8000, nl_enc_nla(Family, fun encode_ctnetlink_tuple_proto/2, Value));

encode_ctnetlink_tuple(_Family, {Type, Value})
  when is_integer(Type), is_binary(Value) ->
    enc_nla(Type, Value).

%% ============================

encode_ctnetlink_tuple_ip(_Family, {unspec, Value}) ->
    encode_none(0, Value);

encode_ctnetlink_tuple_ip(_Family, {v4_src, Value}) ->
    encode_addr(1, Value);

encode_ctnetlink_tuple_ip(_Family, {v4_dst, Value}) ->
    encode_addr(2, Value);

encode_ctnetlink_tuple_ip(_Family, {v6_src, Value}) ->
    encode_addr(3, Value);

encode_ctnetlink_tuple_ip(_Family, {v6_dst, Value}) ->
    encode_addr(4, Value);

encode_ctnetlink_tuple_ip(_Family, {Type, Value})
  when is_integer(Type), is_binary(Value) ->
    enc_nla(Type, Value).

%% ============================

encode_ctnetlink_tuple_proto(_Family, {unspec, Value}) ->
    encode_none(0, Value);

encode_ctnetlink_tuple_proto(_Family, {num, Value}) ->
    encode_protocol(1, Value);

encode_ctnetlink_tuple_proto(_Family, {src_port, Value}) ->
    encode_uint16(2, Value);

encode_ctnetlink_tuple_proto(_Family, {dst_port, Value}) ->
    encode_uint16(3, Value);

encode_ctnetlink_tuple_proto(_Family, {icmp_id, Value}) ->
    encode_uint16(4, Value);

encode_ctnetlink_tuple_proto(_Family, {icmp_type, Value}) ->
    encode_uint8(5, Value);

encode_ctnetlink_tuple_proto(_Family, {icmp_code, Value}) ->
    encode_uint8(6, Value);

encode_ctnetlink_tuple_proto(_Family, {icmpv6_id, Value}) ->
    encode_none(7, Value);

encode_ctnetlink_tuple_proto(_Family, {icmpv6_type, Value}) ->
    encode_none(8, Value);

encode_ctnetlink_tuple_proto(_Family, {icmpv6_code, Value}) ->
    encode_none(9, Value);

encode_ctnetlink_tuple_proto(_Family, {Type, Value})
  when is_integer(Type), is_binary(Value) ->
    enc_nla(Type, Value).

%% ============================

encode_ctnetlink_nat_seq_adj(_Family, {unspec, Value}) ->
    encode_none(0, Value);

encode_ctnetlink_nat_seq_adj(_Family, {correction_pos, Value}) ->
    encode_uint32(1, Value);

encode_ctnetlink_nat_seq_adj(_Family, {offset_before, Value}) ->
    encode_uint32(2, Value);

encode_ctnetlink_nat_seq_adj(_Family, {offset_after, Value}) ->
    encode_uint32(3, Value);

encode_ctnetlink_nat_seq_adj(_Family, {Type, Value})
  when is_integer(Type), is_binary(Value) ->
    enc_nla(Type, Value).

%% ============================

encode_ctnetlink_protoinfo(_Family, {unspec, Value}) ->
    encode_none(0, Value);

encode_ctnetlink_protoinfo(Family, {tcp, Value}) ->
    enc_nla(1 bor 16#8000, nl_enc_nla(Family, fun encode_ctnetlink_protoinfo_tcp/2, Value));

encode_ctnetlink_protoinfo(Family, {dccp, Value}) ->
    enc_nla(2 bor 16#8000, nl_enc_nla(Family, fun encode_ctnetlink_protoinfo_dccp/2, Value));

encode_ctnetlink_protoinfo(Family, {sctp, Value}) ->
    enc_nla(3 bor 16#8000, nl_enc_nla(Family, fun encode_ctnetlink_protoinfo_sctp/2, Value));

encode_ctnetlink_protoinfo(_Family, {Type, Value})
  when is_integer(Type), is_binary(Value) ->
    enc_nla(Type, Value).

%% ============================

encode_ctnetlink_protoinfo_tcp(_Family, {unspec, Value}) ->
    encode_none(0, Value);

encode_ctnetlink_protoinfo_tcp(_Family, {state, Value}) ->
    encode_uint8(1, encode_ctnetlink_protoinfo_tcp_state(Value));

encode_ctnetlink_protoinfo_tcp(_Family, {wscale_original, Value}) ->
    encode_uint8(2, Value);

encode_ctnetlink_protoinfo_tcp(_Family, {wscale_reply, Value}) ->
    encode_uint8(3, Value);

encode_ctnetlink_protoinfo_tcp(_Family, {flags_original, Value}) ->
    encode_uint16(4, Value);

encode_ctnetlink_protoinfo_tcp(_Family, {flags_reply, Value}) ->
    encode_uint16(5, Value);

encode_ctnetlink_protoinfo_tcp(_Family, {Type, Value})
  when is_integer(Type), is_binary(Value) ->
    enc_nla(Type, Value).

%% ============================

encode_ctnetlink_protoinfo_tcp_state(none) ->
    0;

encode_ctnetlink_protoinfo_tcp_state(syn_sent) ->
    1;

encode_ctnetlink_protoinfo_tcp_state(syn_recv) ->
    2;

encode_ctnetlink_protoinfo_tcp_state(established) ->
    3;

encode_ctnetlink_protoinfo_tcp_state(fin_wait) ->
    4;

encode_ctnetlink_protoinfo_tcp_state(close_wait) ->
    5;

encode_ctnetlink_protoinfo_tcp_state(last_ack) ->
    6;

encode_ctnetlink_protoinfo_tcp_state(time_wait) ->
    7;

encode_ctnetlink_protoinfo_tcp_state(close) ->
    8;

encode_ctnetlink_protoinfo_tcp_state(listen) ->
    9;

encode_ctnetlink_protoinfo_tcp_state(max) ->
    10;

encode_ctnetlink_protoinfo_tcp_state(ignore) ->
    11;

encode_ctnetlink_protoinfo_tcp_state(Value) when is_integer(Value) ->
    Value.

%% ============================

encode_ctnetlink_help(_Family, {unspec, Value}) ->
    encode_none(0, Value);

encode_ctnetlink_help(_Family, {name, Value}) ->
    encode_string(1, Value);

encode_ctnetlink_help(_Family, {Type, Value})
  when is_integer(Type), is_binary(Value) ->
    enc_nla(Type, Value).

%% ============================

encode_ctnetlink_counters(_Family, {unspec, Value}) ->
    encode_none(0, Value);

encode_ctnetlink_counters(_Family, {packets, Value}) ->
    encode_uint64(1, Value);

encode_ctnetlink_counters(_Family, {bytes, Value}) ->
    encode_uint64(2, Value);

encode_ctnetlink_counters(_Family, {packets32, Value}) ->
    encode_uint32(3, Value);

encode_ctnetlink_counters(_Family, {bytes32, Value}) ->
    encode_uint32(4, Value);

encode_ctnetlink_counters(_Family, {Type, Value})
  when is_integer(Type), is_binary(Value) ->
    enc_nla(Type, Value).

%% ============================

encode_ctnetlink_timestamp(_Family, {unspec, Value}) ->
    encode_none(0, Value);

encode_ctnetlink_timestamp(_Family, {start, Value}) ->
    encode_uint64(1, Value);

encode_ctnetlink_timestamp(_Family, {stop, Value}) ->
    encode_uint64(2, Value);

encode_ctnetlink_timestamp(_Family, {Type, Value})
  when is_integer(Type), is_binary(Value) ->
    enc_nla(Type, Value).

%% ============================

encode_ctnetlink_exp(_Family, {unspec, Value}) ->
    encode_none(0, Value);

encode_ctnetlink_exp(Family, {master, Value}) ->
    enc_nla(1 bor 16#8000, nl_enc_nla(Family, fun encode_ctnetlink_exp_tuple/2, Value));

encode_ctnetlink_exp(Family, {tuple, Value}) ->
    enc_nla(2 bor 16#8000, nl_enc_nla(Family, fun encode_ctnetlink_exp_tuple/2, Value));

encode_ctnetlink_exp(Family, {mask, Value}) ->
    enc_nla(3 bor 16#8000, nl_enc_nla(Family, fun encode_ctnetlink_exp_tuple/2, Value));

encode_ctnetlink_exp(_Family, {timeout, Value}) ->
    encode_uint32(4, Value);

encode_ctnetlink_exp(_Family, {id, Value}) ->
    encode_uint32(5, Value);

encode_ctnetlink_exp(_Family, {help_name, Value}) ->
    encode_string(6, Value);

encode_ctnetlink_exp(_Family, {zone, Value}) ->
    encode_uint16(7, Value);

encode_ctnetlink_exp(_Family, {flags, Value}) ->
    encode_uint32(8, encode_flag(flag_info_ctnetlink_exp_flags(), Value));

encode_ctnetlink_exp(_Family, {Type, Value})
  when is_integer(Type), is_binary(Value) ->
    enc_nla(Type, Value).

%% ============================

encode_ctnetlink_exp_tuple(_Family, {unspec, Value}) ->
    encode_none(0, Value);

encode_ctnetlink_exp_tuple(Family, {ip, Value}) ->
    enc_nla(1 bor 16#8000, nl_enc_nla(Family, fun encode_ctnetlink_exp_tuple_ip/2, Value));

encode_ctnetlink_exp_tuple(Family, {proto, Value}) ->
    enc_nla(2 bor 16#8000, nl_enc_nla(Family, fun encode_ctnetlink_exp_tuple_proto/2, Value));

encode_ctnetlink_exp_tuple(_Family, {Type, Value})
  when is_integer(Type), is_binary(Value) ->
    enc_nla(Type, Value).

%% ============================

encode_ctnetlink_exp_tuple_ip(_Family, {unspec, Value}) ->
    encode_none(0, Value);

encode_ctnetlink_exp_tuple_ip(_Family, {v4_src, Value}) ->
    encode_addr(1, Value);

encode_ctnetlink_exp_tuple_ip(_Family, {v4_dst, Value}) ->
    encode_addr(2, Value);

encode_ctnetlink_exp_tuple_ip(_Family, {v6_src, Value}) ->
    encode_addr(3, Value);

encode_ctnetlink_exp_tuple_ip(_Family, {v6_dst, Value}) ->
    encode_addr(4, Value);

encode_ctnetlink_exp_tuple_ip(_Family, {Type, Value})
  when is_integer(Type), is_binary(Value) ->
    enc_nla(Type, Value).

%% ============================

encode_ctnetlink_exp_tuple_proto(_Family, {unspec, Value}) ->
    encode_none(0, Value);

encode_ctnetlink_exp_tuple_proto(_Family, {num, Value}) ->
    encode_protocol(1, Value);

encode_ctnetlink_exp_tuple_proto(_Family, {src_port, Value}) ->
    encode_uint16(2, Value);

encode_ctnetlink_exp_tuple_proto(_Family, {dst_port, Value}) ->
    encode_uint16(3, Value);

encode_ctnetlink_exp_tuple_proto(_Family, {icmp_id, Value}) ->
    encode_uint16(4, Value);

encode_ctnetlink_exp_tuple_proto(_Family, {icmp_type, Value}) ->
    encode_uint8(5, Value);

encode_ctnetlink_exp_tuple_proto(_Family, {icmp_code, Value}) ->
    encode_uint8(6, Value);

encode_ctnetlink_exp_tuple_proto(_Family, {icmpv6_id, Value}) ->
    encode_none(7, Value);

encode_ctnetlink_exp_tuple_proto(_Family, {icmpv6_type, Value}) ->
    encode_none(8, Value);

encode_ctnetlink_exp_tuple_proto(_Family, {icmpv6_code, Value}) ->
    encode_none(9, Value);

encode_ctnetlink_exp_tuple_proto(_Family, {Type, Value})
  when is_integer(Type), is_binary(Value) ->
    enc_nla(Type, Value).

%% ============================

encode_rtnetlink_neigh(_Family, {unspec, Value}) ->
    encode_none(0, Value);

encode_rtnetlink_neigh(_Family, {dst, Value}) ->
    encode_addr(1, Value);

encode_rtnetlink_neigh(_Family, {lladdr, Value}) ->
    encode_mac(2, Value);

encode_rtnetlink_neigh(_Family, Value)
  when is_tuple(Value), element(1, Value) == nda_cacheinfo ->
    encode_huint32_array(3, Value);

encode_rtnetlink_neigh(_Family, {probes, Value}) ->
    encode_huint32(4, Value);

encode_rtnetlink_neigh(_Family, {Type, Value})
  when is_integer(Type), is_binary(Value) ->
    enc_nla(Type, Value).

%% ============================

encode_rtnetlink_rtm_type(unspec) ->
    0;

encode_rtnetlink_rtm_type(unicast) ->
    1;

encode_rtnetlink_rtm_type(local) ->
    2;

encode_rtnetlink_rtm_type(broadcast) ->
    3;

encode_rtnetlink_rtm_type(anycast) ->
    4;

encode_rtnetlink_rtm_type(multicast) ->
    5;

encode_rtnetlink_rtm_type(blackhole) ->
    6;

encode_rtnetlink_rtm_type(unreachable) ->
    7;

encode_rtnetlink_rtm_type(prohibit) ->
    8;

encode_rtnetlink_rtm_type(throw) ->
    9;

encode_rtnetlink_rtm_type(nat) ->
    10;

encode_rtnetlink_rtm_type(xresolve) ->
    11;

encode_rtnetlink_rtm_type(Value) when is_integer(Value) ->
    Value.

%% ============================

encode_rtnetlink_rtm_protocol(unspec) ->
    0;

encode_rtnetlink_rtm_protocol(redirect) ->
    1;

encode_rtnetlink_rtm_protocol(kernel) ->
    2;

encode_rtnetlink_rtm_protocol(boot) ->
    3;

encode_rtnetlink_rtm_protocol(static) ->
    4;

encode_rtnetlink_rtm_protocol(gated) ->
    8;

encode_rtnetlink_rtm_protocol(ra) ->
    9;

encode_rtnetlink_rtm_protocol(mrt) ->
    10;

encode_rtnetlink_rtm_protocol(zebra) ->
    11;

encode_rtnetlink_rtm_protocol(bird) ->
    12;

encode_rtnetlink_rtm_protocol(dnrouted) ->
    13;

encode_rtnetlink_rtm_protocol(xorp) ->
    14;

encode_rtnetlink_rtm_protocol(ntk) ->
    15;

encode_rtnetlink_rtm_protocol(dhcp) ->
    16;

encode_rtnetlink_rtm_protocol(Value) when is_integer(Value) ->
    Value.

%% ============================

encode_rtnetlink_rtm_scope(universe) ->
    0;

encode_rtnetlink_rtm_scope(site) ->
    200;

encode_rtnetlink_rtm_scope(link) ->
    253;

encode_rtnetlink_rtm_scope(host) ->
    254;

encode_rtnetlink_rtm_scope(nowhere) ->
    255;

encode_rtnetlink_rtm_scope(Value) when is_integer(Value) ->
    Value.

%% ============================

encode_rtnetlink_rtm_table(unspec) ->
    0;

encode_rtnetlink_rtm_table(compat) ->
    252;

encode_rtnetlink_rtm_table(default) ->
    253;

encode_rtnetlink_rtm_table(main) ->
    254;

encode_rtnetlink_rtm_table(local) ->
    255;

encode_rtnetlink_rtm_table(Value) when is_integer(Value) ->
    Value.

%% ============================

encode_rtnetlink_route(_Family, {unspec, Value}) ->
    encode_none(0, Value);

encode_rtnetlink_route(_Family, {dst, Value}) ->
    encode_addr(1, Value);

encode_rtnetlink_route(_Family, {src, Value}) ->
    encode_addr(2, Value);

encode_rtnetlink_route(_Family, {iif, Value}) ->
    encode_huint32(3, Value);

encode_rtnetlink_route(_Family, {oif, Value}) ->
    encode_huint32(4, Value);

encode_rtnetlink_route(_Family, {gateway, Value}) ->
    encode_addr(5, Value);

encode_rtnetlink_route(_Family, {priority, Value}) ->
    encode_huint32(6, Value);

encode_rtnetlink_route(_Family, {prefsrc, Value}) ->
    encode_addr(7, Value);

encode_rtnetlink_route(Family, {metrics, Value}) ->
    enc_nla(8, nl_enc_nla(Family, fun encode_rtnetlink_route_metrics/2, Value));

encode_rtnetlink_route(_Family, {multipath, Value}) ->
    encode_none(9, Value);

encode_rtnetlink_route(_Family, {protoinfo, Value}) ->
    encode_none(10, Value);

encode_rtnetlink_route(_Family, {flow, Value}) ->
    encode_huint32(11, Value);

encode_rtnetlink_route(_Family, Value)
  when is_tuple(Value), element(1, Value) == rta_cacheinfo ->
    encode_huint32_array(12, Value);

encode_rtnetlink_route(_Family, {session, Value}) ->
    encode_none(13, Value);

encode_rtnetlink_route(_Family, {mp_algo, Value}) ->
    encode_none(14, Value);

encode_rtnetlink_route(_Family, {table, Value}) ->
    encode_huint32(15, Value);

encode_rtnetlink_route(_Family, {Type, Value})
  when is_integer(Type), is_binary(Value) ->
    enc_nla(Type, Value).

%% ============================

encode_rtnetlink_route_metrics(_Family, {unspec, Value}) ->
    encode_none(0, Value);

encode_rtnetlink_route_metrics(_Family, {lock, Value}) ->
    encode_huint32(1, Value);

encode_rtnetlink_route_metrics(_Family, {mtu, Value}) ->
    encode_huint32(2, Value);

encode_rtnetlink_route_metrics(_Family, {window, Value}) ->
    encode_huint32(3, Value);

encode_rtnetlink_route_metrics(_Family, {rtt, Value}) ->
    encode_huint32(4, Value);

encode_rtnetlink_route_metrics(_Family, {rttvar, Value}) ->
    encode_huint32(5, Value);

encode_rtnetlink_route_metrics(_Family, {ssthresh, Value}) ->
    encode_huint32(6, Value);

encode_rtnetlink_route_metrics(_Family, {cwnd, Value}) ->
    encode_huint32(7, Value);

encode_rtnetlink_route_metrics(_Family, {advmss, Value}) ->
    encode_huint32(8, Value);

encode_rtnetlink_route_metrics(_Family, {reordering, Value}) ->
    encode_huint32(9, Value);

encode_rtnetlink_route_metrics(_Family, {hoplimit, Value}) ->
    encode_huint32(10, Value);

encode_rtnetlink_route_metrics(_Family, {initcwnd, Value}) ->
    encode_huint32(11, Value);

encode_rtnetlink_route_metrics(_Family, {features, Value}) ->
    encode_huint32(12, Value);

encode_rtnetlink_route_metrics(_Family, {rto_min, Value}) ->
    encode_huint32(13, Value);

encode_rtnetlink_route_metrics(_Family, {initrwnd, Value}) ->
    encode_huint32(14, Value);

encode_rtnetlink_route_metrics(_Family, {Type, Value})
  when is_integer(Type), is_binary(Value) ->
    enc_nla(Type, Value).

%% ============================

encode_rtnetlink_addr(_Family, {unspec, Value}) ->
    encode_none(0, Value);

encode_rtnetlink_addr(_Family, {address, Value}) ->
    encode_addr(1, Value);

encode_rtnetlink_addr(_Family, {local, Value}) ->
    encode_addr(2, Value);

encode_rtnetlink_addr(_Family, {label, Value}) ->
    encode_string(3, Value);

encode_rtnetlink_addr(_Family, {broadcast, Value}) ->
    encode_addr(4, Value);

encode_rtnetlink_addr(_Family, {anycast, Value}) ->
    encode_addr(5, Value);

encode_rtnetlink_addr(_Family, Value)
  when is_tuple(Value), element(1, Value) == ifa_cacheinfo ->
    encode_huint32_array(6, Value);

encode_rtnetlink_addr(_Family, {multicast, Value}) ->
    encode_addr(7, Value);

encode_rtnetlink_addr(_Family, {Type, Value})
  when is_integer(Type), is_binary(Value) ->
    enc_nla(Type, Value).

%% ============================

encode_rtnetlink_link(_Family, {unspec, Value}) ->
    encode_none(0, Value);

encode_rtnetlink_link(_Family, {address, Value}) ->
    encode_mac(1, Value);

encode_rtnetlink_link(_Family, {broadcast, Value}) ->
    encode_mac(2, Value);

encode_rtnetlink_link(_Family, {ifname, Value}) ->
    encode_string(3, Value);

encode_rtnetlink_link(_Family, {mtu, Value}) ->
    encode_huint32(4, Value);

encode_rtnetlink_link(_Family, {link, Value}) ->
    encode_huint32(5, Value);

encode_rtnetlink_link(_Family, {qdisc, Value}) ->
    encode_string(6, Value);

encode_rtnetlink_link(_Family, Value)
  when is_tuple(Value), element(1, Value) == stats ->
    encode_huint32_array(7, Value);

encode_rtnetlink_link(_Family, {cost, Value}) ->
    encode_none(8, Value);

encode_rtnetlink_link(_Family, {priority, Value}) ->
    encode_none(9, Value);

encode_rtnetlink_link(_Family, {master, Value}) ->
    encode_none(10, Value);

encode_rtnetlink_link(_Family, {wireless, Value}) ->
    encode_none(11, Value);

encode_rtnetlink_link(Family, {protinfo, Value}) ->
    enc_nla(12, nl_enc_nla(Family, fun encode_rtnetlink_link_protinfo/2, Value));

encode_rtnetlink_link(_Family, {txqlen, Value}) ->
    encode_huint32(13, Value);

encode_rtnetlink_link(_Family, Value)  when is_tuple(Value), element(1, Value) == map ->
    encode_if_map(14, Value);

encode_rtnetlink_link(_Family, {weight, Value}) ->
    encode_none(15, Value);

encode_rtnetlink_link(_Family, {operstate, Value}) ->
    encode_uint8(16, encode_rtnetlink_link_operstate(Value));

encode_rtnetlink_link(_Family, {linkmode, Value}) ->
    encode_uint8(17, encode_rtnetlink_link_linkmode(Value));

encode_rtnetlink_link(Family, {linkinfo, Value}) ->
    enc_nla(18, nl_enc_nla(Family, fun encode_rtnetlink_link_linkinfo/2, Value));

encode_rtnetlink_link(_Family, {net_ns_pid, Value}) ->
    encode_none(19, Value);

encode_rtnetlink_link(_Family, {ifalias, Value}) ->
    encode_string(20, Value);

encode_rtnetlink_link(_Family, {num_vf, Value}) ->
    encode_huint32(21, Value);

encode_rtnetlink_link(_Family, {vfinfo_list, Value}) ->
    encode_none(22, Value);

encode_rtnetlink_link(_Family, Value)
  when is_tuple(Value), element(1, Value) == stats64 ->
    encode_huint64_array(23, Value);

encode_rtnetlink_link(_Family, {vf_ports, Value}) ->
    encode_none(24, Value);

encode_rtnetlink_link(_Family, {port_self, Value}) ->
    encode_none(25, Value);

encode_rtnetlink_link(_Family, {af_spec, Value}) ->
    encode_none(26, Value);

encode_rtnetlink_link(_Family, {group, Value}) ->
    encode_none(27, Value);

encode_rtnetlink_link(_Family, {net_ns_fd, Value}) ->
    encode_none(28, Value);

encode_rtnetlink_link(_Family, {ext_mask, Value}) ->
    encode_huint32(29, Value);

encode_rtnetlink_link(_Family, {promiscuity, Value}) ->
    encode_none(30, Value);

encode_rtnetlink_link(_Family, {num_tx_queues, Value}) ->
    encode_none(31, Value);

encode_rtnetlink_link(_Family, {num_rx_queues, Value}) ->
    encode_none(32, Value);

encode_rtnetlink_link(_Family, {carrier, Value}) ->
    encode_none(33, Value);

encode_rtnetlink_link(_Family, {phys_port_id, Value}) ->
    encode_none(34, Value);

encode_rtnetlink_link(_Family, {carrier_changes, Value}) ->
    encode_none(35, Value);

encode_rtnetlink_link(_Family, {Type, Value})
  when is_integer(Type), is_binary(Value) ->
    enc_nla(Type, Value).

%% ============================

encode_rtnetlink_link_operstate(unknown) ->
    0;

encode_rtnetlink_link_operstate(notpresent) ->
    1;

encode_rtnetlink_link_operstate(down) ->
    2;

encode_rtnetlink_link_operstate(lowerlayerdown) ->
    3;

encode_rtnetlink_link_operstate(testing) ->
    4;

encode_rtnetlink_link_operstate(dormant) ->
    5;

encode_rtnetlink_link_operstate(up) ->
    6;

encode_rtnetlink_link_operstate(Value) when is_integer(Value) ->
    Value.

%% ============================

encode_rtnetlink_link_linkmode(default) ->
    0;

encode_rtnetlink_link_linkmode(dormant) ->
    1;

encode_rtnetlink_link_linkmode(Value) when is_integer(Value) ->
    Value.

%% ============================

encode_rtnetlink_link_linkinfo(_Family, {unspec, Value}) ->
    encode_none(0, Value);

encode_rtnetlink_link_linkinfo(_Family, {kind, Value}) ->
    encode_string(1, Value);

encode_rtnetlink_link_linkinfo(_Family, {data, Value}) ->
    encode_binary(2, Value);

encode_rtnetlink_link_linkinfo(_Family, {xstats, Value}) ->
    encode_binary(3, Value);

encode_rtnetlink_link_linkinfo(_Family, {Type, Value})
  when is_integer(Type), is_binary(Value) ->
    enc_nla(Type, Value).

%% ============================

encode_rtnetlink_link_protinfo_inet6(_Family, {unspec, Value}) ->
    encode_none(0, Value);

encode_rtnetlink_link_protinfo_inet6(_Family, {flags, Value}) ->
    encode_huint32(1, encode_flag(flag_info_rtnetlink_link_protinfo_inet6_flags(), Value));

encode_rtnetlink_link_protinfo_inet6(_Family, Value)
  when is_tuple(Value), element(1, Value) == conf ->
    encode_hsint32_array(2, Value);

encode_rtnetlink_link_protinfo_inet6(_Family, Value)
  when is_tuple(Value), element(1, Value) == stats ->
    encode_huint64_array(3, Value);

encode_rtnetlink_link_protinfo_inet6(_Family, {mcast, Value}) ->
    encode_none(4, Value);

encode_rtnetlink_link_protinfo_inet6(_Family, Value)
  when is_tuple(Value), element(1, Value) == ifla_cacheinfo ->
    encode_huint32_array(5, Value);

encode_rtnetlink_link_protinfo_inet6(_Family, Value)
  when is_tuple(Value), element(1, Value) == icmp6stats ->
    encode_huint64_array(6, Value);

encode_rtnetlink_link_protinfo_inet6(_Family, {Type, Value})
  when is_integer(Type), is_binary(Value) ->
    enc_nla(Type, Value).

%% ============================

encode_rtnetlink_prefix(_Family, {unspec, Value}) ->
    encode_none(0, Value);

encode_rtnetlink_prefix(_Family, {address, Value}) ->
    encode_addr(1, Value);

encode_rtnetlink_prefix(_Family, Value)
  when is_tuple(Value), element(1, Value) == prefix_cacheinfo ->
    encode_huint32_array(2, Value);

encode_rtnetlink_prefix(_Family, {Type, Value})
  when is_integer(Type), is_binary(Value) ->
    enc_nla(Type, Value).

%% ============================

encode_ctm_msgtype_queue(packet) ->
    ?NFQNL_MSG_PACKET;

encode_ctm_msgtype_queue(verdict) ->
    ?NFQNL_MSG_VERDICT;

encode_ctm_msgtype_queue(config) ->
    ?NFQNL_MSG_CONFIG;

encode_ctm_msgtype_queue(verdict_batch) ->
    ?NFQNL_MSG_VERDICT_BATCH;

encode_ctm_msgtype_queue(Value) when is_integer(Value) ->
    Value.

%% ============================

encode_nfqnl_config_cmd(none) ->
    ?NFQNL_CFG_CMD_NONE;

encode_nfqnl_config_cmd(bind) ->
    ?NFQNL_CFG_CMD_BIND;

encode_nfqnl_config_cmd(unbind) ->
    ?NFQNL_CFG_CMD_UNBIND;

encode_nfqnl_config_cmd(pf_bind) ->
    ?NFQNL_CFG_CMD_PF_BIND;

encode_nfqnl_config_cmd(pf_unbind) ->
    ?NFQNL_CFG_CMD_PF_UNBIND;

encode_nfqnl_config_cmd(Value) when is_integer(Value) ->
    Value.

%% ============================

encode_nfqnl_cfg_msg(_Family, {unspec, Value}) ->
    encode_none(0, Value);

encode_nfqnl_cfg_msg(_Family, Value)
  when is_tuple(Value), element(1, Value) == cmd ->
    enc_nla(1, encode_nfqnl_cfg_msg(Value));

encode_nfqnl_cfg_msg(_Family, Value)
  when is_tuple(Value), element(1, Value) == params ->
    enc_nla(2, encode_nfqnl_cfg_msg(Value));

encode_nfqnl_cfg_msg(_Family, {queue_maxlen, Value}) ->
    encode_none(3, Value);

encode_nfqnl_cfg_msg(_Family, {mask, Value}) ->
    encode_none(4, Value);

encode_nfqnl_cfg_msg(_Family, {flags, Value}) ->
    encode_none(5, Value);

encode_nfqnl_cfg_msg(_Family, {Type, Value})
  when is_integer(Type), is_binary(Value) ->
    enc_nla(Type, Value).

%% ============================

encode_nfqnl_attr(_Family, {unspec, Value}) ->
    encode_none(0, Value);

encode_nfqnl_attr(_Family, Value)
  when is_tuple(Value), element(1, Value) == packet_hdr ->
    enc_nla(1, encode_nfqnl_attr(Value));

encode_nfqnl_attr(_Family, Value)
  when is_tuple(Value), element(1, Value) == verdict_hdr ->
    enc_nla(2, encode_nfqnl_attr(Value));

encode_nfqnl_attr(_Family, {mark, Value}) ->
    encode_uint32(3, Value);

encode_nfqnl_attr(_Family, Value)
  when is_tuple(Value), element(1, Value) == timestamp ->
    enc_nla(4, encode_nfqnl_attr(Value));

encode_nfqnl_attr(_Family, {ifindex_indev, Value}) ->
    encode_uint32(5, Value);

encode_nfqnl_attr(_Family, {ifindex_outdev, Value}) ->
    encode_uint32(6, Value);

encode_nfqnl_attr(_Family, {ifindex_physindev, Value}) ->
    encode_uint32(7, Value);

encode_nfqnl_attr(_Family, {ifindex_physoutdev, Value}) ->
    encode_uint32(8, Value);

encode_nfqnl_attr(_Family, Value)
  when is_tuple(Value), element(1, Value) == hwaddr ->
    enc_nla(9, encode_nfqnl_attr(Value));

encode_nfqnl_attr(_Family, {payload, Value}) ->
    encode_binary(10, Value);

encode_nfqnl_attr(_Family, {ct, Value}) ->
    encode_none(11, Value);

encode_nfqnl_attr(_Family, {ct_info, Value}) ->
    encode_none(12, Value);

encode_nfqnl_attr(_Family, {cap_len, Value}) ->
    encode_uint32(13, Value);

encode_nfqnl_attr(_Family, {skb_info, Value}) ->
    encode_uint32(14, Value);

encode_nfqnl_attr(_Family, {exp, Value}) ->
    encode_none(15, Value);

encode_nfqnl_attr(_Family, {uid, Value}) ->
    encode_uint32(16, Value);

encode_nfqnl_attr(_Family, {gid, Value}) ->
    encode_uint32(17, Value);

encode_nfqnl_attr(_Family, {Type, Value})
  when is_integer(Type), is_binary(Value) ->
    enc_nla(Type, Value).