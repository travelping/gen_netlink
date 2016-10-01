#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable

-mode(compile).

define_consts() ->
    [{{protocol, subsys}, [{rtnetlink,      {atom, "?NETLINK_ROUTE"}},
			   {usersock,       {atom, "?NETLINK_USERSOCK"}},
			   {firewall,       {atom, "?NETLINK_FIREWALL"}},
			   {inet_diag,      {atom, "?NETLINK_INET_DIAG"}},
			   {nflog,          {atom, "?NETLINK_NFLOG"}},
			   {xfrm,           {atom, "?NETLINK_XFRM"}},
			   {selinux,        {atom, "?NETLINK_SELINUX"}},
			   {iscsi,          {atom, "?NETLINK_ISCSI"}},
			   {audit,          {atom, "?NETLINK_AUDIT"}},
			   {fib_lookup,     {atom, "?NETLINK_FIB_LOOKUP"}},
			   {connector,      {atom, "?NETLINK_CONNECTOR"}},
			   {netfilter,      {atom, "?NETLINK_NETFILTER"}},
			   {ip6_fw,         {atom, "?NETLINK_IP6_FW"}},
			   {dnrtmsg,        {atom, "?NETLINK_DNRTMSG"}},
			   {kobject_uevent, {atom, "?NETLINK_KOBJECT_UEVENT"}},
			   {generic,        {atom, "?NETLINK_GENERIC"}},
			   {scsitransport,  {atom, "?NETLINK_SCSITRANSPORT"}},
			   {ecryptfs,       {atom, "?NETLINK_ECRYPTFS"}}
			  ]},

     {nl_subsys, [{netlink,           {atom,  0}},
		  {ctnetlink,         {atom,  1}},
		  {ctnetlink_exp,     {atom,  2}},
		  {queue,             {atom,  3}},
		  {ulog,              {atom,  4}},
		  {osf,               {atom,  5}},
		  {ipset,             {atom,  6}},
		  {acct,              {atom,  7}},
		  {ctnetlink_timeout, {atom,  8}},
		  {cthelper,          {atom,  9}},
		  {nftables,          {atom, 10}},
		  {nft_compat,        {atom, 11}},
		  {count,             {atom, 12}}
		 ]},
     {nlm_flags, [
                  {request,   {flag,  0}},
                  {multi,     {flag,  1}},
                  {ack,       {flag,  2}},
                  {echo,      {flag,  3}},
                  {dump_intr, {flag,  4}},
                  {root,      {flag,  8}},
                  {match,     {flag,  9}},
                  {atomic,    {flag, 10}}
                 ]},
     {nlm_get_flags, [
                      {request,   {flag,  0}},
                      {multi,     {flag,  1}},
                      {ack,       {flag,  2}},
                      {echo,      {flag,  3}},
		      {dump_intr, {flag,  4}},
                      {root,      {flag,  8}},
                      {match,     {flag,  9}},
                      {atomic,    {flag, 10}}
                 ]},
     {nlm_new_flags, [
                      {request,   {flag,  0}},
                      {multi,     {flag,  1}},
                      {ack,       {flag,  2}},
                      {echo,      {flag,  3}},
		      {dump_intr, {flag,  4}},
                      {replace,   {flag,  8}},
                      {excl,      {flag,  9}},
                      {create,    {flag, 10}},
                      {append,    {flag, 11}}
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
     {{rtm_msgtype, rtnetlink}, [
			      {noop,         {atom, "?NLMSG_NOOP"}},
			      {error,        {atom, "?NLMSG_ERROR"}},
			      {done,         {atom, "?NLMSG_DONE"}},
			      {overrun,      {atom, "?NLMSG_OVERRUN"}},
			      {newlink,      {atom, "?RTM_NEWLINK"}},
			      {dellink,      {atom, "?RTM_DELLINK"}},
			      {getlink,      {atom, "?RTM_GETLINK"}},
			      {setlink,      {atom, "?RTM_SETLINK"}},
			      {newaddr,      {atom, "?RTM_NEWADDR"}},
			      {deladdr,      {atom, "?RTM_DELADDR"}},
			      {getaddr,      {atom, "?RTM_GETADDR"}},
			      {newroute,     {atom, "?RTM_NEWROUTE"}},
			      {delroute,     {atom, "?RTM_DELROUTE"}},
			      {getroute,     {atom, "?RTM_GETROUTE"}},
			      {newneigh,     {atom, "?RTM_NEWNEIGH"}},
			      {delneigh,     {atom, "?RTM_DELNEIGH"}},
			      {getneigh,     {atom, "?RTM_GETNEIGH"}},
			      {newrule,      {atom, "?RTM_NEWRULE"}},
			      {delrule,      {atom, "?RTM_DELRULE"}},
			      {getrule,      {atom, "?RTM_GETRULE"}},
			      {newqdisc,     {atom, "?RTM_NEWQDISC"}},
			      {delqdisc,     {atom, "?RTM_DELQDISC"}},
			      {getqdisc,     {atom, "?RTM_GETQDISC"}},
			      {newtclass,    {atom, "?RTM_NEWTCLASS"}},
			      {deltclass,    {atom, "?RTM_DELTCLASS"}},
			      {gettclass,    {atom, "?RTM_GETTCLASS"}},
			      {newtfilter,   {atom, "?RTM_NEWTFILTER"}},
			      {deltfilter,   {atom, "?RTM_DELTFILTER"}},
			      {gettfilter,   {atom, "?RTM_GETTFILTER"}},
			      {newaction,    {atom, "?RTM_NEWACTION"}},
			      {delaction,    {atom, "?RTM_DELACTION"}},
			      {getaction,    {atom, "?RTM_GETACTION"}},
			      {newprefix,    {atom, "?RTM_NEWPREFIX"}},
			      {getmulticast, {atom, "?RTM_GETMULTICAST"}},
			      {getanycast,   {atom, "?RTM_GETANYCAST"}},
			      {newneightbl,  {atom, "?RTM_NEWNEIGHTBL"}},
			      {getneightbl,  {atom, "?RTM_GETNEIGHTBL"}},
			      {setneightbl,  {atom, "?RTM_SETNEIGHTBL"}},
			      {newnduseropt, {atom, "?RTM_NEWNDUSEROPT"}},
			      {newaddrlabel, {atom, "?RTM_NEWADDRLABEL"}},
			      {deladdrlabel, {atom, "?RTM_DELADDRLABEL"}},
			      {getaddrlabel, {atom, "?RTM_GETADDRLABEL"}},
			      {getdcb,       {atom, "?RTM_GETDCB"}},
			      {setdcb,       {atom, "?RTM_SETDCB"}}
			     ]},
     {{nl_msgtype, nlmsg}, [
			      {noop,         {atom, "?NLMSG_NOOP"}},
			      {error,        {atom, "?NLMSG_ERROR"}},
			      {done,         {atom, "?NLMSG_DONE"}},
			      {overrun,      {atom, "?NLMSG_OVERRUN"}}
			     ]},
     {{nl_msgtype, nfnl}, [
			      {'begin', {atom, "?NFNL_MSG_BATCH_BEGIN"}},
			      {'end',   {atom, "?NFNL_MSG_BATCH_END"}}
			     ]},
     {{nl_msgtype, ctnetlink}, [
				{new,         {atom, "?IPCTNL_MSG_CT_NEW"}},
				{get,         {atom, "?IPCTNL_MSG_CT_GET"}},
				{delete,      {atom, "?IPCTNL_MSG_CT_DELETE"}},
				{get_ctrzero, {atom, "?IPCTNL_MSG_CT_GET_CTRZERO"}}
			       ]},
     {{nl_msgtype, ctnetlink_exp}, [
				    {new,         {atom, "?IPCTNL_MSG_EXP_NEW"}},
				    {get,         {atom, "?IPCTNL_MSG_EXP_GET"}},
				    {delete,      {atom, "?IPCTNL_MSG_EXP_DELETE"}}
				   ]},
     {{nl_msgtype, nftables}, [newtable,
			       gettable,
			       deltable,
			       newchain,
			       getchain,
			       delchain,
			       newrule,
			       getrule,
			       delrule,
			       newset,
			       getset,
			       delset,
			       newsetelem,
			       getsetelem,
			       delsetelem,
			       newgen,
			       getgen
			      ]},

     {{nl_msgtype, nft_compat}, [get]},
     {{nl_msgtype, generic}, [{generate,  {atom, 0}},
			      {ctrl,      {atom, "?NLMSG_MIN_TYPE"}},
			      {vfs_dquot, {atom, "?NLMSG_MIN_TYPE + 1"}},
			      {pmcraid,   {atom, "?NLMSG_MIN_TYPE + 2"}}
			     ]},

     {{ctnetlink}, [
                    {unspec, none},
                    {tuple_orig, tuple},
                    {tuple_reply, tuple},
                    {status, flag32},
                    {protoinfo, protoinfo},
                    {help, help},
                    {nat_src, snat_entry},
                    {timeout, uint32},
                    {mark, uint32},
                    {counters_orig, counters},
                    {counters_reply, counters},
                    {use, uint32},
                    {id, uint32},
                    {nat_dst, dnat_entry},
                    {tuple_master, tuple},
                    {nat_seq_adj_orig, nat_seq_adj},
                    {nat_seq_adj_reply, nat_seq_adj},
                    {secmark, uint32},
		    {zone, uint16},
		    {secctx, none},
		    {timestamp, timestamp},
                    {mark_mask, uint32},
                    {labels, binary},
                    {labels_mask, binary}
                 ]},
     {{ctnetlink, snat_entry}, [
                                {unspec, none},
                                {v4_src, addr},
                                {unspec, none},
                                {src_port, ports}
                               ]},
     {{ctnetlink, snat_entry, ports}, [
                                       {unspec, none},
                                       {min_port, uint16},
                                       {max_port, uint16}
                                      ]},
     {{ctnetlink, dnat_entry}, [
                                {unspec, none},
                                {v4_dst, addr},
                                {unspec, none},
                                {dst_port, ports}
                               ]},
     {{ctnetlink, dnat_entry, ports}, [
                                       {unspec, none},
                                       {min_port, uint16},
                                       {max_port, uint16}
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
                                           none,
                                           syn_sent,
                                           syn_recv,
                                           established,
                                           fin_wait,
                                           close_wait,
                                           last_ack,
                                           time_wait,
                                           close,
                                           listen,
                                           max,
                                           ignore
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
                           {nda_cacheinfo, huint32_array},
                           {probes, huint32}
                 ]},
     {{rtnetlink, rtm_type}, [
							  unspec,
							  unicast,
							  local,
							  broadcast,
							  anycast,
							  multicast,
							  blackhole,
							  unreachable,
							  prohibit,
							  throw,
							  nat,
							  xresolve
							 ]},
	 {{rtnetlink, rtm_protocol}, [
								  {unspec,   {atom, 0}},
								  {redirect, {atom, 1}},
								  {kernel,   {atom, 2}},
								  {boot,     {atom, 3}},
								  {static,   {atom, 4}},
								  {gated,    {atom, 8}},
								  {ra,       {atom, 9}},
								  {mrt,      {atom, 10}},
								  {zebra,    {atom, 11}},
								  {bird,     {atom, 12}},
								  {dnrouted, {atom, 13}},
								  {xorp,     {atom, 14}},
								  {ntk,      {atom, 15}},
								  {dhcp,     {atom, 16}}
							 ]},
	 {{rtnetlink, rtm_scope}, [
							   {universe, {atom, 0}},
							   {site,     {atom, 200}},
							   {link,     {atom, 253}},
							   {host,     {atom, 254}},
							   {nowhere,  {atom, 255}}
							  ]},
	 {{rtnetlink, rtm_flags}, [
							   {notify,   {flag, 8}},
							   {cloned,   {flag, 9}},
							   {equalize, {flag, 10}},
							   {prefix,   {flag, 11}}
							  ]},
	 {{rtnetlink, rtm_table}, [
							   {unspec,  {atom, 0}},
							   {compat,  {atom, 252}},
							   {default, {atom, 253}},
							   {main,    {atom, 254}},
							   {local,   {atom, 255}}
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
                           {rta_cacheinfo, huint32_array},
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
                                {ifa_cacheinfo, huint32_array},
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
                          {vf_ports, none},
			  {port_self, none},
			  {af_spec, none},
			  {group, none},
			  {net_ns_fd, huint32},
			  {ext_mask, huint32},
			  {promiscuity, none},
			  {num_tx_queues, none},
			  {num_rx_queues, none},
			  {carrier, none},
			  {phys_port_id, none},
			  {carrier_changes, none}
                         ]},
     {{rtnetlink, link, operstate}, [
                                     unknown,
                                     notpresent,
                                     down,
                                     lowerlayerdown,
                                     testing,
                                     dormant,
                                     up
                                    ]},
     {{rtnetlink, link, linkmode}, [
                                     default,
                                     dormant
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
                                            {ifla_cacheinfo, huint32_array},
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
                            {prefix_cacheinfo, huint32_array}
                           ]},

     {{nl_msgtype, queue}, [
			     {packet,        {atom, "?NFQNL_MSG_PACKET"}},
			     {verdict,       {atom, "?NFQNL_MSG_VERDICT"}},
			     {config,        {atom, "?NFQNL_MSG_CONFIG"}},
			     {verdict_batch, {atom, "?NFQNL_MSG_VERDICT_BATCH"}}
			    ]},

     {{nfqnl, config, cmd}, [
			     {none,      {atom, "?NFQNL_CFG_CMD_NONE"}},
			     {bind,      {atom, "?NFQNL_CFG_CMD_BIND"}},
			     {unbind,    {atom, "?NFQNL_CFG_CMD_UNBIND"}},
			     {pf_bind,   {atom, "?NFQNL_CFG_CMD_PF_BIND"}},
			     {pf_unbind, {atom, "?NFQNL_CFG_CMD_PF_UNBIND"}}
			    ]},

     {{ nfqnl, cfg, msg}, [
			   {unspec,       none},
			   {cmd,          struct},        %% nfqnl_msg_config_cmd
			   {params,       struct},        %% nfqnl_msg_config_params
			   {queue_maxlen, none},          %% __u32
			   {mask,         flag32},          %% identify which flags to change
			   {flags,        flag32}         %% value of these flags (__u32)
		     ]},
     {{ nfqnl, cfg, msg, mask },  [{fail_open, flag},
				   {conntrack, flag},
				   {gso,       flag},
				   {uid_gid,   flag},
				   {secctx,    flag}]},
     {{ nfqnl, cfg, msg, flags }, [{fail_open, flag},
				   {conntrack, flag},
				   {gso,       flag},
				   {uid_gid,   flag},
				   {secctx,    flag}]},

     {{ nfqnl, attr }, [
		       {unspec,             none},
		       {packet_hdr,         struct},
		       {verdict_hdr,        struct},                                    %% nfqnl_msg_verdict_hrd
		       {mark,               uint32},                                    %% __u32 nfmark
		       {timestamp,          struct},                                    %% nfqnl_msg_packet_timestamp
		       {ifindex_indev,      uint32},                                    %% __u32 ifindex
		       {ifindex_outdev,     uint32},                                    %% __u32 ifindex
		       {ifindex_physindev,  uint32},                                    %% __u32 ifindex
		       {ifindex_physoutdev, uint32},                                    %% __u32 ifindex
		       {hwaddr,             struct},                                    %% nfqnl_msg_packet_hw
		       {payload,            binary},                                    %% opaque data payload
		       {ct,                 {nested, {ctnetlink}}},                     %% nf_conntrack_netlink.h
		       {ct_info,            atom32},                                    %% enum ip_conntrack_info
		       {cap_len,            uint32},                                    %% __u32 length of captured packet
		       {skb_info,           uint32},                                    %% __u32 skb meta information
		       {exp,                none},                                      %% nf_conntrack_netlink.h
		       {uid,                uint32},                                    %% __u32 sk uid
		       {gid,                uint32}                                     %% __u32 sk gid
		      ]},

     {{ nfqnl, attr, ct_info }, [established,
				 related,
				 new,
				 established_reply,
				 related_reply,
				 new_reply]},

     {{nft, expr, attributes}, [{unspec, none},
				{name,   string},
				{data,   binary}]},

     {{nft, immediate, attributes}, [{unspec,  none},
				     {dreg, uint32},
				     {data, {nested, {nft, data, attributes}}}]},

     {{nft, data, attributes}, [{unspec,  none},
				{value,   binary},
				{verdict, {nested, {nft, verdict, attributes}}}]},
     {{nft, verdict, attributes}, [{unspec,  none},
				   {code,    atom32},
				   {chain,   string}]},
     {{nft, verdict, attributes, code}, [{continue, {atom, 4294967296 - 1}},
					 {break,    {atom, 4294967296 - 2}},
					 {jump,     {atom, 4294967296 - 3}},
					 {goto,     {atom, 4294967296 - 4}},
					 {return,   {atom, 4294967296 - 5}}]},

     {{nft, bitwise, attributes}, [{unspec, none},
				   {sreg,   uint32},
				   {dreg,   uint32},
				   {len,    uint32},
				   {mask,   {nested, {nft, data, attributes}}},
				   {'xor',  {nested, {nft, data, attributes}}}]},

     {{nft, lookup, attributes}, [{unspec,  none},
				  {set,     string},
				  {sreg,    uint32},
				  {dreg,    uint32},
				  {set_id,  uint32}]},

     {{nft, meta, attributes}, [{unspec,  none},
				{dreg,    uint32},
				{key,     atom32},
				{sreg,    uint32}]},

     {{nft, meta, attributes, key}, [len,
				     protocol,
				     priority,
				     mark,
				     iif,
				     oif,
				     iifname,
				     oifname,
				     iiftype,
				     oiftype,
				     skuid,
				     skgid,
				     nftrace,
				     rtclassid,
				     secmark,
				     nfproto,
				     l4proto,
				     bri_iifname,
				     bri_oifname,
				     pkttype,
				     cpu,
				     iifgroup,
				     oifgroup,
				     cgroup]},

     {{nft, payload, attributes}, [{unspec,  none},
				   {dreg,    uint32},
				   {base,    atom32},
				   {offset,  uint32},
				   {len,     uint32}]},
     {{nft, payload, attributes, base}, [ll_header, network_header, transport_header]},

     {{nft, reject, attributes}, [{unspec,    none},
				  {type,      atom32},
				  {icmp_code, atom}]},
     {{nft, reject, attributes, type}, [icmp_unreach, tcp_rst,icmpx_unreach]},
     {{nft, reject, attributes, icmp_code}, [no_route, port_unreach, host_unreach, admin_prohibited]},

     {{nft, ct, attributes}, [{unspec,    none},
			      {dreg,      uint32},
			      {key,       atom32},
			      {direction, uint8},
			      {sreg,      uint32}]},
     {{nft, ct, attributes, key}, [state,
				   direction,
				   status,
				   mark,
				   secmark,
				   expiration,
				   helper,
				   l3protocol,
				   src,
				   dst,
				   protocol,
				   proto_src,
				   proto_dst,
				   labels]},

     {{nft, queue, attributes}, [{unspec,  none},
				 {num,     uint16},
				 {total,   uint16},
				 {flags,   flag16}]},
     {{nft, queue, attributes, flags}, [{bypass,     flag},
					{cpu_fanout, flag},
					{mask,       flag}]},

     {{nft, cmp, attributes}, [{unspec,  none},
			       {sreg,    uint32},
			       {op,      atom32},
			       {data,    {nested, {nft, data, attributes}}}]},

     {{nft, cmp, attributes, op}, [eq, neq, lt, lte, gt, gte]},

     {{nft, match, attributes}, [{unspec,  none},
				 {name,    string},
				 {rev,     uint32},
				 {info,    binary}]},

     {{nft, target, attributes}, [{unspec,  none},
				  {name,    string},
				  {rev,     uint32},
				  {info,    binary}]},

     {{nft, list, attributes, expr}, [{unspec, none},
				      {expr,   {nested, {nft, expr, attributes}}}]},

     {{nft, counter, attributes}, [{unspec,  none},
				   {bytes,   uint64},
				   {packets, uint64}]},

     {{nft, table, attributes}, [{unspec,   none},
				 {name,     string},
				 {flags,    flag32},
				 {use,      uint32}
				]},
     {{nft, table, attributes, flags}, [{dormant, flag}]},

     {{nft, chain, attributes}, [{unspec,   none},
				 {table,    string},
				 {handle,   uint64},
				 {name,     string},
				 {hook,     {nested, hook}},
				 {policy,   atom32},
				 {use,      uint32},
				 {type,     string},
				 {counters, {nested, {nft, counter, attributes}}}
				]},
     {{nft, chain, attributes, hook}, [{unspec,   none},
				       {hooknum,  uint32},
				       {priority, int32},
				       {dev,      string}]},
     {{nft, chain, attributes, policy}, [drop, accept, stolen, queue, repeat, stop]},

     {{nft, rule, attributes}, [{unspec,      none},
				{table,       string},
				{chain,       string},
				{handle,      uint64},
				{expressions, {nested, {nft, list, attributes, expr}}},
				{compat,      binary},
				{position,    uint64},
				{userdata,    binary}
			       ]},

     {{nft, set, attributes}, [{unspec,      none},
			       {table,       string},
			       {name,        string},
			       {flags,       flag32},
			       {key_type,    binary},
			       {key_len,     uint32},
			       {data_type,   binary},
			       {data_len,    uint32},
			       {policy,      atom32},
			       {desc,        binary},
			       {id,          uint32},
			       {timeout,     uint64},
			       {gc_interval, uint32}
			      ]},
     {{nft, set, attributes, policy}, [drop, accept, stolen, queue, repeat, stop]},

     {{nft, set, attributes, flags}, [{anonymous, flag},
				      {constant,  flag},
				      {interval,  flag},
				      {map,       flag},
				      {timeout,   flag},
				      {eval,      flag}]},

     {{nft, set, elem, list, attributes}, [{unspec,   none},
					   {table,    string},
					   {set,      string},
					   {elements, {nested, {nft, set, elem, list, elements}}},
					   {set_id,   uint32}
					  ]},

     {{nft, set, elem, list, elements}, [{unspec, none},
					 {element,   {nested, {nft, set, ext, attributes}}}]},

     {{nft, set, ext, attributes}, [{unspec,     none},
				    {key,        {nested, {nft, data, attributes}}},
				    {data,       {nested, {nft, data, attributes}}},
				    {flags,      flag32},
				    {timeout,    uint64},
				    {expiration, uint64},
				    {userdata,   binary},
				    {expr,       {nested, {nft, expr, attributes}}}
				   ]},
     {{nft, set, ext, attributes, flags}, [{interval_end, flag}]},

     {{nft, gen, attributes}, [{unspec, none},
			       {id,     uint32}
			       ]},


     {{genl, ctrl, cmd}, [unspec,
			  newfamily,
			  delfamily,
			  getfamily,
			  newops,
			  delops,
			  getops,
			  newmcast_grp,
			  delmcast_grp,
			  getmcast_grp]},

     {{genl, ctrl, attr}, [{unspec,       none},
			   {family_id,    {hatom16, {protocol, subsys}}},
			   {family_name,  string},
			   {version,      huint32},
			   {hdrsize,      huint32},
			   {maxattr,      huint32},
			   {ops,          {nested, ops}},
			   {mcast_groups, {nested, mcast_groups}}
			  ]},

     {{genl, ctrl, attr, op}, [{unspec, none},
			       {id,     huint32},
			       {flags,  huint32}
			       ]},
     {{genl, ctrl, attr, mcast_grp}, [{unspec, none},
				      {name,   string},
				      {id,     huint32}
				     ]},

     {{linkinfo, gtp}, [{unspec, none},
			{fd0, huint32},
			{fd1, huint32},
			{hashsize, huint32}]},

     {{gtp, cmd}, [new, delete, get]},


     {{gtp, attrs}, [{unspec,       none},
		     {link,         huint32},
		     {version,      huint32},
		     {tid,          huint64},
		     {sgsn_address, addr},
		     {ms_address,   addr},
		     {flow,         huint16},
		     {net_ns_fd,    huint32},
		     {i_tid,        huint32},
		     {o_tid,        huint32}]},

     {{ipvs, cmd}, [unspec, new_service, set_service, del_service, get_service, new_dest, set_dest, del_dest, get_dest]},

     {{ipvs, attrs}, [
        {unspec,          none},
        {service,         {nested, {ipvs, service, attributes}}},
        {dest,            {nested, {ipvs, dest, attributes}}},
        {daemon,          {nested, {ipvs, daemon, attributes}}},
        {timeout_tcp,     huint32},
        {timeout_tcp_fin, huint32},
        {timeout_udp,     huint32}
     ]},

     {{ipvs, service, attributes}, [
        {unspec,            none},
        {address_family,    huint16},
        {protocol,          huint16},
        {address,           binary},
        {port,              uint16},
        {fwmark,            huint32},
        {sched_name,        string},
        {flags,             struct},
        {timeout,           huint32},
        {netmask,           huint32},
        {stats,             none},
        {pe_name,           string},
        {stats64,           none}
     ]},
     {{ipvs, dest, attributes}, [
        {unspec,            none},
        {address,           binary},
        {port,              uint16},
        {fwd_method,        huint32},
        {weight,            huint32},
        {u_threshold,       huint32},
        {l_threshold,       huint32},
        {active_conns,      huint32},
        {inact_conns,       huint32},
        {persist_conns,     huint32},
        {stats,             none},
        {addr_family,       huint16},
        {stats64,           none}
     ]},
     {{ipvs, daemon, attributes}, [
        {state,             huint32},
        {mcast_ifn,         string},
        {sync_id,           huint32},
        {sync_maxlen,       huint16},
        {mcast_group,       huint32},
        {mcast_group6,      none},
        {mcast_port,        huint16},
        {ttl,               uint8}
     ]}
     ].

make_prefix(Id) when is_atom(Id) ->
    [Id];
make_prefix(Id) when is_tuple(Id) ->
    tuple_to_list(Id).

make_name(Prefix, Name) ->
    Prefix ++ [Name].

format_name(Name) ->
    case lists:last(Name) of
	L when is_tuple(L) ->
	    format_name(tuple_to_list(L));
	L when is_atom(L) ->
	    string:join([atom_to_list(X) || X <- Name], "_")
    end.

linarize(_Prefix, [], _Count, Acc) ->
    lists:reverse(Acc);
linarize(Prefix, [Name|Elements], Count, Acc) when is_atom(Name) ->
    linarize(Prefix, Elements, Count + 1, [{Prefix, Name, Count, atom_def}|Acc]);
linarize(Prefix, [{Name, {atom, Pos}}|Elements], Count, Acc) ->
    linarize(Prefix, Elements, Count + 1, [{Prefix, Name, Pos, atom_def}|Acc]);
linarize(Prefix, [{Name, {flag, Pos}}|Elements], Count, Acc) ->
    linarize(Prefix, Elements, Count + 1, [{Prefix, Name, 1 bsl Pos, flag}|Acc]);
linarize(Prefix, [{Name, flag}|Elements], Count, Acc) ->
     linarize(Prefix, Elements, Count + 1, [{Prefix, Name, 1 bsl Count, flag}|Acc]);
linarize(Prefix, [{Name, Type}|Elements], Count, Acc) ->
     linarize(Prefix, Elements, Count + 1, [{Prefix, Name, Count, Type}|Acc]);
linarize(Prefix, [Head|_Elements], Count, _Acc) ->
    io:format("don't match:~nPrefix: ~p~nHead: ~p~nCount: ~p~n", [Prefix, Head, Count]).

linarize({Id, Elements}, Acc) ->
    Prefix = make_prefix(Id),
    N = linarize(Prefix, Elements, 0, []),
    [N|Acc].

flag_len(hflag8) ->    8;
flag_len(hflag16) ->  16;
flag_len(hflag32) ->  32;
flag_len(flag8) ->     8;
flag_len(flag16) ->   16;
flag_len(flag32) ->   32.

flag2int(hflag8) ->   huint8;
flag2int(hflag16) ->  huint16;
flag2int(hflag32) ->  huint32;
flag2int(flag8) ->    uint8;
flag2int(flag16) ->   uint16;
flag2int(flag32) ->   uint32.


format_id(Id) when is_integer(Id) ->
    integer_to_list(Id);
format_id(Id) when is_atom(Id) ->
    atom_to_list(Id);
format_id(Id) ->
    Id.

make_decoder({Name, Attr, Pos, {atom, Next}}) ->
    io_lib:format("decode_~s(_Family, ~w, <<Value:8>>) ->~n    {~s, decode_~s(Value)}", [format_name(Name), Pos, Attr, format_name(make_name(Name, Next))]);
make_decoder({Name, Attr, Pos, {hatom16, Next}}) ->
    io_lib:format("decode_~s(_Family, ~w, Value) ->~n    {~s, decode_~s(decode_huint16(Value))}", [format_name(Name), Pos, Attr, format_name(make_name(Name, Next))]);
make_decoder({Name, Attr, Pos, {atom32, Next}}) ->
    io_lib:format("decode_~s(_Family, ~w, <<Value:32>>) ->~n    {~s, decode_~s(Value)}", [format_name(Name), Pos, Attr, format_name(make_name(Name, Next))]);

make_decoder({Name, Attr, Pos, Atom})
  when Atom == atom; Atom == hatom16; Atom == atom32 ->
    make_decoder({Name, Attr, Pos, {Atom, Attr}});


make_decoder({Name, Attr, Pos, Type})
  when Type == flag8;  Type == flag16;  Type == flag32 ->
    io_lib:format("decode_~s(_Family, ~w, <<Value:~w>>) ->~n    {~s, decode_flag(flag_info_~s(), Value)}", [format_name(Name), Pos, flag_len(Type), Attr, format_name(make_name(Name, Attr))]);
make_decoder({Name, Attr, Pos, Type})
  when Type == hflag8; Type == hflag16; Type == hflag32 ->
    io_lib:format("decode_~s(_Family, ~w, <<Value:~w/native-integer>>) ->~n    {~s, decode_flag(flag_info_~s(), Value)}", [format_name(Name), Pos, flag_len(Type), Attr, format_name(make_name(Name, Attr))]);

make_decoder({Name, Attr, Pos, atom_def}) ->
    io_lib:format("decode_~s(~s) ->~n    ~p", [format_name(Name), format_id(Pos), Attr]);

make_decoder({Name, Attr, Pos, Type})
  when Type == hsint32_array;
       Type == huint32_array;
       Type == huint64_array ->
    io_lib:format("decode_~s(_Family, ~w, Value) ->~n    decode_~p(~s, Value)", [format_name(Name), Pos, Type, Attr]);

make_decoder({Name, Attr, Pos, if_map}) ->
    io_lib:format("decode_~s(_Family, ~w, Value) ->~n    decode_if_map(~s, Value)", [format_name(Name), Pos, Attr]);

make_decoder({Name, Attr, Pos, {nested, Next}}) ->
    io_lib:format("decode_~s(Family, ~w, Value) ->~n    {~p, nl_dec_nla(Family, fun decode_~s/3, Value)}", [format_name(Name), Pos, Attr, format_name(make_name(Name, Next))]);

make_decoder({Name, Attr, Pos, Type})
  when Type == binary; Type == none; Type == string;
       Type == uint8;  Type == uint16;  Type == uint32;  Type == uint64;
       Type == huint8; Type == huint16; Type == huint32; Type == huint64;
       Type == int8;  Type == int16;  Type == int32;  Type == int64;
       Type == hint8; Type == hint16; Type == hint32; Type == hint64;
       Type == protocol; Type == mac; Type == addr ->
    %% built ins
    io_lib:format("decode_~s(_Family, ~w, Value) ->~n    {~p, decode_~p(Value)}", [format_name(Name), Pos, Attr, Type]);

make_decoder({Name, Attr, Pos, struct}) ->
    %% built in
    io_lib:format("decode_~s(_Family, ~w, Value) ->~n    decode_~s(~p, Value)", [format_name(Name), Pos, format_name(Name), Attr]);

make_decoder({Name, Attr, Pos, Type}) ->
    io_lib:format("decode_~s(Family, ~w, Value) ->~n    {~p, nl_dec_nla(Family, fun decode_~s/3, Value)}", [format_name(Name), Pos, Attr, format_name(make_name(Name, Type))]).

make_element_decoder_last({Name, _Attr, _Pos, Type})
  when Type == atom_def ->
    [io_lib:format("decode_~s(Value) ->~n    Value", [format_name(Name)])];
make_element_decoder_last({Name, _Attr, _Pos, _Type}) ->
    [io_lib:format("decode_~s(_Family, Id, Value) ->~n    {Id, Value}", [format_name(Name)])].

make_element_decoder([{_Name, _Attr, _Pos, flag}|_]) ->
    [];
make_element_decoder(List) ->
    DecoderList = lists:map(fun make_decoder/1, List) ++ make_element_decoder_last(hd(List)),
    string:join(DecoderList, ";\n\n") ++ ".".

%%
%%
%%

make_encoder({Name, Attr, Pos, {atom, Next}}) ->
    io_lib:format("encode_~s(_Family, {~w, Value}) ->~n    encode_uint8(~s, encode_~s(Value))", [format_name(Name), Attr, format_id(Pos), format_name(make_name(Name, Next))]);
make_encoder({Name, Attr, Pos, {hatom16, Next}}) ->
    io_lib:format("encode_~s(_Family, {~w, Value}) ->~n    encode_huint16(~s, encode_~s(Value))", [format_name(Name), Attr, format_id(Pos), format_name(make_name(Name, Next))]);
make_encoder({Name, Attr, Pos, {atom32, Next}}) ->
    io_lib:format("encode_~s(_Family, {~w, Value}) ->~n    encode_uint32(~s, encode_~s(Value))", [format_name(Name), Attr, format_id(Pos), format_name(make_name(Name, Next))]);

make_encoder({Name, Attr, Pos, Atom})
  when Atom == atom; Atom == hatom16; Atom == atom32 ->
    make_encoder({Name, Attr, Pos, {Atom, Attr}});

make_encoder({Name, Attr, Pos, Type})
  when Type == flag8;  Type == flag16;  Type == flag32;
       Type == hflag8; Type == hflag16; Type == hflag32 ->
    io_lib:format("encode_~s(_Family, {~w, Value}) ->~n    encode_~w(~w, encode_flag(flag_info_~s(), Value))", [format_name(Name), Attr, flag2int(Type), Pos, format_name(make_name(Name, Attr))]);

make_encoder({Name, Attr, Pos, if_map}) ->
    io_lib:format("encode_~s(_Family, Value)  when is_tuple(Value), element(1, Value) == ~p ->~n    encode_if_map(~w, Value)", [format_name(Name), Attr, Pos]);

make_encoder({Name, Attr, Pos, {nested, Next}}) ->
    io_lib:format("encode_~s(Family, {~p, Value}) ->~n    enc_nla(~s, nl_enc_nla(Family, fun encode_~s/2, Value))", [format_name(Name), Attr, format_id(Pos), format_name(make_name(Name, Next))]);

make_encoder({Name, Attr, Pos, atom_def}) ->
    io_lib:format("encode_~s(~p) ->~n    ~s", [format_name(Name), Attr, format_id(Pos)]);

make_encoder({Name, Attr, Pos, Type})
  when Type == hsint32_array; Type == huint32_array; Type == huint64_array ->
    %% built ins
    io_lib:format("encode_~s(_Family, Value)~n  when is_tuple(Value), element(1, Value) == ~p ->~n    encode_~p(~s, Value)", [format_name(Name), Attr, Type, format_id(Pos)]);

make_encoder({Name, Attr, Pos, struct}) ->
    %% built in
    io_lib:format("encode_~s(_Family, Value)~n  when is_tuple(Value), element(1, Value) == ~p ->~n    enc_nla(~s, encode_~s(Value))", [format_name(Name), Attr, format_id(Pos), format_name(Name)]);

make_encoder({Name, Attr, Pos, Type})
  when Type == binary; Type == none; Type == string;
       Type == uint8;  Type == uint16;  Type == uint32;  Type == uint64;
       Type == huint8; Type == huint16; Type == huint32; Type == huint64;
       Type == int8;  Type == int16;  Type == int32;  Type == int64;
       Type == hint8; Type == hint16; Type == hint32; Type == hint64;
       Type == protocol; Type == mac; Type == addr ->
    %% built ins
    io_lib:format("encode_~s(_Family, {~p, Value}) ->~n    encode_~p(~s, Value)", [format_name(Name), Attr, Type, format_id(Pos)]);

make_encoder({Name, Attr, Pos, Type}) ->
    io_lib:format("encode_~s(Family, {~p, Value}) ->~n    enc_nla(~s bor 16#8000, nl_enc_nla(Family, fun encode_~s/2, Value))", [format_name(Name), Attr, format_id(Pos), format_name(make_name(Name, Type))]).

make_element_encoder_last({Name, _Attr, _Pos, Type})
  when Type == atom_def ->
    [io_lib:format("encode_~s(Value) when is_integer(Value) ->~n    Value", [format_name(Name)])];
make_element_encoder_last({Name, _Attr, _Pos, _Type}) ->
    [io_lib:format("encode_~s(_Family, {Type, Value})~n  when is_integer(Type), is_binary(Value) ->~n    enc_nla(Type, Value)", [format_name(Name)])].

make_element_encoder([{_Name, _Attr, _Pos, flag}|_]) ->
    [];
make_element_encoder(List) ->
    EncoderList = lists:map(fun make_encoder/1, List) ++ make_element_encoder_last(hd(List)),
    string:join(EncoderList, ";\n\n") ++ ".".

%%
%%
%%

make_flag_info(List = [{Name, _Attr, _Pos, flag}|_]) ->
    FlagList = [{Pos, Attr} || {_Name, Attr, Pos, _} <- List],
    io_lib:format("flag_info_~s() ->~n    ~p.", [format_name(Name), FlagList]);
make_flag_info(_) ->
    [].

process(Fun, List) ->
    L1 = lists:map(Fun, List),
    lists:filter(fun([]) -> false;
		    (_)  -> true end, L1).

main(_) ->
    A = define_consts(),

    %% build a liniarized list...
    L = lists:reverse(lists:foldl(fun linarize/2, [], A)),

    %% io:format("~p~n", [L]),

    FlagList = process(fun make_flag_info/1, L),
    DecoderList = process(fun make_element_decoder/1, L),
    EncoderList = process(fun make_element_encoder/1, L),

    D = "%%\n%% This file is auto-generated. DO NOT EDIT\n%%" ++
	"\n\n%% ============================\n\n" ++
	io_lib:format("~s", [string:join(FlagList, "\n\n")]) ++
	"\n\n%% ============================\n\n" ++
	io_lib:format("~s", [string:join(DecoderList, "\n\n%% ============================\n\n")]) ++
	"\n\n%% ============================\n\n" ++
	io_lib:format("~s", [string:join(EncoderList, "\n\n%% ============================\n\n")]),
    file:write_file("src/netlink_decoder_gen.hrl", D).
