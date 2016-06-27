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

flag_info_nfqnl_cfg_msg_mask() ->
    [{1,fail_open},{2,conntrack},{4,gso},{8,uid_gid},{16,secctx}].

flag_info_nfqnl_cfg_msg_flags() ->
    [{1,fail_open},{2,conntrack},{4,gso},{8,uid_gid},{16,secctx}].

flag_info_nft_queue_attributes_flags() ->
    [{1,bypass},{2,cpu_fanout},{4,mask}].

flag_info_nft_table_attributes_flags() ->
    [{1,dormant}].

flag_info_nft_set_attributes_flags() ->
    [{1,anonymous},{2,constant},{4,interval},{8,map},{16,timeout},{32,eval}].

flag_info_nft_set_ext_attributes_flags() ->
    [{1,interval_end}].

%% ============================

decode_protocol_subsys(?NETLINK_ROUTE) ->
    rtnetlink;

decode_protocol_subsys(?NETLINK_USERSOCK) ->
    usersock;

decode_protocol_subsys(?NETLINK_FIREWALL) ->
    firewall;

decode_protocol_subsys(?NETLINK_INET_DIAG) ->
    inet_diag;

decode_protocol_subsys(?NETLINK_NFLOG) ->
    nflog;

decode_protocol_subsys(?NETLINK_XFRM) ->
    xfrm;

decode_protocol_subsys(?NETLINK_SELINUX) ->
    selinux;

decode_protocol_subsys(?NETLINK_ISCSI) ->
    iscsi;

decode_protocol_subsys(?NETLINK_AUDIT) ->
    audit;

decode_protocol_subsys(?NETLINK_FIB_LOOKUP) ->
    fib_lookup;

decode_protocol_subsys(?NETLINK_CONNECTOR) ->
    connector;

decode_protocol_subsys(?NETLINK_NETFILTER) ->
    netfilter;

decode_protocol_subsys(?NETLINK_IP6_FW) ->
    ip6_fw;

decode_protocol_subsys(?NETLINK_DNRTMSG) ->
    dnrtmsg;

decode_protocol_subsys(?NETLINK_KOBJECT_UEVENT) ->
    kobject_uevent;

decode_protocol_subsys(?NETLINK_GENERIC) ->
    generic;

decode_protocol_subsys(?NETLINK_SCSITRANSPORT) ->
    scsitransport;

decode_protocol_subsys(?NETLINK_ECRYPTFS) ->
    ecryptfs;

decode_protocol_subsys(Value) ->
    Value.

%% ============================

decode_nl_subsys(0) ->
    netlink;

decode_nl_subsys(1) ->
    ctnetlink;

decode_nl_subsys(2) ->
    ctnetlink_exp;

decode_nl_subsys(3) ->
    queue;

decode_nl_subsys(4) ->
    ulog;

decode_nl_subsys(5) ->
    osf;

decode_nl_subsys(6) ->
    ipset;

decode_nl_subsys(7) ->
    acct;

decode_nl_subsys(8) ->
    ctnetlink_timeout;

decode_nl_subsys(9) ->
    cthelper;

decode_nl_subsys(10) ->
    nftables;

decode_nl_subsys(11) ->
    nft_compat;

decode_nl_subsys(12) ->
    count;

decode_nl_subsys(Value) ->
    Value.

%% ============================

decode_rtm_msgtype_rtnetlink(?NLMSG_NOOP) ->
    noop;

decode_rtm_msgtype_rtnetlink(?NLMSG_ERROR) ->
    error;

decode_rtm_msgtype_rtnetlink(?NLMSG_DONE) ->
    done;

decode_rtm_msgtype_rtnetlink(?NLMSG_OVERRUN) ->
    overrun;

decode_rtm_msgtype_rtnetlink(?RTM_NEWLINK) ->
    newlink;

decode_rtm_msgtype_rtnetlink(?RTM_DELLINK) ->
    dellink;

decode_rtm_msgtype_rtnetlink(?RTM_GETLINK) ->
    getlink;

decode_rtm_msgtype_rtnetlink(?RTM_SETLINK) ->
    setlink;

decode_rtm_msgtype_rtnetlink(?RTM_NEWADDR) ->
    newaddr;

decode_rtm_msgtype_rtnetlink(?RTM_DELADDR) ->
    deladdr;

decode_rtm_msgtype_rtnetlink(?RTM_GETADDR) ->
    getaddr;

decode_rtm_msgtype_rtnetlink(?RTM_NEWROUTE) ->
    newroute;

decode_rtm_msgtype_rtnetlink(?RTM_DELROUTE) ->
    delroute;

decode_rtm_msgtype_rtnetlink(?RTM_GETROUTE) ->
    getroute;

decode_rtm_msgtype_rtnetlink(?RTM_NEWNEIGH) ->
    newneigh;

decode_rtm_msgtype_rtnetlink(?RTM_DELNEIGH) ->
    delneigh;

decode_rtm_msgtype_rtnetlink(?RTM_GETNEIGH) ->
    getneigh;

decode_rtm_msgtype_rtnetlink(?RTM_NEWRULE) ->
    newrule;

decode_rtm_msgtype_rtnetlink(?RTM_DELRULE) ->
    delrule;

decode_rtm_msgtype_rtnetlink(?RTM_GETRULE) ->
    getrule;

decode_rtm_msgtype_rtnetlink(?RTM_NEWQDISC) ->
    newqdisc;

decode_rtm_msgtype_rtnetlink(?RTM_DELQDISC) ->
    delqdisc;

decode_rtm_msgtype_rtnetlink(?RTM_GETQDISC) ->
    getqdisc;

decode_rtm_msgtype_rtnetlink(?RTM_NEWTCLASS) ->
    newtclass;

decode_rtm_msgtype_rtnetlink(?RTM_DELTCLASS) ->
    deltclass;

decode_rtm_msgtype_rtnetlink(?RTM_GETTCLASS) ->
    gettclass;

decode_rtm_msgtype_rtnetlink(?RTM_NEWTFILTER) ->
    newtfilter;

decode_rtm_msgtype_rtnetlink(?RTM_DELTFILTER) ->
    deltfilter;

decode_rtm_msgtype_rtnetlink(?RTM_GETTFILTER) ->
    gettfilter;

decode_rtm_msgtype_rtnetlink(?RTM_NEWACTION) ->
    newaction;

decode_rtm_msgtype_rtnetlink(?RTM_DELACTION) ->
    delaction;

decode_rtm_msgtype_rtnetlink(?RTM_GETACTION) ->
    getaction;

decode_rtm_msgtype_rtnetlink(?RTM_NEWPREFIX) ->
    newprefix;

decode_rtm_msgtype_rtnetlink(?RTM_GETMULTICAST) ->
    getmulticast;

decode_rtm_msgtype_rtnetlink(?RTM_GETANYCAST) ->
    getanycast;

decode_rtm_msgtype_rtnetlink(?RTM_NEWNEIGHTBL) ->
    newneightbl;

decode_rtm_msgtype_rtnetlink(?RTM_GETNEIGHTBL) ->
    getneightbl;

decode_rtm_msgtype_rtnetlink(?RTM_SETNEIGHTBL) ->
    setneightbl;

decode_rtm_msgtype_rtnetlink(?RTM_NEWNDUSEROPT) ->
    newnduseropt;

decode_rtm_msgtype_rtnetlink(?RTM_NEWADDRLABEL) ->
    newaddrlabel;

decode_rtm_msgtype_rtnetlink(?RTM_DELADDRLABEL) ->
    deladdrlabel;

decode_rtm_msgtype_rtnetlink(?RTM_GETADDRLABEL) ->
    getaddrlabel;

decode_rtm_msgtype_rtnetlink(?RTM_GETDCB) ->
    getdcb;

decode_rtm_msgtype_rtnetlink(?RTM_SETDCB) ->
    setdcb;

decode_rtm_msgtype_rtnetlink(Value) ->
    Value.

%% ============================

decode_nl_msgtype_nlmsg(?NLMSG_NOOP) ->
    noop;

decode_nl_msgtype_nlmsg(?NLMSG_ERROR) ->
    error;

decode_nl_msgtype_nlmsg(?NLMSG_DONE) ->
    done;

decode_nl_msgtype_nlmsg(?NLMSG_OVERRUN) ->
    overrun;

decode_nl_msgtype_nlmsg(Value) ->
    Value.

%% ============================

decode_nl_msgtype_nfnl(?NFNL_MSG_BATCH_BEGIN) ->
    'begin';

decode_nl_msgtype_nfnl(?NFNL_MSG_BATCH_END) ->
    'end';

decode_nl_msgtype_nfnl(Value) ->
    Value.

%% ============================

decode_nl_msgtype_ctnetlink(?IPCTNL_MSG_CT_NEW) ->
    new;

decode_nl_msgtype_ctnetlink(?IPCTNL_MSG_CT_GET) ->
    get;

decode_nl_msgtype_ctnetlink(?IPCTNL_MSG_CT_DELETE) ->
    delete;

decode_nl_msgtype_ctnetlink(?IPCTNL_MSG_CT_GET_CTRZERO) ->
    get_ctrzero;

decode_nl_msgtype_ctnetlink(Value) ->
    Value.

%% ============================

decode_nl_msgtype_ctnetlink_exp(?IPCTNL_MSG_EXP_NEW) ->
    new;

decode_nl_msgtype_ctnetlink_exp(?IPCTNL_MSG_EXP_GET) ->
    get;

decode_nl_msgtype_ctnetlink_exp(?IPCTNL_MSG_EXP_DELETE) ->
    delete;

decode_nl_msgtype_ctnetlink_exp(Value) ->
    Value.

%% ============================

decode_nl_msgtype_nftables(0) ->
    newtable;

decode_nl_msgtype_nftables(1) ->
    gettable;

decode_nl_msgtype_nftables(2) ->
    deltable;

decode_nl_msgtype_nftables(3) ->
    newchain;

decode_nl_msgtype_nftables(4) ->
    getchain;

decode_nl_msgtype_nftables(5) ->
    delchain;

decode_nl_msgtype_nftables(6) ->
    newrule;

decode_nl_msgtype_nftables(7) ->
    getrule;

decode_nl_msgtype_nftables(8) ->
    delrule;

decode_nl_msgtype_nftables(9) ->
    newset;

decode_nl_msgtype_nftables(10) ->
    getset;

decode_nl_msgtype_nftables(11) ->
    delset;

decode_nl_msgtype_nftables(12) ->
    newsetelem;

decode_nl_msgtype_nftables(13) ->
    getsetelem;

decode_nl_msgtype_nftables(14) ->
    delsetelem;

decode_nl_msgtype_nftables(15) ->
    newgen;

decode_nl_msgtype_nftables(16) ->
    getgen;

decode_nl_msgtype_nftables(Value) ->
    Value.

%% ============================

