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

-define(NUD_INCOMPLETE, 16#01).
-define(NUD_REACHABLE,  16#02).
-define(NUD_STALE,      16#04).
-define(NUD_DELAY,      16#08).
-define(NUD_PROBE,      16#10).
-define(NUD_FAILED,     16#20).
%% Dummy states
-define(NUD_NOARP,      16#40).
-define(NUD_PERMANENT,  16#80).
-define(NUD_NONE,       16#00).

-define(NF_DROP,   0).
-define(NF_ACCEPT, 1).
-define(NF_STOLEN, 2).
-define(NF_QUEUE,  3).
-define(NF_REPEAT, 4).
-define(NF_STOP,   5).

%% Flags values */

-define(NLM_F_REQUEST,           1).       %% It is request message.
-define(NLM_F_MULTI,             2).       %% Multipart message, terminated by NLMSG_DONE
-define(NLM_F_ACK,               4).       %% Reply with ack, with zero or error code
-define(NLM_F_ECHO,              8).       %% Echo this request
-define(NLM_F_DUMP_INTR,         16).      %% Dump was inconsistent due to sequence change

%% Modifiers to GET request
-define(NLM_F_ROOT,      16#100).   %% specify tree root
-define(NLM_F_MATCH,     16#200).   %% return all matching
-define(NLM_F_ATOMIC,    16#400).   %% atomic GET
-define(NLM_F_DUMP,      (?NLM_F_ROOT bor ?NLM_F_MATCH)).

%% Modifiers to NEW request
-define(NLM_F_REPLACE,   16#100).   %% Override existing
-define(NLM_F_EXCL,      16#200).   %% Do not touch, if it exists
-define(NLM_F_CREATE,    16#400).   %% Create, if it does not exist
-define(NLM_F_APPEND,    16#800).   %% Add to end of list

-type scope() :: universe | site | link | host | nowhere | non_neg_integer().
-type rtm_type() :: unspec | unicast | local | broadcast | anycast | multicast | blackhole | unreachable | prohibit | throw | nat | xresolve | non_neg_integer().
-type table() :: unspec | compat | main | local | non_neg_integer().
-type nl_flags() :: list(atom()).
-type family() :: atom().
-type protocol() :: atom().
-type arphdr() :: atom().
-type ifindex() :: non_neg_integer().
-type resid() :: non_neg_integer().
-type nla() :: list({atom(),term()}).
-type ctnetlink_msg() :: {family(),non_neg_integer(),non_neg_integer(),list()}.
-type rtnetlink_neigh() :: {family(),ifindex(),non_neg_integer(),nl_flags(),non_neg_integer(),nla()}.
-type rtnetlink_route() :: {family(),non_neg_integer(),non_neg_integer(),non_neg_integer(),table(),protocol(),scope(),rtm_type(),nl_flags(),nla()}.

-type rtnetlink_addr() :: {family(),non_neg_integer(),nl_flags(),non_neg_integer(),non_neg_integer(),nla()}.
-type rtnetlink_link() :: {family(),arphdr(),non_neg_integer(),nl_flags(),nl_flags(),nla()}.
-type rtnetlink_prefix() :: {family(),ifindex(),non_neg_integer(),non_neg_integer(),nl_flags(),nla()}.
-type rtnetlink_msg() :: rtnetlink_neigh() | rtnetlink_route() | rtnetlink_addr() | rtnetlink_link() | rtnetlink_prefix().

%% no subsystem
-record(netlink, {
          type          :: noop | error | done | overrun,
          flags         :: nl_flags(),
          seq           :: non_neg_integer(),
          pid           :: non_neg_integer(),
          msg
        }).

-record(rtnetlink, {
		  type          ::atom(),
		  flags         ::nl_flags(),
		  seq           ::non_neg_integer(),
		  pid           ::non_neg_integer(),
		  msg           ::rtnetlink_msg()
		 }).

-record(ctnetlink, {
		  type          ::'new'|'get'|'delete'|'get_ctrzero',
		  flags         ::nl_flags(),
		  seq           ::non_neg_integer(),
		  pid           ::non_neg_integer(),
		  msg           ::ctnetlink_msg()
		 }).

-record(ctnetlink_exp, {
		  type          ::'new'|'get'|'delete'|'get_ctrzero',
		  flags         ::nl_flags(),
		  seq           ::non_neg_integer(),
		  pid           ::non_neg_integer(),
		  msg           ::ctnetlink_msg()
		 }).

-record(nftables, {
		  type          ::atom(),
		  flags         ::nl_flags(),
		  seq           ::non_neg_integer(),
		  pid           ::non_neg_integer(),
		  msg           ::rtnetlink_msg()
		 }).

-record(nda_cacheinfo, {
	  confirmed :: integer(),
	  used      :: integer(),
	  updated   :: integer(),
	  refcnt    :: integer()
	 }).

-record(ifa_cacheinfo, {
	  prefered :: integer(),
	  valid    :: integer(),
	  cstamp   :: integer(),             %% created timestamp, hundredths of seconds
	  tstamp   :: integer()              %% updated timestamp, hundredths of seconds
	 }).

-record(ifla_cacheinfo, {
	  max_reasm_len  :: integer(),
	  tstamp         :: integer(),       %% ipv6InterfaceTable updated timestamp
	  reachable_time :: integer(),
	  retrans_time   :: integer()
	 }).

-record(rta_cacheinfo, {
	  rta_clntref :: integer(),
	  rta_lastuse :: integer(),
	  rta_expires :: integer(),
	  rta_error   :: integer(),
	  rta_used    :: integer(),
	  rta_id      :: integer(),
	  rta_ts      :: integer(),
	  rta_tsage   :: integer()
	 }).

-record(prefix_cacheinfo, {
	  preferred_time :: integer(),
	  valid_time     :: integer()
	 }).

-record(neighbour_cache_entry, {
	  key,                    %% {if_index, dst}
	  if_index,
	  dst,
	  lladdr
	 }).

-record(route_cache_entry, {
	  key,
	  dst,
	  dst_len,
	  table,
	  gateway,
	  oif
	 }).

-record(ifinfomsg, {
	  family,
	  type,
	  index,
	  flags,
	  change
	 }).

-type netlink_record() :: #rtnetlink{} | #ctnetlink{} | #ctnetlink_exp{}.

-type ctnetlink_ev() :: {ctnetlink, MsgGrp :: [#ctnetlink{} | #ctnetlink_exp{}, ...]}.
                     %% netlink event message sent to `ct' subscriber
                     %% `MsgGrp' is a single-part netlink message or a complete
                     %% multipart netlink message.
-type rtnetlink_ev() :: {rtnetlink, [#rtnetlink{}, ...]}.
                     %% netlink event message sent to `rt' subscriber



%-define(LOG(Formatting, Args), lager:debug(Formatting, Args)).
-define(LOG(Formatting, Args), ok).

%-define(LOG(Formatting), lager:debug(Formatting)).
-define(LOG(Formatting), ok).

-define(getfamily, {version = 1, reserved = 0, request}).