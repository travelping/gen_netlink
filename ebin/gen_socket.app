{application, gen_socket,
    [
    {description, "Low level socket operations"},
    {vsn, "0.02"},
    {modules, [
        gen_socket,
        packet,
        mktmp,
        icmp,
        echo,
	netlink
            ]},
    {registered, []},
    {applications, [
        kernel,
        stdlib
            ]},
    {env, []}
    ]}.

