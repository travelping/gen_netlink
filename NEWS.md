gen_netlink
===========

Erlang Decoder, Encoder and transport library for Linux netlink messages

Version 0.4.0 - xx Oct 2013
---------------------------

* convert ets table based en/decoder to generated code driven en/decoder
  (gives about 2x speedup)
* add proper records for cacheinfo's
* add dump_intr flag
* MAC's are no longer decoded into tupples, all other app's use binaries
  for MAC's, do the same here
* fix protocol field en/decoding for route events
* de/encode getroute and getneigh events
* netlink cache for neighbour's and route's
