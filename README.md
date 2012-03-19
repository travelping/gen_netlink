**WARNING**: pre R15, it was possible to create a non-INET socket and
	     have gen_udp work on it. With R15 the check rules in
	     fd open() have been tightened to prevent this kind of
	     trickery. gen_link used this machanism to wrap its
	     sockets and will therefor not (yet) work with R15.
	     Work is underway to add generic async I/O support
	     to gen_socket that will restore gen_netlink to R15.

gen_netlink
===========

gen_netlink is a encoder, decoder and tool library for talking to the
Linux kernel netlink interface.

gen_netlink uses gen_socket to create a netlink socket and wrap that
socket in a gen_udp port for ease of use.

BUILDING
--------
Try running: tetrapak build
