%% Copyright (c) 2010, Travelping GmbH <info@travelping.com>
%% All rights reserved.

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

-type flags() :: list(atom()).
-type family() :: atom().
-type protocol() :: atom().
-type arphdr() :: atom().
-type ifindex() :: non_neg_integer().
-type resid() :: non_neg_integer().
-type nla() :: list({atom(),term()}).
-type ctnetlink_msg() :: {family(),non_neg_integer(),non_neg_integer(),list()}.
-type rtnetlink_neigh() :: {family(),ifindex(),non_neg_integer(),flags(),non_neg_integer(),nla()}.
-type rtnetlink_route() :: {family(),non_neg_integer(),non_neg_integer(),non_neg_integer(),non_neg_integer(),protocol(),non_neg_integer(),non_neg_integer(),flags(),nla()}.
-type rtnetlink_addr() :: {family(),non_neg_integer(),flags(),non_neg_integer(),non_neg_integer(),nla()}.
-type rtnetlink_link() :: {family(),arphdr(),non_neg_integer(),flags(),flags(),nla()}.
-type rtnetlink_prefix() :: {family(),ifindex(),non_neg_integer(),non_neg_integer(),flags(),nla()}.
-type rtnetlink_msg() :: rtnetlink_neigh() | rtnetlink_route() | rtnetlink_addr() | rtnetlink_link() | rtnetlink_prefix().

-record(rtnetlink, {
		  type          ::atom(),
		  flags         ::list(atom()),
		  seq           ::non_neg_integer(),
		  pid           ::non_neg_integer(),
		  msg           ::rtnetlink_msg()
		 }).

-record(ctnetlink, {
		  type          ::'new'|'get'|'delete'|'get_ctrzero',
		  flags         ::flags(),
		  seq           ::non_neg_integer(),
		  pid           ::non_neg_integer(),
		  msg           ::ctnetlink_msg()
		 }).

-record(ctnetlink_exp, {
		  type          ::'new'|'get'|'delete'|'get_ctrzero',
		  flags         ::flags(),
		  seq           ::non_neg_integer(),
		  pid           ::non_neg_integer(),
		  msg           ::ctnetlink_msg()
		 }).
