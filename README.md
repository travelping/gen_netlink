gen_netlink
===========

gen_netlink is a encoder, decoder and tool library for talking to the
Linux kernel netlink interface.

gen_netlink uses gen_socket to create a netlink socket and wrap that
socket in a gen_udp port for ease of use. For Erlang R15 and greater
a recent gen_socket is required.

BUILDING
--------
Try running: tetrapak build


En/Decoder
----------

The encoder and decoder logic is generated using priv/decode_gen.escript.
The resulting file is included in release archive and the repository to
simplify the build process.
