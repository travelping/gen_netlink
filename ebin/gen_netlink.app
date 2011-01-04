{application, gen_netlink, [
    {description, "Netlink socket toolkit"},
    {vsn, "0.02"},
    {modules, [gen_socket,
               packet,
	             netlink
              ]},
    {registered, []},
    {applications, [kernel, stdlib]},
    {env, []}
]}.