decode_nl_msgtype_nft_compat(0) ->
    get;

decode_nl_msgtype_nft_compat(Value) ->
    Value.

%% ============================

decode_nl_msgtype_generic(0) ->
    generate;

decode_nl_msgtype_generic(?NLMSG_MIN_TYPE) ->
    ctrl;

decode_nl_msgtype_generic(?NLMSG_MIN_TYPE + 1) ->
    vfs_dquot;

decode_nl_msgtype_generic(?NLMSG_MIN_TYPE + 2) ->
    pmcraid;

decode_nl_msgtype_generic(Value) ->
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

decode_ctnetlink(Family, 6, Value) ->
    {nat_src, nl_dec_nla(Family, fun decode_ctnetlink_snat_entry/3, Value)};

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

decode_ctnetlink(Family, 13, Value) ->
    {nat_dst, nl_dec_nla(Family, fun decode_ctnetlink_dnat_entry/3, Value)};

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

decode_ctnetlink(_Family, 21, Value) ->
    {mark_mask, decode_uint32(Value)};

decode_ctnetlink(_Family, 22, Value) ->
    {labels, decode_binary(Value)};

decode_ctnetlink(_Family, 23, Value) ->
    {labels_mask, decode_binary(Value)};

decode_ctnetlink(_Family, Id, Value) ->
    {Id, Value}.

%% ============================

decode_ctnetlink_snat_entry(_Family, 0, Value) ->
    {unspec, decode_none(Value)};

decode_ctnetlink_snat_entry(_Family, 1, Value) ->
    {v4_src, decode_addr(Value)};

decode_ctnetlink_snat_entry(_Family, 2, Value) ->
    {unspec, decode_none(Value)};

decode_ctnetlink_snat_entry(Family, 3, Value) ->
    {src_port, nl_dec_nla(Family, fun decode_ctnetlink_snat_entry_ports/3, Value)};

decode_ctnetlink_snat_entry(_Family, Id, Value) ->
    {Id, Value}.

%% ============================

decode_ctnetlink_snat_entry_ports(_Family, 0, Value) ->
    {unspec, decode_none(Value)};

decode_ctnetlink_snat_entry_ports(_Family, 1, Value) ->
    {min_port, decode_uint16(Value)};

decode_ctnetlink_snat_entry_ports(_Family, 2, Value) ->
    {max_port, decode_uint16(Value)};

decode_ctnetlink_snat_entry_ports(_Family, Id, Value) ->
    {Id, Value}.

%% ============================

decode_ctnetlink_dnat_entry(_Family, 0, Value) ->
    {unspec, decode_none(Value)};

decode_ctnetlink_dnat_entry(_Family, 1, Value) ->
    {v4_dst, decode_addr(Value)};

decode_ctnetlink_dnat_entry(_Family, 2, Value) ->
    {unspec, decode_none(Value)};

decode_ctnetlink_dnat_entry(Family, 3, Value) ->
    {dst_port, nl_dec_nla(Family, fun decode_ctnetlink_dnat_entry_ports/3, Value)};

decode_ctnetlink_dnat_entry(_Family, Id, Value) ->
    {Id, Value}.

%% ============================

decode_ctnetlink_dnat_entry_ports(_Family, 0, Value) ->
    {unspec, decode_none(Value)};

decode_ctnetlink_dnat_entry_ports(_Family, 1, Value) ->
    {min_port, decode_uint16(Value)};

decode_ctnetlink_dnat_entry_ports(_Family, 2, Value) ->
    {max_port, decode_uint16(Value)};

decode_ctnetlink_dnat_entry_ports(_Family, Id, Value) ->
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
    {net_ns_fd, decode_huint32(Value)};

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

decode_nl_msgtype_queue(?NFQNL_MSG_PACKET) ->
    packet;

decode_nl_msgtype_queue(?NFQNL_MSG_VERDICT) ->
    verdict;

decode_nl_msgtype_queue(?NFQNL_MSG_CONFIG) ->
    config;

decode_nl_msgtype_queue(?NFQNL_MSG_VERDICT_BATCH) ->
    verdict_batch;

decode_nl_msgtype_queue(Value) ->
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

decode_nfqnl_cfg_msg(_Family, 4, <<Value:32>>) ->
    {mask, decode_flag(flag_info_nfqnl_cfg_msg_mask(), Value)};

decode_nfqnl_cfg_msg(_Family, 5, <<Value:32>>) ->
    {flags, decode_flag(flag_info_nfqnl_cfg_msg_flags(), Value)};

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

decode_nfqnl_attr(Family, 11, Value) ->
    {ct, nl_dec_nla(Family, fun decode_ctnetlink/3, Value)};

decode_nfqnl_attr(_Family, 12, <<Value:32>>) ->
    {ct_info, decode_nfqnl_attr_ct_info(Value)};

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

decode_nfqnl_attr_ct_info(0) ->
    established;

decode_nfqnl_attr_ct_info(1) ->
    related;

decode_nfqnl_attr_ct_info(2) ->
    new;

decode_nfqnl_attr_ct_info(3) ->
    established_reply;

decode_nfqnl_attr_ct_info(4) ->
    related_reply;

decode_nfqnl_attr_ct_info(5) ->
    new_reply;

decode_nfqnl_attr_ct_info(Value) ->
    Value.

%% ============================

decode_nft_expr_attributes(_Family, 0, Value) ->
    {unspec, decode_none(Value)};

decode_nft_expr_attributes(_Family, 1, Value) ->
    {name, decode_string(Value)};

decode_nft_expr_attributes(_Family, 2, Value) ->
    {data, decode_binary(Value)};

decode_nft_expr_attributes(_Family, Id, Value) ->
    {Id, Value}.

%% ============================

decode_nft_immediate_attributes(_Family, 0, Value) ->
    {unspec, decode_none(Value)};

decode_nft_immediate_attributes(_Family, 1, Value) ->
    {dreg, decode_uint32(Value)};

decode_nft_immediate_attributes(Family, 2, Value) ->
    {data, nl_dec_nla(Family, fun decode_nft_data_attributes/3, Value)};

decode_nft_immediate_attributes(_Family, Id, Value) ->
    {Id, Value}.

%% ============================

decode_nft_data_attributes(_Family, 0, Value) ->
    {unspec, decode_none(Value)};

decode_nft_data_attributes(_Family, 1, Value) ->
    {value, decode_binary(Value)};

decode_nft_data_attributes(Family, 2, Value) ->
    {verdict, nl_dec_nla(Family, fun decode_nft_verdict_attributes/3, Value)};

decode_nft_data_attributes(_Family, Id, Value) ->
    {Id, Value}.

%% ============================

decode_nft_verdict_attributes(_Family, 0, Value) ->
    {unspec, decode_none(Value)};

decode_nft_verdict_attributes(_Family, 1, <<Value:32>>) ->
    {code, decode_nft_verdict_attributes_code(Value)};

decode_nft_verdict_attributes(_Family, 2, Value) ->
    {chain, decode_string(Value)};

decode_nft_verdict_attributes(_Family, Id, Value) ->
    {Id, Value}.

%% ============================

decode_nft_verdict_attributes_code(4294967295) ->
    continue;

decode_nft_verdict_attributes_code(4294967294) ->
    break;

decode_nft_verdict_attributes_code(4294967293) ->
    jump;

decode_nft_verdict_attributes_code(4294967292) ->
    goto;

decode_nft_verdict_attributes_code(4294967291) ->
    return;

decode_nft_verdict_attributes_code(Value) ->
    Value.

%% ============================

decode_nft_bitwise_attributes(_Family, 0, Value) ->
    {unspec, decode_none(Value)};

decode_nft_bitwise_attributes(_Family, 1, Value) ->
    {sreg, decode_uint32(Value)};

decode_nft_bitwise_attributes(_Family, 2, Value) ->
    {dreg, decode_uint32(Value)};

decode_nft_bitwise_attributes(_Family, 3, Value) ->
    {len, decode_uint32(Value)};

decode_nft_bitwise_attributes(Family, 4, Value) ->
    {mask, nl_dec_nla(Family, fun decode_nft_data_attributes/3, Value)};

decode_nft_bitwise_attributes(Family, 5, Value) ->
    {'xor', nl_dec_nla(Family, fun decode_nft_data_attributes/3, Value)};

decode_nft_bitwise_attributes(_Family, Id, Value) ->
    {Id, Value}.

%% ============================

decode_nft_lookup_attributes(_Family, 0, Value) ->
    {unspec, decode_none(Value)};

decode_nft_lookup_attributes(_Family, 1, Value) ->
    {set, decode_string(Value)};

decode_nft_lookup_attributes(_Family, 2, Value) ->
    {sreg, decode_uint32(Value)};

decode_nft_lookup_attributes(_Family, 3, Value) ->
    {dreg, decode_uint32(Value)};

decode_nft_lookup_attributes(_Family, 4, Value) ->
    {set_id, decode_uint32(Value)};

decode_nft_lookup_attributes(_Family, Id, Value) ->
    {Id, Value}.

%% ============================

decode_nft_meta_attributes(_Family, 0, Value) ->
    {unspec, decode_none(Value)};

decode_nft_meta_attributes(_Family, 1, Value) ->
    {dreg, decode_uint32(Value)};

decode_nft_meta_attributes(_Family, 2, <<Value:32>>) ->
    {key, decode_nft_meta_attributes_key(Value)};

decode_nft_meta_attributes(_Family, 3, Value) ->
    {sreg, decode_uint32(Value)};

decode_nft_meta_attributes(_Family, Id, Value) ->
    {Id, Value}.

%% ============================

decode_nft_meta_attributes_key(0) ->
    len;

decode_nft_meta_attributes_key(1) ->
    protocol;

decode_nft_meta_attributes_key(2) ->
    priority;

decode_nft_meta_attributes_key(3) ->
    mark;

decode_nft_meta_attributes_key(4) ->
    iif;

decode_nft_meta_attributes_key(5) ->
    oif;

decode_nft_meta_attributes_key(6) ->
    iifname;

decode_nft_meta_attributes_key(7) ->
    oifname;

decode_nft_meta_attributes_key(8) ->
    iiftype;

decode_nft_meta_attributes_key(9) ->
    oiftype;

decode_nft_meta_attributes_key(10) ->
    skuid;

decode_nft_meta_attributes_key(11) ->
    skgid;

decode_nft_meta_attributes_key(12) ->
    nftrace;

decode_nft_meta_attributes_key(13) ->
    rtclassid;

decode_nft_meta_attributes_key(14) ->
    secmark;

decode_nft_meta_attributes_key(15) ->
    nfproto;

decode_nft_meta_attributes_key(16) ->
    l4proto;

decode_nft_meta_attributes_key(17) ->
    bri_iifname;

decode_nft_meta_attributes_key(18) ->
    bri_oifname;

decode_nft_meta_attributes_key(19) ->
    pkttype;

