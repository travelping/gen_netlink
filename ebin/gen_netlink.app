{application, gen_netlink,
  [{description,"Netlink socket toolkit"},
   {vsn,"0.02"},
   {modules,[gen_netlink_app,gen_netlink_sup,gen_socket,netlink]},
   {registered,[]},
   {applications,[kernel,stdlib]},
   {mod,{gen_netlink_app,[]}},
   {env,[]}]
}.