decode_nft_meta_attributes_key(20) ->
    cpu;

decode_nft_meta_attributes_key(21) ->
    iifgroup;

decode_nft_meta_attributes_key(22) ->
    oifgroup;

decode_nft_meta_attributes_key(23) ->
    cgroup;

decode_nft_meta_attributes_key(Value) ->
    Value.

%% ============================

decode_nft_payload_attributes(_Family, 0, Value) ->
    {unspec, decode_none(Value)};

decode_nft_payload_attributes(_Family, 1, Value) ->
    {dreg, decode_uint32(Value)};

decode_nft_payload_attributes(_Family, 2, <<Value:32>>) ->
    {base, decode_nft_payload_attributes_base(Value)};

decode_nft_payload_attributes(_Family, 3, Value) ->
    {offset, decode_uint32(Value)};

decode_nft_payload_attributes(_Family, 4, Value) ->
    {len, decode_uint32(Value)};

decode_nft_payload_attributes(_Family, Id, Value) ->
    {Id, Value}.

%% ============================

decode_nft_payload_attributes_base(0) ->
    ll_header;

decode_nft_payload_attributes_base(1) ->
    network_header;

decode_nft_payload_attributes_base(2) ->
    transport_header;

decode_nft_payload_attributes_base(Value) ->
    Value.

%% ============================

decode_nft_reject_attributes(_Family, 0, Value) ->
    {unspec, decode_none(Value)};

decode_nft_reject_attributes(_Family, 1, <<Value:32>>) ->
    {type, decode_nft_reject_attributes_type(Value)};

decode_nft_reject_attributes(_Family, 2, <<Value:8>>) ->
    {icmp_code, decode_nft_reject_attributes_icmp_code(Value)};

decode_nft_reject_attributes(_Family, Id, Value) ->
    {Id, Value}.

%% ============================

decode_nft_reject_attributes_type(0) ->
    icmp_unreach;

decode_nft_reject_attributes_type(1) ->
    tcp_rst;

decode_nft_reject_attributes_type(2) ->
    icmpx_unreach;

decode_nft_reject_attributes_type(Value) ->
    Value.

%% ============================

decode_nft_reject_attributes_icmp_code(0) ->
    no_route;

decode_nft_reject_attributes_icmp_code(1) ->
    port_unreach;

decode_nft_reject_attributes_icmp_code(2) ->
    host_unreach;

decode_nft_reject_attributes_icmp_code(3) ->
    admin_prohibited;

decode_nft_reject_attributes_icmp_code(Value) ->
    Value.

%% ============================

decode_nft_ct_attributes(_Family, 0, Value) ->
    {unspec, decode_none(Value)};

decode_nft_ct_attributes(_Family, 1, Value) ->
    {dreg, decode_uint32(Value)};

decode_nft_ct_attributes(_Family, 2, <<Value:32>>) ->
    {key, decode_nft_ct_attributes_key(Value)};

decode_nft_ct_attributes(_Family, 3, Value) ->
    {direction, decode_uint8(Value)};

decode_nft_ct_attributes(_Family, 4, Value) ->
    {sreg, decode_uint32(Value)};

decode_nft_ct_attributes(_Family, Id, Value) ->
    {Id, Value}.

%% ============================

decode_nft_ct_attributes_key(0) ->
    state;

decode_nft_ct_attributes_key(1) ->
    direction;

decode_nft_ct_attributes_key(2) ->
    status;

decode_nft_ct_attributes_key(3) ->
    mark;

decode_nft_ct_attributes_key(4) ->
    secmark;

decode_nft_ct_attributes_key(5) ->
    expiration;

decode_nft_ct_attributes_key(6) ->
    helper;

decode_nft_ct_attributes_key(7) ->
    l3protocol;

decode_nft_ct_attributes_key(8) ->
    src;

decode_nft_ct_attributes_key(9) ->
    dst;

decode_nft_ct_attributes_key(10) ->
    protocol;

decode_nft_ct_attributes_key(11) ->
    proto_src;

decode_nft_ct_attributes_key(12) ->
    proto_dst;

decode_nft_ct_attributes_key(13) ->
    labels;

decode_nft_ct_attributes_key(Value) ->
    Value.

%% ============================

decode_nft_queue_attributes(_Family, 0, Value) ->
    {unspec, decode_none(Value)};

decode_nft_queue_attributes(_Family, 1, Value) ->
    {num, decode_uint16(Value)};

decode_nft_queue_attributes(_Family, 2, Value) ->
    {total, decode_uint16(Value)};

decode_nft_queue_attributes(_Family, 3, <<Value:16>>) ->
    {flags, decode_flag(flag_info_nft_queue_attributes_flags(), Value)};

decode_nft_queue_attributes(_Family, Id, Value) ->
    {Id, Value}.

%% ============================

decode_nft_cmp_attributes(_Family, 0, Value) ->
    {unspec, decode_none(Value)};

decode_nft_cmp_attributes(_Family, 1, Value) ->
    {sreg, decode_uint32(Value)};

decode_nft_cmp_attributes(_Family, 2, <<Value:32>>) ->
    {op, decode_nft_cmp_attributes_op(Value)};

decode_nft_cmp_attributes(Family, 3, Value) ->
    {data, nl_dec_nla(Family, fun decode_nft_data_attributes/3, Value)};

decode_nft_cmp_attributes(_Family, Id, Value) ->
    {Id, Value}.

%% ============================

decode_nft_cmp_attributes_op(0) ->
    eq;

decode_nft_cmp_attributes_op(1) ->
    neq;

decode_nft_cmp_attributes_op(2) ->
    lt;

decode_nft_cmp_attributes_op(3) ->
    lte;

decode_nft_cmp_attributes_op(4) ->
    gt;

decode_nft_cmp_attributes_op(5) ->
    gte;

decode_nft_cmp_attributes_op(Value) ->
    Value.

%% ============================

decode_nft_match_attributes(_Family, 0, Value) ->
    {unspec, decode_none(Value)};

decode_nft_match_attributes(_Family, 1, Value) ->
    {name, decode_string(Value)};

decode_nft_match_attributes(_Family, 2, Value) ->
    {rev, decode_uint32(Value)};

decode_nft_match_attributes(_Family, 3, Value) ->
    {info, decode_binary(Value)};

decode_nft_match_attributes(_Family, Id, Value) ->
    {Id, Value}.

%% ============================

decode_nft_target_attributes(_Family, 0, Value) ->
    {unspec, decode_none(Value)};

decode_nft_target_attributes(_Family, 1, Value) ->
    {name, decode_string(Value)};

decode_nft_target_attributes(_Family, 2, Value) ->
    {rev, decode_uint32(Value)};

decode_nft_target_attributes(_Family, 3, Value) ->
    {info, decode_binary(Value)};

decode_nft_target_attributes(_Family, Id, Value) ->
    {Id, Value}.

%% ============================

decode_nft_list_attributes_expr(_Family, 0, Value) ->
    {unspec, decode_none(Value)};

decode_nft_list_attributes_expr(Family, 1, Value) ->
    {expr, nl_dec_nla(Family, fun decode_nft_expr_attributes/3, Value)};

decode_nft_list_attributes_expr(_Family, Id, Value) ->
    {Id, Value}.

%% ============================

decode_nft_counter_attributes(_Family, 0, Value) ->
    {unspec, decode_none(Value)};

decode_nft_counter_attributes(_Family, 1, Value) ->
    {bytes, decode_uint64(Value)};

decode_nft_counter_attributes(_Family, 2, Value) ->
    {packets, decode_uint64(Value)};

decode_nft_counter_attributes(_Family, Id, Value) ->
    {Id, Value}.

%% ============================

decode_nft_table_attributes(_Family, 0, Value) ->
    {unspec, decode_none(Value)};

decode_nft_table_attributes(_Family, 1, Value) ->
    {name, decode_string(Value)};

decode_nft_table_attributes(_Family, 2, <<Value:32>>) ->
    {flags, decode_flag(flag_info_nft_table_attributes_flags(), Value)};

decode_nft_table_attributes(_Family, 3, Value) ->
    {use, decode_uint32(Value)};

decode_nft_table_attributes(_Family, Id, Value) ->
    {Id, Value}.

%% ============================

decode_nft_chain_attributes(_Family, 0, Value) ->
    {unspec, decode_none(Value)};

decode_nft_chain_attributes(_Family, 1, Value) ->
    {table, decode_string(Value)};

decode_nft_chain_attributes(_Family, 2, Value) ->
    {handle, decode_uint64(Value)};

decode_nft_chain_attributes(_Family, 3, Value) ->
    {name, decode_string(Value)};

decode_nft_chain_attributes(Family, 4, Value) ->
    {hook, nl_dec_nla(Family, fun decode_nft_chain_attributes_hook/3, Value)};

decode_nft_chain_attributes(_Family, 5, <<Value:32>>) ->
    {policy, decode_nft_chain_attributes_policy(Value)};

decode_nft_chain_attributes(_Family, 6, Value) ->
    {use, decode_uint32(Value)};

decode_nft_chain_attributes(_Family, 7, Value) ->
    {type, decode_string(Value)};

decode_nft_chain_attributes(Family, 8, Value) ->
    {counters, nl_dec_nla(Family, fun decode_nft_counter_attributes/3, Value)};

decode_nft_chain_attributes(_Family, Id, Value) ->
    {Id, Value}.

%% ============================

decode_nft_chain_attributes_hook(_Family, 0, Value) ->
    {unspec, decode_none(Value)};

decode_nft_chain_attributes_hook(_Family, 1, Value) ->
    {hooknum, decode_uint32(Value)};

decode_nft_chain_attributes_hook(_Family, 2, Value) ->
    {priority, decode_int32(Value)};

decode_nft_chain_attributes_hook(_Family, 3, Value) ->
    {dev, decode_string(Value)};

decode_nft_chain_attributes_hook(_Family, Id, Value) ->
    {Id, Value}.

%% ============================

decode_nft_chain_attributes_policy(0) ->
    drop;

decode_nft_chain_attributes_policy(1) ->
    accept;

decode_nft_chain_attributes_policy(2) ->
    stolen;

decode_nft_chain_attributes_policy(3) ->
    queue;

decode_nft_chain_attributes_policy(4) ->
    repeat;

decode_nft_chain_attributes_policy(5) ->
    stop;

decode_nft_chain_attributes_policy(Value) ->
    Value.

%% ============================

decode_nft_rule_attributes(_Family, 0, Value) ->
    {unspec, decode_none(Value)};

decode_nft_rule_attributes(_Family, 1, Value) ->
    {table, decode_string(Value)};

decode_nft_rule_attributes(_Family, 2, Value) ->
    {chain, decode_string(Value)};

decode_nft_rule_attributes(_Family, 3, Value) ->
    {handle, decode_uint64(Value)};

decode_nft_rule_attributes(Family, 4, Value) ->
    {expressions, nl_dec_nla(Family, fun decode_nft_list_attributes_expr/3, Value)};

decode_nft_rule_attributes(_Family, 5, Value) ->
    {compat, decode_binary(Value)};

decode_nft_rule_attributes(_Family, 6, Value) ->
    {position, decode_uint64(Value)};

decode_nft_rule_attributes(_Family, 7, Value) ->
    {userdata, decode_binary(Value)};

decode_nft_rule_attributes(_Family, Id, Value) ->
    {Id, Value}.

%% ============================

decode_nft_set_attributes(_Family, 0, Value) ->
    {unspec, decode_none(Value)};

decode_nft_set_attributes(_Family, 1, Value) ->
    {table, decode_string(Value)};

decode_nft_set_attributes(_Family, 2, Value) ->
    {name, decode_string(Value)};

decode_nft_set_attributes(_Family, 3, <<Value:32>>) ->
    {flags, decode_flag(flag_info_nft_set_attributes_flags(), Value)};

decode_nft_set_attributes(_Family, 4, Value) ->
    {key_type, decode_binary(Value)};

decode_nft_set_attributes(_Family, 5, Value) ->
    {key_len, decode_uint32(Value)};

decode_nft_set_attributes(_Family, 6, Value) ->
    {data_type, decode_binary(Value)};

decode_nft_set_attributes(_Family, 7, Value) ->
    {data_len, decode_uint32(Value)};

decode_nft_set_attributes(_Family, 8, <<Value:32>>) ->
    {policy, decode_nft_set_attributes_policy(Value)};

decode_nft_set_attributes(_Family, 9, Value) ->
    {desc, decode_binary(Value)};

decode_nft_set_attributes(_Family, 10, Value) ->
    {id, decode_uint32(Value)};

decode_nft_set_attributes(_Family, 11, Value) ->
    {timeout, decode_uint64(Value)};

decode_nft_set_attributes(_Family, 12, Value) ->
    {gc_interval, decode_uint32(Value)};

decode_nft_set_attributes(_Family, Id, Value) ->
    {Id, Value}.

%% ============================

decode_nft_set_attributes_policy(0) ->
    drop;

decode_nft_set_attributes_policy(1) ->
    accept;

decode_nft_set_attributes_policy(2) ->
    stolen;

decode_nft_set_attributes_policy(3) ->
    queue;

decode_nft_set_attributes_policy(4) ->
    repeat;

decode_nft_set_attributes_policy(5) ->
    stop;

decode_nft_set_attributes_policy(Value) ->
    Value.

%% ============================

decode_nft_set_elem_list_attributes(_Family, 0, Value) ->
    {unspec, decode_none(Value)};

decode_nft_set_elem_list_attributes(_Family, 1, Value) ->
    {table, decode_string(Value)};

decode_nft_set_elem_list_attributes(_Family, 2, Value) ->
    {set, decode_string(Value)};

decode_nft_set_elem_list_attributes(Family, 3, Value) ->
    {elements, nl_dec_nla(Family, fun decode_nft_set_elem_list_elements/3, Value)};

decode_nft_set_elem_list_attributes(_Family, 4, Value) ->
    {set_id, decode_uint32(Value)};

decode_nft_set_elem_list_attributes(_Family, Id, Value) ->
    {Id, Value}.

%% ============================

decode_nft_set_elem_list_elements(_Family, 0, Value) ->
    {unspec, decode_none(Value)};

decode_nft_set_elem_list_elements(Family, 1, Value) ->
    {element, nl_dec_nla(Family, fun decode_nft_set_ext_attributes/3, Value)};

decode_nft_set_elem_list_elements(_Family, Id, Value) ->
    {Id, Value}.

%% ============================

decode_nft_set_ext_attributes(_Family, 0, Value) ->
    {unspec, decode_none(Value)};

decode_nft_set_ext_attributes(Family, 1, Value) ->
    {key, nl_dec_nla(Family, fun decode_nft_data_attributes/3, Value)};

decode_nft_set_ext_attributes(Family, 2, Value) ->
    {data, nl_dec_nla(Family, fun decode_nft_data_attributes/3, Value)};

decode_nft_set_ext_attributes(_Family, 3, <<Value:32>>) ->
    {flags, decode_flag(flag_info_nft_set_ext_attributes_flags(), Value)};

decode_nft_set_ext_attributes(_Family, 4, Value) ->
    {timeout, decode_uint64(Value)};

decode_nft_set_ext_attributes(_Family, 5, Value) ->
    {expiration, decode_uint64(Value)};

decode_nft_set_ext_attributes(_Family, 6, Value) ->
    {userdata, decode_binary(Value)};

decode_nft_set_ext_attributes(Family, 7, Value) ->
    {expr, nl_dec_nla(Family, fun decode_nft_expr_attributes/3, Value)};

decode_nft_set_ext_attributes(_Family, Id, Value) ->
    {Id, Value}.

%% ============================

decode_nft_gen_attributes(_Family, 0, Value) ->
    {unspec, decode_none(Value)};

decode_nft_gen_attributes(_Family, 1, Value) ->
    {id, decode_uint32(Value)};

decode_nft_gen_attributes(_Family, Id, Value) ->
    {Id, Value}.

%% ============================

decode_genl_ctrl_cmd(0) ->
    unspec;

decode_genl_ctrl_cmd(1) ->
    newfamily;

decode_genl_ctrl_cmd(2) ->
    delfamily;

decode_genl_ctrl_cmd(3) ->
    getfamily;

decode_genl_ctrl_cmd(4) ->
    newops;

decode_genl_ctrl_cmd(5) ->
    delops;

decode_genl_ctrl_cmd(6) ->
    getops;

decode_genl_ctrl_cmd(7) ->
    newmcast_grp;

decode_genl_ctrl_cmd(8) ->
    delmcast_grp;

decode_genl_ctrl_cmd(9) ->
    getmcast_grp;

decode_genl_ctrl_cmd(Value) ->
    Value.

%% ============================

decode_genl_ctrl_attr(_Family, 0, Value) ->
    {unspec, decode_none(Value)};

decode_genl_ctrl_attr(_Family, 1, Value) ->
    {family_id, decode_protocol_subsys(decode_huint16(Value))};

decode_genl_ctrl_attr(_Family, 2, Value) ->
    {family_name, decode_string(Value)};

decode_genl_ctrl_attr(_Family, 3, Value) ->
    {version, decode_huint32(Value)};

decode_genl_ctrl_attr(_Family, 4, Value) ->
    {hdrsize, decode_huint32(Value)};

decode_genl_ctrl_attr(_Family, 5, Value) ->
    {maxattr, decode_huint32(Value)};

decode_genl_ctrl_attr(Family, 6, Value) ->
    {ops, nl_dec_nla(Family, fun decode_genl_ctrl_attr_ops/3, Value)};

decode_genl_ctrl_attr(Family, 7, Value) ->
    {mcast_groups, nl_dec_nla(Family, fun decode_genl_ctrl_attr_mcast_groups/3, Value)};

decode_genl_ctrl_attr(_Family, Id, Value) ->
    {Id, Value}.

%% ============================

decode_genl_ctrl_attr_op(_Family, 0, Value) ->
    {unspec, decode_none(Value)};

decode_genl_ctrl_attr_op(_Family, 1, Value) ->
    {id, decode_huint32(Value)};

decode_genl_ctrl_attr_op(_Family, 2, Value) ->
    {flags, decode_huint32(Value)};

decode_genl_ctrl_attr_op(_Family, Id, Value) ->
    {Id, Value}.

%% ============================

decode_genl_ctrl_attr_mcast_grp(_Family, 0, Value) ->
    {unspec, decode_none(Value)};

decode_genl_ctrl_attr_mcast_grp(_Family, 1, Value) ->
    {name, decode_string(Value)};

decode_genl_ctrl_attr_mcast_grp(_Family, 2, Value) ->
    {id, decode_huint32(Value)};

decode_genl_ctrl_attr_mcast_grp(_Family, Id, Value) ->
    {Id, Value}.

%% ============================

decode_linkinfo_gtp(_Family, 0, Value) ->
    {unspec, decode_none(Value)};

decode_linkinfo_gtp(_Family, 1, Value) ->
    {fd0, decode_huint32(Value)};

decode_linkinfo_gtp(_Family, 2, Value) ->
    {fd1, decode_huint32(Value)};

decode_linkinfo_gtp(_Family, 3, Value) ->
    {hashsize, decode_huint32(Value)};

decode_linkinfo_gtp(_Family, Id, Value) ->
    {Id, Value}.

%% ============================

decode_gtp_cmd(0) ->
    new;

decode_gtp_cmd(1) ->
    delete;

decode_gtp_cmd(2) ->
    get;

decode_gtp_cmd(Value) ->
    Value.

%% ============================

decode_gtp_attrs(_Family, 0, Value) ->
    {unspec, decode_none(Value)};

decode_gtp_attrs(_Family, 1, Value) ->
    {link, decode_huint32(Value)};

decode_gtp_attrs(_Family, 2, Value) ->
    {version, decode_huint32(Value)};

decode_gtp_attrs(_Family, 3, Value) ->
    {tid, decode_huint64(Value)};

decode_gtp_attrs(_Family, 4, Value) ->
    {sgsn_address, decode_addr(Value)};

decode_gtp_attrs(_Family, 5, Value) ->
    {ms_address, decode_addr(Value)};

decode_gtp_attrs(_Family, 6, Value) ->
    {flow, decode_huint16(Value)};

decode_gtp_attrs(_Family, 7, Value) ->
    {net_ns_fd, decode_huint32(Value)};

decode_gtp_attrs(_Family, 8, Value) ->
    {i_tid, decode_huint32(Value)};

decode_gtp_attrs(_Family, 9, Value) ->
    {o_tid, decode_huint32(Value)};

decode_gtp_attrs(_Family, Id, Value) ->
    {Id, Value}.

%% ============================

encode_protocol_subsys(rtnetlink) ->
    ?NETLINK_ROUTE;

encode_protocol_subsys(usersock) ->
    ?NETLINK_USERSOCK;

encode_protocol_subsys(firewall) ->
    ?NETLINK_FIREWALL;

encode_protocol_subsys(inet_diag) ->
    ?NETLINK_INET_DIAG;

encode_protocol_subsys(nflog) ->
    ?NETLINK_NFLOG;

encode_protocol_subsys(xfrm) ->
    ?NETLINK_XFRM;

encode_protocol_subsys(selinux) ->
    ?NETLINK_SELINUX;

encode_protocol_subsys(iscsi) ->
    ?NETLINK_ISCSI;

encode_protocol_subsys(audit) ->
    ?NETLINK_AUDIT;

encode_protocol_subsys(fib_lookup) ->
    ?NETLINK_FIB_LOOKUP;

encode_protocol_subsys(connector) ->
    ?NETLINK_CONNECTOR;

encode_protocol_subsys(netfilter) ->
    ?NETLINK_NETFILTER;

encode_protocol_subsys(ip6_fw) ->
    ?NETLINK_IP6_FW;

encode_protocol_subsys(dnrtmsg) ->
    ?NETLINK_DNRTMSG;

encode_protocol_subsys(kobject_uevent) ->
    ?NETLINK_KOBJECT_UEVENT;

encode_protocol_subsys(generic) ->
    ?NETLINK_GENERIC;

encode_protocol_subsys(scsitransport) ->
    ?NETLINK_SCSITRANSPORT;

encode_protocol_subsys(ecryptfs) ->
    ?NETLINK_ECRYPTFS;

encode_protocol_subsys(Value) when is_integer(Value) ->
    Value.

%% ============================

encode_nl_subsys(netlink) ->
    0;

encode_nl_subsys(ctnetlink) ->
    1;

encode_nl_subsys(ctnetlink_exp) ->
    2;

encode_nl_subsys(queue) ->
    3;

encode_nl_subsys(ulog) ->
    4;

encode_nl_subsys(osf) ->
    5;

encode_nl_subsys(ipset) ->
    6;

encode_nl_subsys(acct) ->
    7;

encode_nl_subsys(ctnetlink_timeout) ->
    8;

encode_nl_subsys(cthelper) ->
    9;

encode_nl_subsys(nftables) ->
    10;

encode_nl_subsys(nft_compat) ->
    11;

encode_nl_subsys(count) ->
    12;

encode_nl_subsys(Value) when is_integer(Value) ->
    Value.

%% ============================

encode_rtm_msgtype_rtnetlink(noop) ->
    ?NLMSG_NOOP;

encode_rtm_msgtype_rtnetlink(error) ->
    ?NLMSG_ERROR;

encode_rtm_msgtype_rtnetlink(done) ->
    ?NLMSG_DONE;

encode_rtm_msgtype_rtnetlink(overrun) ->
    ?NLMSG_OVERRUN;

encode_rtm_msgtype_rtnetlink(newlink) ->
    ?RTM_NEWLINK;

encode_rtm_msgtype_rtnetlink(dellink) ->
    ?RTM_DELLINK;

encode_rtm_msgtype_rtnetlink(getlink) ->
    ?RTM_GETLINK;

encode_rtm_msgtype_rtnetlink(setlink) ->
    ?RTM_SETLINK;

encode_rtm_msgtype_rtnetlink(newaddr) ->
    ?RTM_NEWADDR;

encode_rtm_msgtype_rtnetlink(deladdr) ->
    ?RTM_DELADDR;

encode_rtm_msgtype_rtnetlink(getaddr) ->
    ?RTM_GETADDR;

encode_rtm_msgtype_rtnetlink(newroute) ->
    ?RTM_NEWROUTE;

encode_rtm_msgtype_rtnetlink(delroute) ->
    ?RTM_DELROUTE;

encode_rtm_msgtype_rtnetlink(getroute) ->
    ?RTM_GETROUTE;

encode_rtm_msgtype_rtnetlink(newneigh) ->
    ?RTM_NEWNEIGH;

encode_rtm_msgtype_rtnetlink(delneigh) ->
    ?RTM_DELNEIGH;

encode_rtm_msgtype_rtnetlink(getneigh) ->
    ?RTM_GETNEIGH;

encode_rtm_msgtype_rtnetlink(newrule) ->
    ?RTM_NEWRULE;

encode_rtm_msgtype_rtnetlink(delrule) ->
    ?RTM_DELRULE;

encode_rtm_msgtype_rtnetlink(getrule) ->
    ?RTM_GETRULE;

encode_rtm_msgtype_rtnetlink(newqdisc) ->
    ?RTM_NEWQDISC;

encode_rtm_msgtype_rtnetlink(delqdisc) ->
    ?RTM_DELQDISC;

encode_rtm_msgtype_rtnetlink(getqdisc) ->
    ?RTM_GETQDISC;

encode_rtm_msgtype_rtnetlink(newtclass) ->
    ?RTM_NEWTCLASS;

encode_rtm_msgtype_rtnetlink(deltclass) ->
    ?RTM_DELTCLASS;

encode_rtm_msgtype_rtnetlink(gettclass) ->
    ?RTM_GETTCLASS;

encode_rtm_msgtype_rtnetlink(newtfilter) ->
    ?RTM_NEWTFILTER;

encode_rtm_msgtype_rtnetlink(deltfilter) ->
    ?RTM_DELTFILTER;

encode_rtm_msgtype_rtnetlink(gettfilter) ->
    ?RTM_GETTFILTER;

encode_rtm_msgtype_rtnetlink(newaction) ->
    ?RTM_NEWACTION;

encode_rtm_msgtype_rtnetlink(delaction) ->
    ?RTM_DELACTION;

encode_rtm_msgtype_rtnetlink(getaction) ->
    ?RTM_GETACTION;

encode_rtm_msgtype_rtnetlink(newprefix) ->
    ?RTM_NEWPREFIX;

encode_rtm_msgtype_rtnetlink(getmulticast) ->
    ?RTM_GETMULTICAST;

encode_rtm_msgtype_rtnetlink(getanycast) ->
    ?RTM_GETANYCAST;

encode_rtm_msgtype_rtnetlink(newneightbl) ->
    ?RTM_NEWNEIGHTBL;

encode_rtm_msgtype_rtnetlink(getneightbl) ->
    ?RTM_GETNEIGHTBL;

encode_rtm_msgtype_rtnetlink(setneightbl) ->
    ?RTM_SETNEIGHTBL;

encode_rtm_msgtype_rtnetlink(newnduseropt) ->
    ?RTM_NEWNDUSEROPT;

encode_rtm_msgtype_rtnetlink(newaddrlabel) ->
    ?RTM_NEWADDRLABEL;

encode_rtm_msgtype_rtnetlink(deladdrlabel) ->
    ?RTM_DELADDRLABEL;

encode_rtm_msgtype_rtnetlink(getaddrlabel) ->
    ?RTM_GETADDRLABEL;

encode_rtm_msgtype_rtnetlink(getdcb) ->
    ?RTM_GETDCB;

encode_rtm_msgtype_rtnetlink(setdcb) ->
    ?RTM_SETDCB;

encode_rtm_msgtype_rtnetlink(Value) when is_integer(Value) ->
    Value.

%% ============================

encode_nl_msgtype_nlmsg(noop) ->
    ?NLMSG_NOOP;

encode_nl_msgtype_nlmsg(error) ->
    ?NLMSG_ERROR;

encode_nl_msgtype_nlmsg(done) ->
    ?NLMSG_DONE;

encode_nl_msgtype_nlmsg(overrun) ->
    ?NLMSG_OVERRUN;

encode_nl_msgtype_nlmsg(Value) when is_integer(Value) ->
    Value.

%% ============================

encode_nl_msgtype_nfnl('begin') ->
    ?NFNL_MSG_BATCH_BEGIN;

encode_nl_msgtype_nfnl('end') ->
    ?NFNL_MSG_BATCH_END;

encode_nl_msgtype_nfnl(Value) when is_integer(Value) ->
    Value.

%% ============================

encode_nl_msgtype_ctnetlink(new) ->
    ?IPCTNL_MSG_CT_NEW;

encode_nl_msgtype_ctnetlink(get) ->
    ?IPCTNL_MSG_CT_GET;

encode_nl_msgtype_ctnetlink(delete) ->
    ?IPCTNL_MSG_CT_DELETE;

encode_nl_msgtype_ctnetlink(get_ctrzero) ->
    ?IPCTNL_MSG_CT_GET_CTRZERO;

encode_nl_msgtype_ctnetlink(Value) when is_integer(Value) ->
    Value.

%% ============================

encode_nl_msgtype_ctnetlink_exp(new) ->
    ?IPCTNL_MSG_EXP_NEW;

encode_nl_msgtype_ctnetlink_exp(get) ->
    ?IPCTNL_MSG_EXP_GET;

encode_nl_msgtype_ctnetlink_exp(delete) ->
    ?IPCTNL_MSG_EXP_DELETE;

encode_nl_msgtype_ctnetlink_exp(Value) when is_integer(Value) ->
    Value.

%% ============================

encode_nl_msgtype_nftables(newtable) ->
    0;

encode_nl_msgtype_nftables(gettable) ->
    1;

encode_nl_msgtype_nftables(deltable) ->
    2;

encode_nl_msgtype_nftables(newchain) ->
    3;

encode_nl_msgtype_nftables(getchain) ->
    4;

encode_nl_msgtype_nftables(delchain) ->
    5;

encode_nl_msgtype_nftables(newrule) ->
    6;

encode_nl_msgtype_nftables(getrule) ->
    7;

encode_nl_msgtype_nftables(delrule) ->
    8;

encode_nl_msgtype_nftables(newset) ->
    9;

encode_nl_msgtype_nftables(getset) ->
    10;

encode_nl_msgtype_nftables(delset) ->
    11;

encode_nl_msgtype_nftables(newsetelem) ->
    12;

encode_nl_msgtype_nftables(getsetelem) ->
    13;

encode_nl_msgtype_nftables(delsetelem) ->
    14;

encode_nl_msgtype_nftables(newgen) ->
    15;

encode_nl_msgtype_nftables(getgen) ->
    16;

encode_nl_msgtype_nftables(Value) when is_integer(Value) ->
    Value.

%% ============================

encode_nl_msgtype_nft_compat(get) ->
    0;

encode_nl_msgtype_nft_compat(Value) when is_integer(Value) ->
    Value.

%% ============================

encode_nl_msgtype_generic(generate) ->
    0;

encode_nl_msgtype_generic(ctrl) ->
    ?NLMSG_MIN_TYPE;

encode_nl_msgtype_generic(vfs_dquot) ->
    ?NLMSG_MIN_TYPE + 1;

encode_nl_msgtype_generic(pmcraid) ->
    ?NLMSG_MIN_TYPE + 2;

encode_nl_msgtype_generic(Value) when is_integer(Value) ->
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

encode_ctnetlink(Family, {nat_src, Value}) ->
    enc_nla(6 bor 16#8000, nl_enc_nla(Family, fun encode_ctnetlink_snat_entry/2, Value));

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

encode_ctnetlink(Family, {nat_dst, Value}) ->
    enc_nla(13 bor 16#8000, nl_enc_nla(Family, fun encode_ctnetlink_dnat_entry/2, Value));

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

encode_ctnetlink(_Family, {mark_mask, Value}) ->
    encode_uint32(21, Value);

encode_ctnetlink(_Family, {labels, Value}) ->
    encode_binary(22, Value);

encode_ctnetlink(_Family, {labels_mask, Value}) ->
    encode_binary(23, Value);

encode_ctnetlink(_Family, {Type, Value})
  when is_integer(Type), is_binary(Value) ->
    enc_nla(Type, Value).

%% ============================

encode_ctnetlink_snat_entry(_Family, {unspec, Value}) ->
    encode_none(0, Value);

encode_ctnetlink_snat_entry(_Family, {v4_src, Value}) ->
    encode_addr(1, Value);

encode_ctnetlink_snat_entry(_Family, {unspec, Value}) ->
    encode_none(2, Value);

encode_ctnetlink_snat_entry(Family, {src_port, Value}) ->
    enc_nla(3 bor 16#8000, nl_enc_nla(Family, fun encode_ctnetlink_snat_entry_ports/2, Value));

encode_ctnetlink_snat_entry(_Family, {Type, Value})
  when is_integer(Type), is_binary(Value) ->
    enc_nla(Type, Value).

%% ============================

encode_ctnetlink_snat_entry_ports(_Family, {unspec, Value}) ->
    encode_none(0, Value);

encode_ctnetlink_snat_entry_ports(_Family, {min_port, Value}) ->
    encode_uint16(1, Value);

encode_ctnetlink_snat_entry_ports(_Family, {max_port, Value}) ->
    encode_uint16(2, Value);

encode_ctnetlink_snat_entry_ports(_Family, {Type, Value})
  when is_integer(Type), is_binary(Value) ->
    enc_nla(Type, Value).

%% ============================

encode_ctnetlink_dnat_entry(_Family, {unspec, Value}) ->
    encode_none(0, Value);

encode_ctnetlink_dnat_entry(_Family, {v4_dst, Value}) ->
    encode_addr(1, Value);

encode_ctnetlink_dnat_entry(_Family, {unspec, Value}) ->
    encode_none(2, Value);

encode_ctnetlink_dnat_entry(Family, {dst_port, Value}) ->
    enc_nla(3 bor 16#8000, nl_enc_nla(Family, fun encode_ctnetlink_dnat_entry_ports/2, Value));

encode_ctnetlink_dnat_entry(_Family, {Type, Value})
  when is_integer(Type), is_binary(Value) ->
    enc_nla(Type, Value).

%% ============================

encode_ctnetlink_dnat_entry_ports(_Family, {unspec, Value}) ->
    encode_none(0, Value);

encode_ctnetlink_dnat_entry_ports(_Family, {min_port, Value}) ->
    encode_uint16(1, Value);

encode_ctnetlink_dnat_entry_ports(_Family, {max_port, Value}) ->
    encode_uint16(2, Value);

encode_ctnetlink_dnat_entry_ports(_Family, {Type, Value})
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
    encode_huint32(28, Value);

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

encode_nl_msgtype_queue(packet) ->
    ?NFQNL_MSG_PACKET;

encode_nl_msgtype_queue(verdict) ->
    ?NFQNL_MSG_VERDICT;

encode_nl_msgtype_queue(config) ->
    ?NFQNL_MSG_CONFIG;

encode_nl_msgtype_queue(verdict_batch) ->
    ?NFQNL_MSG_VERDICT_BATCH;

encode_nl_msgtype_queue(Value) when is_integer(Value) ->
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
    encode_uint32(4, encode_flag(flag_info_nfqnl_cfg_msg_mask(), Value));

encode_nfqnl_cfg_msg(_Family, {flags, Value}) ->
    encode_uint32(5, encode_flag(flag_info_nfqnl_cfg_msg_flags(), Value));

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

encode_nfqnl_attr(Family, {ct, Value}) ->
    enc_nla(11, nl_enc_nla(Family, fun encode_ctnetlink/2, Value));

encode_nfqnl_attr(_Family, {ct_info, Value}) ->
    encode_uint32(12, encode_nfqnl_attr_ct_info(Value));

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

%% ============================

encode_nfqnl_attr_ct_info(established) ->
    0;

encode_nfqnl_attr_ct_info(related) ->
    1;

encode_nfqnl_attr_ct_info(new) ->
    2;

encode_nfqnl_attr_ct_info(established_reply) ->
    3;

encode_nfqnl_attr_ct_info(related_reply) ->
    4;

encode_nfqnl_attr_ct_info(new_reply) ->
    5;

encode_nfqnl_attr_ct_info(Value) when is_integer(Value) ->
    Value.

%% ============================

encode_nft_expr_attributes(_Family, {unspec, Value}) ->
    encode_none(0, Value);

encode_nft_expr_attributes(_Family, {name, Value}) ->
    encode_string(1, Value);

encode_nft_expr_attributes(_Family, {data, Value}) ->
    encode_binary(2, Value);

encode_nft_expr_attributes(_Family, {Type, Value})
  when is_integer(Type), is_binary(Value) ->
    enc_nla(Type, Value).

%% ============================

encode_nft_immediate_attributes(_Family, {unspec, Value}) ->
    encode_none(0, Value);

encode_nft_immediate_attributes(_Family, {dreg, Value}) ->
    encode_uint32(1, Value);

encode_nft_immediate_attributes(Family, {data, Value}) ->
    enc_nla(2, nl_enc_nla(Family, fun encode_nft_data_attributes/2, Value));

encode_nft_immediate_attributes(_Family, {Type, Value})
  when is_integer(Type), is_binary(Value) ->
    enc_nla(Type, Value).

%% ============================

encode_nft_data_attributes(_Family, {unspec, Value}) ->
    encode_none(0, Value);

encode_nft_data_attributes(_Family, {value, Value}) ->
    encode_binary(1, Value);

encode_nft_data_attributes(Family, {verdict, Value}) ->
    enc_nla(2, nl_enc_nla(Family, fun encode_nft_verdict_attributes/2, Value));

encode_nft_data_attributes(_Family, {Type, Value})
  when is_integer(Type), is_binary(Value) ->
    enc_nla(Type, Value).

%% ============================

encode_nft_verdict_attributes(_Family, {unspec, Value}) ->
    encode_none(0, Value);

encode_nft_verdict_attributes(_Family, {code, Value}) ->
    encode_uint32(1, encode_nft_verdict_attributes_code(Value));

encode_nft_verdict_attributes(_Family, {chain, Value}) ->
    encode_string(2, Value);

encode_nft_verdict_attributes(_Family, {Type, Value})
  when is_integer(Type), is_binary(Value) ->
    enc_nla(Type, Value).

%% ============================

encode_nft_verdict_attributes_code(continue) ->
    4294967295;

encode_nft_verdict_attributes_code(break) ->
    4294967294;

encode_nft_verdict_attributes_code(jump) ->
    4294967293;

encode_nft_verdict_attributes_code(goto) ->
    4294967292;

encode_nft_verdict_attributes_code(return) ->
    4294967291;

encode_nft_verdict_attributes_code(Value) when is_integer(Value) ->
    Value.

%% ============================

encode_nft_bitwise_attributes(_Family, {unspec, Value}) ->
    encode_none(0, Value);

encode_nft_bitwise_attributes(_Family, {sreg, Value}) ->
    encode_uint32(1, Value);

encode_nft_bitwise_attributes(_Family, {dreg, Value}) ->
    encode_uint32(2, Value);

encode_nft_bitwise_attributes(_Family, {len, Value}) ->
    encode_uint32(3, Value);

encode_nft_bitwise_attributes(Family, {mask, Value}) ->
    enc_nla(4, nl_enc_nla(Family, fun encode_nft_data_attributes/2, Value));

encode_nft_bitwise_attributes(Family, {'xor', Value}) ->
    enc_nla(5, nl_enc_nla(Family, fun encode_nft_data_attributes/2, Value));

encode_nft_bitwise_attributes(_Family, {Type, Value})
  when is_integer(Type), is_binary(Value) ->
    enc_nla(Type, Value).

%% ============================

encode_nft_lookup_attributes(_Family, {unspec, Value}) ->
    encode_none(0, Value);

encode_nft_lookup_attributes(_Family, {set, Value}) ->
    encode_string(1, Value);

encode_nft_lookup_attributes(_Family, {sreg, Value}) ->
    encode_uint32(2, Value);

encode_nft_lookup_attributes(_Family, {dreg, Value}) ->
    encode_uint32(3, Value);

encode_nft_lookup_attributes(_Family, {set_id, Value}) ->
    encode_uint32(4, Value);

encode_nft_lookup_attributes(_Family, {Type, Value})
  when is_integer(Type), is_binary(Value) ->
    enc_nla(Type, Value).

%% ============================

encode_nft_meta_attributes(_Family, {unspec, Value}) ->
    encode_none(0, Value);

encode_nft_meta_attributes(_Family, {dreg, Value}) ->
    encode_uint32(1, Value);

encode_nft_meta_attributes(_Family, {key, Value}) ->
    encode_uint32(2, encode_nft_meta_attributes_key(Value));

encode_nft_meta_attributes(_Family, {sreg, Value}) ->
    encode_uint32(3, Value);

encode_nft_meta_attributes(_Family, {Type, Value})
  when is_integer(Type), is_binary(Value) ->
    enc_nla(Type, Value).

%% ============================

encode_nft_meta_attributes_key(len) ->
    0;

encode_nft_meta_attributes_key(protocol) ->
    1;

encode_nft_meta_attributes_key(priority) ->
    2;

encode_nft_meta_attributes_key(mark) ->
    3;

encode_nft_meta_attributes_key(iif) ->
    4;

encode_nft_meta_attributes_key(oif) ->
    5;

encode_nft_meta_attributes_key(iifname) ->
    6;

encode_nft_meta_attributes_key(oifname) ->
    7;

encode_nft_meta_attributes_key(iiftype) ->
    8;

encode_nft_meta_attributes_key(oiftype) ->
    9;

encode_nft_meta_attributes_key(skuid) ->
    10;

encode_nft_meta_attributes_key(skgid) ->
    11;

encode_nft_meta_attributes_key(nftrace) ->
    12;

encode_nft_meta_attributes_key(rtclassid) ->
    13;

encode_nft_meta_attributes_key(secmark) ->
    14;

encode_nft_meta_attributes_key(nfproto) ->
    15;

encode_nft_meta_attributes_key(l4proto) ->
    16;

encode_nft_meta_attributes_key(bri_iifname) ->
    17;

encode_nft_meta_attributes_key(bri_oifname) ->
    18;

encode_nft_meta_attributes_key(pkttype) ->
    19;

encode_nft_meta_attributes_key(cpu) ->
    20;

encode_nft_meta_attributes_key(iifgroup) ->
    21;

encode_nft_meta_attributes_key(oifgroup) ->
    22;

encode_nft_meta_attributes_key(cgroup) ->
    23;

encode_nft_meta_attributes_key(Value) when is_integer(Value) ->
    Value.

%% ============================

encode_nft_payload_attributes(_Family, {unspec, Value}) ->
    encode_none(0, Value);

encode_nft_payload_attributes(_Family, {dreg, Value}) ->
    encode_uint32(1, Value);

encode_nft_payload_attributes(_Family, {base, Value}) ->
    encode_uint32(2, encode_nft_payload_attributes_base(Value));

encode_nft_payload_attributes(_Family, {offset, Value}) ->
    encode_uint32(3, Value);

encode_nft_payload_attributes(_Family, {len, Value}) ->
    encode_uint32(4, Value);

encode_nft_payload_attributes(_Family, {Type, Value})
  when is_integer(Type), is_binary(Value) ->
    enc_nla(Type, Value).

%% ============================

encode_nft_payload_attributes_base(ll_header) ->
    0;

encode_nft_payload_attributes_base(network_header) ->
    1;

encode_nft_payload_attributes_base(transport_header) ->
    2;

encode_nft_payload_attributes_base(Value) when is_integer(Value) ->
    Value.

%% ============================

encode_nft_reject_attributes(_Family, {unspec, Value}) ->
    encode_none(0, Value);

encode_nft_reject_attributes(_Family, {type, Value}) ->
    encode_uint32(1, encode_nft_reject_attributes_type(Value));

encode_nft_reject_attributes(_Family, {icmp_code, Value}) ->
    encode_uint8(2, encode_nft_reject_attributes_icmp_code(Value));

encode_nft_reject_attributes(_Family, {Type, Value})
  when is_integer(Type), is_binary(Value) ->
    enc_nla(Type, Value).

%% ============================

encode_nft_reject_attributes_type(icmp_unreach) ->
    0;

encode_nft_reject_attributes_type(tcp_rst) ->
    1;

encode_nft_reject_attributes_type(icmpx_unreach) ->
    2;

encode_nft_reject_attributes_type(Value) when is_integer(Value) ->
    Value.

%% ============================

encode_nft_reject_attributes_icmp_code(no_route) ->
    0;

encode_nft_reject_attributes_icmp_code(port_unreach) ->
    1;

encode_nft_reject_attributes_icmp_code(host_unreach) ->
    2;

encode_nft_reject_attributes_icmp_code(admin_prohibited) ->
    3;

encode_nft_reject_attributes_icmp_code(Value) when is_integer(Value) ->
    Value.

%% ============================

encode_nft_ct_attributes(_Family, {unspec, Value}) ->
    encode_none(0, Value);

encode_nft_ct_attributes(_Family, {dreg, Value}) ->
    encode_uint32(1, Value);

encode_nft_ct_attributes(_Family, {key, Value}) ->
    encode_uint32(2, encode_nft_ct_attributes_key(Value));

encode_nft_ct_attributes(_Family, {direction, Value}) ->
    encode_uint8(3, Value);

encode_nft_ct_attributes(_Family, {sreg, Value}) ->
    encode_uint32(4, Value);

encode_nft_ct_attributes(_Family, {Type, Value})
  when is_integer(Type), is_binary(Value) ->
    enc_nla(Type, Value).

%% ============================

encode_nft_ct_attributes_key(state) ->
    0;

encode_nft_ct_attributes_key(direction) ->
    1;

encode_nft_ct_attributes_key(status) ->
    2;

encode_nft_ct_attributes_key(mark) ->
    3;

encode_nft_ct_attributes_key(secmark) ->
    4;

encode_nft_ct_attributes_key(expiration) ->
    5;

encode_nft_ct_attributes_key(helper) ->
    6;

encode_nft_ct_attributes_key(l3protocol) ->
    7;

encode_nft_ct_attributes_key(src) ->
    8;

encode_nft_ct_attributes_key(dst) ->
    9;

encode_nft_ct_attributes_key(protocol) ->
    10;

encode_nft_ct_attributes_key(proto_src) ->
    11;

encode_nft_ct_attributes_key(proto_dst) ->
    12;

encode_nft_ct_attributes_key(labels) ->
    13;

encode_nft_ct_attributes_key(Value) when is_integer(Value) ->
    Value.

%% ============================

encode_nft_queue_attributes(_Family, {unspec, Value}) ->
    encode_none(0, Value);

encode_nft_queue_attributes(_Family, {num, Value}) ->
    encode_uint16(1, Value);

encode_nft_queue_attributes(_Family, {total, Value}) ->
    encode_uint16(2, Value);

encode_nft_queue_attributes(_Family, {flags, Value}) ->
    encode_uint16(3, encode_flag(flag_info_nft_queue_attributes_flags(), Value));

encode_nft_queue_attributes(_Family, {Type, Value})
  when is_integer(Type), is_binary(Value) ->
    enc_nla(Type, Value).

%% ============================

encode_nft_cmp_attributes(_Family, {unspec, Value}) ->
    encode_none(0, Value);

encode_nft_cmp_attributes(_Family, {sreg, Value}) ->
    encode_uint32(1, Value);

encode_nft_cmp_attributes(_Family, {op, Value}) ->
    encode_uint32(2, encode_nft_cmp_attributes_op(Value));

encode_nft_cmp_attributes(Family, {data, Value}) ->
    enc_nla(3, nl_enc_nla(Family, fun encode_nft_data_attributes/2, Value));

encode_nft_cmp_attributes(_Family, {Type, Value})
  when is_integer(Type), is_binary(Value) ->
    enc_nla(Type, Value).

%% ============================

encode_nft_cmp_attributes_op(eq) ->
    0;

encode_nft_cmp_attributes_op(neq) ->
    1;

encode_nft_cmp_attributes_op(lt) ->
    2;

encode_nft_cmp_attributes_op(lte) ->
    3;

encode_nft_cmp_attributes_op(gt) ->
    4;

encode_nft_cmp_attributes_op(gte) ->
    5;

encode_nft_cmp_attributes_op(Value) when is_integer(Value) ->
    Value.

%% ============================

encode_nft_match_attributes(_Family, {unspec, Value}) ->
    encode_none(0, Value);

encode_nft_match_attributes(_Family, {name, Value}) ->
    encode_string(1, Value);

encode_nft_match_attributes(_Family, {rev, Value}) ->
    encode_uint32(2, Value);

encode_nft_match_attributes(_Family, {info, Value}) ->
    encode_binary(3, Value);

encode_nft_match_attributes(_Family, {Type, Value})
  when is_integer(Type), is_binary(Value) ->
    enc_nla(Type, Value).

%% ============================

encode_nft_target_attributes(_Family, {unspec, Value}) ->
    encode_none(0, Value);

encode_nft_target_attributes(_Family, {name, Value}) ->
    encode_string(1, Value);

encode_nft_target_attributes(_Family, {rev, Value}) ->
    encode_uint32(2, Value);

encode_nft_target_attributes(_Family, {info, Value}) ->
    encode_binary(3, Value);

encode_nft_target_attributes(_Family, {Type, Value})
  when is_integer(Type), is_binary(Value) ->
    enc_nla(Type, Value).

%% ============================

encode_nft_list_attributes_expr(_Family, {unspec, Value}) ->
    encode_none(0, Value);

encode_nft_list_attributes_expr(Family, {expr, Value}) ->
    enc_nla(1, nl_enc_nla(Family, fun encode_nft_expr_attributes/2, Value));

encode_nft_list_attributes_expr(_Family, {Type, Value})
  when is_integer(Type), is_binary(Value) ->
    enc_nla(Type, Value).

%% ============================

encode_nft_counter_attributes(_Family, {unspec, Value}) ->
    encode_none(0, Value);

encode_nft_counter_attributes(_Family, {bytes, Value}) ->
    encode_uint64(1, Value);

encode_nft_counter_attributes(_Family, {packets, Value}) ->
    encode_uint64(2, Value);

encode_nft_counter_attributes(_Family, {Type, Value})
  when is_integer(Type), is_binary(Value) ->
    enc_nla(Type, Value).

%% ============================

encode_nft_table_attributes(_Family, {unspec, Value}) ->
    encode_none(0, Value);

encode_nft_table_attributes(_Family, {name, Value}) ->
    encode_string(1, Value);

encode_nft_table_attributes(_Family, {flags, Value}) ->
    encode_uint32(2, encode_flag(flag_info_nft_table_attributes_flags(), Value));

encode_nft_table_attributes(_Family, {use, Value}) ->
    encode_uint32(3, Value);

encode_nft_table_attributes(_Family, {Type, Value})
  when is_integer(Type), is_binary(Value) ->
    enc_nla(Type, Value).

%% ============================

encode_nft_chain_attributes(_Family, {unspec, Value}) ->
    encode_none(0, Value);

encode_nft_chain_attributes(_Family, {table, Value}) ->
    encode_string(1, Value);

encode_nft_chain_attributes(_Family, {handle, Value}) ->
    encode_uint64(2, Value);

encode_nft_chain_attributes(_Family, {name, Value}) ->
    encode_string(3, Value);

encode_nft_chain_attributes(Family, {hook, Value}) ->
    enc_nla(4, nl_enc_nla(Family, fun encode_nft_chain_attributes_hook/2, Value));

encode_nft_chain_attributes(_Family, {policy, Value}) ->
    encode_uint32(5, encode_nft_chain_attributes_policy(Value));

encode_nft_chain_attributes(_Family, {use, Value}) ->
    encode_uint32(6, Value);

encode_nft_chain_attributes(_Family, {type, Value}) ->
    encode_string(7, Value);

encode_nft_chain_attributes(Family, {counters, Value}) ->
    enc_nla(8, nl_enc_nla(Family, fun encode_nft_counter_attributes/2, Value));

encode_nft_chain_attributes(_Family, {Type, Value})
  when is_integer(Type), is_binary(Value) ->
    enc_nla(Type, Value).

%% ============================

encode_nft_chain_attributes_hook(_Family, {unspec, Value}) ->
    encode_none(0, Value);

encode_nft_chain_attributes_hook(_Family, {hooknum, Value}) ->
    encode_uint32(1, Value);

encode_nft_chain_attributes_hook(_Family, {priority, Value}) ->
    encode_int32(2, Value);

encode_nft_chain_attributes_hook(_Family, {dev, Value}) ->
    encode_string(3, Value);

encode_nft_chain_attributes_hook(_Family, {Type, Value})
  when is_integer(Type), is_binary(Value) ->
    enc_nla(Type, Value).

%% ============================

encode_nft_chain_attributes_policy(drop) ->
    0;

encode_nft_chain_attributes_policy(accept) ->
    1;

encode_nft_chain_attributes_policy(stolen) ->
    2;

encode_nft_chain_attributes_policy(queue) ->
    3;

encode_nft_chain_attributes_policy(repeat) ->
    4;

encode_nft_chain_attributes_policy(stop) ->
    5;

encode_nft_chain_attributes_policy(Value) when is_integer(Value) ->
    Value.

%% ============================

encode_nft_rule_attributes(_Family, {unspec, Value}) ->
    encode_none(0, Value);

encode_nft_rule_attributes(_Family, {table, Value}) ->
    encode_string(1, Value);

encode_nft_rule_attributes(_Family, {chain, Value}) ->
    encode_string(2, Value);

encode_nft_rule_attributes(_Family, {handle, Value}) ->
    encode_uint64(3, Value);

encode_nft_rule_attributes(Family, {expressions, Value}) ->
    enc_nla(4, nl_enc_nla(Family, fun encode_nft_list_attributes_expr/2, Value));

encode_nft_rule_attributes(_Family, {compat, Value}) ->
    encode_binary(5, Value);

encode_nft_rule_attributes(_Family, {position, Value}) ->
    encode_uint64(6, Value);

encode_nft_rule_attributes(_Family, {userdata, Value}) ->
    encode_binary(7, Value);

encode_nft_rule_attributes(_Family, {Type, Value})
  when is_integer(Type), is_binary(Value) ->
    enc_nla(Type, Value).

%% ============================

encode_nft_set_attributes(_Family, {unspec, Value}) ->
    encode_none(0, Value);

encode_nft_set_attributes(_Family, {table, Value}) ->
    encode_string(1, Value);

encode_nft_set_attributes(_Family, {name, Value}) ->
    encode_string(2, Value);

encode_nft_set_attributes(_Family, {flags, Value}) ->
    encode_uint32(3, encode_flag(flag_info_nft_set_attributes_flags(), Value));

encode_nft_set_attributes(_Family, {key_type, Value}) ->
    encode_binary(4, Value);

encode_nft_set_attributes(_Family, {key_len, Value}) ->
    encode_uint32(5, Value);

encode_nft_set_attributes(_Family, {data_type, Value}) ->
    encode_binary(6, Value);

encode_nft_set_attributes(_Family, {data_len, Value}) ->
    encode_uint32(7, Value);

encode_nft_set_attributes(_Family, {policy, Value}) ->
    encode_uint32(8, encode_nft_set_attributes_policy(Value));

encode_nft_set_attributes(_Family, {desc, Value}) ->
    encode_binary(9, Value);

encode_nft_set_attributes(_Family, {id, Value}) ->
    encode_uint32(10, Value);

encode_nft_set_attributes(_Family, {timeout, Value}) ->
    encode_uint64(11, Value);

encode_nft_set_attributes(_Family, {gc_interval, Value}) ->
    encode_uint32(12, Value);

encode_nft_set_attributes(_Family, {Type, Value})
  when is_integer(Type), is_binary(Value) ->
    enc_nla(Type, Value).

%% ============================

encode_nft_set_attributes_policy(drop) ->
    0;

encode_nft_set_attributes_policy(accept) ->
    1;

encode_nft_set_attributes_policy(stolen) ->
    2;

encode_nft_set_attributes_policy(queue) ->
    3;

encode_nft_set_attributes_policy(repeat) ->
    4;

encode_nft_set_attributes_policy(stop) ->
    5;

encode_nft_set_attributes_policy(Value) when is_integer(Value) ->
    Value.

%% ============================

encode_nft_set_elem_list_attributes(_Family, {unspec, Value}) ->
    encode_none(0, Value);

encode_nft_set_elem_list_attributes(_Family, {table, Value}) ->
    encode_string(1, Value);

encode_nft_set_elem_list_attributes(_Family, {set, Value}) ->
    encode_string(2, Value);

encode_nft_set_elem_list_attributes(Family, {elements, Value}) ->
    enc_nla(3, nl_enc_nla(Family, fun encode_nft_set_elem_list_elements/2, Value));

encode_nft_set_elem_list_attributes(_Family, {set_id, Value}) ->
    encode_uint32(4, Value);

encode_nft_set_elem_list_attributes(_Family, {Type, Value})
  when is_integer(Type), is_binary(Value) ->
    enc_nla(Type, Value).

%% ============================

encode_nft_set_elem_list_elements(_Family, {unspec, Value}) ->
    encode_none(0, Value);

encode_nft_set_elem_list_elements(Family, {element, Value}) ->
    enc_nla(1, nl_enc_nla(Family, fun encode_nft_set_ext_attributes/2, Value));

encode_nft_set_elem_list_elements(_Family, {Type, Value})
  when is_integer(Type), is_binary(Value) ->
    enc_nla(Type, Value).

%% ============================

encode_nft_set_ext_attributes(_Family, {unspec, Value}) ->
    encode_none(0, Value);

encode_nft_set_ext_attributes(Family, {key, Value}) ->
    enc_nla(1, nl_enc_nla(Family, fun encode_nft_data_attributes/2, Value));

encode_nft_set_ext_attributes(Family, {data, Value}) ->
    enc_nla(2, nl_enc_nla(Family, fun encode_nft_data_attributes/2, Value));

encode_nft_set_ext_attributes(_Family, {flags, Value}) ->
    encode_uint32(3, encode_flag(flag_info_nft_set_ext_attributes_flags(), Value));

encode_nft_set_ext_attributes(_Family, {timeout, Value}) ->
    encode_uint64(4, Value);

encode_nft_set_ext_attributes(_Family, {expiration, Value}) ->
    encode_uint64(5, Value);

encode_nft_set_ext_attributes(_Family, {userdata, Value}) ->
    encode_binary(6, Value);

encode_nft_set_ext_attributes(Family, {expr, Value}) ->
    enc_nla(7, nl_enc_nla(Family, fun encode_nft_expr_attributes/2, Value));

encode_nft_set_ext_attributes(_Family, {Type, Value})
  when is_integer(Type), is_binary(Value) ->
    enc_nla(Type, Value).

%% ============================

encode_nft_gen_attributes(_Family, {unspec, Value}) ->
    encode_none(0, Value);

encode_nft_gen_attributes(_Family, {id, Value}) ->
    encode_uint32(1, Value);

encode_nft_gen_attributes(_Family, {Type, Value})
  when is_integer(Type), is_binary(Value) ->
    enc_nla(Type, Value).

%% ============================

encode_genl_ctrl_cmd(unspec) ->
    0;

encode_genl_ctrl_cmd(newfamily) ->
    1;

encode_genl_ctrl_cmd(delfamily) ->
    2;

encode_genl_ctrl_cmd(getfamily) ->
    3;

encode_genl_ctrl_cmd(newops) ->
    4;

encode_genl_ctrl_cmd(delops) ->
    5;

encode_genl_ctrl_cmd(getops) ->
    6;

encode_genl_ctrl_cmd(newmcast_grp) ->
    7;

encode_genl_ctrl_cmd(delmcast_grp) ->
    8;

encode_genl_ctrl_cmd(getmcast_grp) ->
    9;

encode_genl_ctrl_cmd(Value) when is_integer(Value) ->
    Value.

%% ============================

encode_genl_ctrl_attr(_Family, {unspec, Value}) ->
    encode_none(0, Value);

encode_genl_ctrl_attr(_Family, {family_id, Value}) ->
    encode_huint16(1, encode_protocol_subsys(Value));

encode_genl_ctrl_attr(_Family, {family_name, Value}) ->
    encode_string(2, Value);

encode_genl_ctrl_attr(_Family, {version, Value}) ->
    encode_huint32(3, Value);

encode_genl_ctrl_attr(_Family, {hdrsize, Value}) ->
    encode_huint32(4, Value);

encode_genl_ctrl_attr(_Family, {maxattr, Value}) ->
    encode_huint32(5, Value);

encode_genl_ctrl_attr(Family, {ops, Value}) ->
    enc_nla(6, nl_enc_nla(Family, fun encode_genl_ctrl_attr_ops/2, Value));

encode_genl_ctrl_attr(Family, {mcast_groups, Value}) ->
    enc_nla(7, nl_enc_nla(Family, fun encode_genl_ctrl_attr_mcast_groups/2, Value));

encode_genl_ctrl_attr(_Family, {Type, Value})
  when is_integer(Type), is_binary(Value) ->
    enc_nla(Type, Value).

%% ============================

encode_genl_ctrl_attr_op(_Family, {unspec, Value}) ->
    encode_none(0, Value);

encode_genl_ctrl_attr_op(_Family, {id, Value}) ->
    encode_huint32(1, Value);

encode_genl_ctrl_attr_op(_Family, {flags, Value}) ->
    encode_huint32(2, Value);

encode_genl_ctrl_attr_op(_Family, {Type, Value})
  when is_integer(Type), is_binary(Value) ->
    enc_nla(Type, Value).

%% ============================

encode_genl_ctrl_attr_mcast_grp(_Family, {unspec, Value}) ->
    encode_none(0, Value);

encode_genl_ctrl_attr_mcast_grp(_Family, {name, Value}) ->
    encode_string(1, Value);

encode_genl_ctrl_attr_mcast_grp(_Family, {id, Value}) ->
    encode_huint32(2, Value);

encode_genl_ctrl_attr_mcast_grp(_Family, {Type, Value})
  when is_integer(Type), is_binary(Value) ->
    enc_nla(Type, Value).

%% ============================

encode_linkinfo_gtp(_Family, {unspec, Value}) ->
    encode_none(0, Value);

encode_linkinfo_gtp(_Family, {fd0, Value}) ->
    encode_huint32(1, Value);

encode_linkinfo_gtp(_Family, {fd1, Value}) ->
    encode_huint32(2, Value);

encode_linkinfo_gtp(_Family, {hashsize, Value}) ->
    encode_huint32(3, Value);

encode_linkinfo_gtp(_Family, {Type, Value})
  when is_integer(Type), is_binary(Value) ->
    enc_nla(Type, Value).

%% ============================

encode_gtp_cmd(new) ->
    0;

encode_gtp_cmd(delete) ->
    1;

encode_gtp_cmd(get) ->
    2;

encode_gtp_cmd(Value) when is_integer(Value) ->
    Value.

%% ============================

encode_gtp_attrs(_Family, {unspec, Value}) ->
    encode_none(0, Value);

encode_gtp_attrs(_Family, {link, Value}) ->
    encode_huint32(1, Value);

encode_gtp_attrs(_Family, {version, Value}) ->
    encode_huint32(2, Value);

encode_gtp_attrs(_Family, {tid, Value}) ->
    encode_huint64(3, Value);

encode_gtp_attrs(_Family, {sgsn_address, Value}) ->
    encode_addr(4, Value);

encode_gtp_attrs(_Family, {ms_address, Value}) ->
    encode_addr(5, Value);

encode_gtp_attrs(_Family, {flow, Value}) ->
    encode_huint16(6, Value);

encode_gtp_attrs(_Family, {net_ns_fd, Value}) ->
    encode_huint32(7, Value);

encode_gtp_attrs(_Family, {i_tid, Value}) ->
    encode_huint32(8, Value);

encode_gtp_attrs(_Family, {o_tid, Value}) ->
    encode_huint32(9, Value);

encode_gtp_attrs(_Family, {Type, Value})
  when is_integer(Type), is_binary(Value) ->
    enc_nla(Type, Value).