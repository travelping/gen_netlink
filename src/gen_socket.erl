%% Copyright (c) 2010, Travelping GmbH <info@travelping.com
%% All rights reserved.
%%  
%% based on procket:
%%
%% Copyright (c) 2010, Michael Santos <michael.santos@gmail.com>
%% All rights reserved.
%% 
%% Redistribution and use in source and binary forms, with or without
%% modification, are permitted provided that the following conditions
%% are met:
%% 
%% Redistributions of source code must retain the above copyright
%% notice, this list of conditions and the following disclaimer.
%% 
%% Redistributions in binary form must reproduce the above copyright
%% notice, this list of conditions and the following disclaimer in the
%% documentation and/or other materials provided with the distribution.
%% 
%% Neither the name of the author nor the names of its contributors
%% may be used to endorse or promote products derived from this software
%% without specific prior written permission.
%% 
%% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
%% "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
%% LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
%% FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
%% COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
%% INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
%% BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
%% LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
%% CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
%% LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
%% ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
%% POSSIBILITY OF SUCH DAMAGE.

-module(gen_socket).
-include("gen_socket.hrl").

-export([
         init/0,
         socket/3,
         listen/1, listen/2,
         connect/2,
         accept/1, accept/2,
         close/1,
         recv/2, recvfrom/2, recvfrom/4,
         send/3, sendto/4,
         bind/2,
         ioctl/3,
         setsockopt/4,
         setsockoption/4
    ]).
-export([progname/0]).
-export([family/1, type/1, protocol/1]).

-on_load(on_load/0).

%%
%% grep define include/gen_socket.hrl | awk -F"[(,]" '{ printf "enc_opt(%s)%*s ?%s;\n", tolower($2), 32 - length($2), "->", $2 }
%%
enc_opt(sol_socket)                    -> ?SOL_SOCKET;
enc_opt(so_debug)                      -> ?SO_DEBUG;
enc_opt(so_reuseaddr)                  -> ?SO_REUSEADDR;
enc_opt(so_type)                       -> ?SO_TYPE;
enc_opt(so_error)                      -> ?SO_ERROR;
enc_opt(so_dontroute)                  -> ?SO_DONTROUTE;
enc_opt(so_broadcast)                  -> ?SO_BROADCAST;
enc_opt(so_sndbuf)                     -> ?SO_SNDBUF;
enc_opt(so_rcvbuf)                     -> ?SO_RCVBUF.

init() ->
    on_load().

on_load() ->
    erlang:load_nif(progname(), []).


close(_) ->
    erlang:error(not_implemented).

accept(Socket) ->
    case accept(Socket, 0) of
        {ok, FD, <<>>} -> {ok, FD};
        Error -> Error
    end.
accept(_,_) ->
    erlang:error(not_implemented).

bind(_,_) ->
    erlang:error(not_implemented).

connect(_,_) ->
    erlang:error(not_implemented).

listen(Socket) when is_integer(Socket) ->
    listen(Socket, ?BACKLOG).
listen(_,_) ->
    erlang:error(not_implemented).

recv(Socket,Size) ->
    recvfrom(Socket,Size).
recvfrom(Socket,Size) ->
    case recvfrom(Socket, Size, 0, 0) of
        {ok, Buf, <<>>} -> {ok, Buf}; 
        Error -> Error
    end.
recvfrom(_,_,_,_) ->
    erlang:error(not_implemented).

socket(Family, Type, Protocol) when is_atom(Family) ->
    socket(family(Family), Type, Protocol);
socket(Family, Type, Protocol) when is_atom(Type) ->
    socket(Family, type(Type), Protocol);
socket(Family, Type, Protocol) when is_atom(Protocol) ->
    socket(Family, Type, protocol(Protocol));
socket(Family, Type, Protocol) when is_integer(Family); is_integer(Type); is_integer(Protocol) ->
    socket3(Family, Type, Protocol).

socket3(_,_,_) ->
    erlang:error(not_implemented).

ioctl(_,_,_) ->
    erlang:error(not_implemented).

sendto(_,_,_,_) ->
    erlang:error(not_implemented).

send(_,_,_) ->
    erlang:error(not_implemented).

setsockopt(_,_,_,_) ->
    erlang:error(not_implemented).

setsockoption(Socket, Level, OptName, Val) when is_atom(Level) ->
    setsockoption(Socket, enc_opt(Level), OptName, Val);
setsockoption(Socket, Level, OptName, Val) when is_atom(OptName) ->
    setsockoption(Socket, Level, enc_opt(OptName), Val);
setsockoption(Socket, Level, OptName, Val) when is_atom(Val) ->
    setsockoption(Socket, Level, OptName, enc_opt(Val));
setsockoption(Socket, Level, OptName, Val) when is_integer(Val) ->
    setsockopt(Socket, Level, OptName, << Val:32/native >>).

progname() ->
    filename:join([
        filename:dirname(code:which(?MODULE)),
        "..",
        "priv",
        ?MODULE
    ]).

%% Protocol family (aka domain)
family(unspec) -> 0;
family(inet) -> 2;
family(ax25) -> 3;
family(ipx) -> 4;
family(appletalk) -> 5;
family(netrom) -> 6;
family(bridge) -> 7;
family(atmpvc) -> 8;
family(x25) -> 9;
family(inet6) -> 10;
family(rose) -> 11;
family(decnet) -> 12;
family(netbeui) -> 13;
family(security) -> 14;
family(key) -> 15;
family(packet) -> 17;
family(ash) -> 18;
family(econet) -> 19;
family(atmsvc) -> 20;
family(rds) -> 21;
family(sna) -> 22;
family(irda) -> 23;
family(pppox) -> 24;
family(wanpipe) -> 25;
family(llc) -> 26;
family(can) -> 29;
family(tipc) -> 30;
family(bluetooth) -> 31;
family(iucv) -> 32;
family(rxrpc) -> 33;
family(isdn) -> 34;
family(phonet) -> 35;
family(ieee802154) -> 36;
family(Proto) when Proto == local; Proto == unix; Proto == file -> 1;
family(Proto) when Proto == netlink; Proto == route -> 16;

family(0) -> unspec;
family(1) -> unix;
family(2) -> inet;
family(3) -> ax25;
family(4) -> ipx;
family(5) -> appletalk;
family(6) -> netrom;
family(7) -> bridge;
family(8) -> atmpvc;
family(9) -> x25;
family(10) -> inet6;
family(11) -> rose;
family(12) -> decnet;
family(13) -> netbeui;
family(14) -> security;
family(15) -> key;
family(17) -> packet;
family(18) -> ash;
family(19) -> econet;
family(20) -> atmsvc;
family(21) -> rds;
family(22) -> sna;
family(23) -> irda;
family(24) -> pppox;
family(25) -> wanpipe;
family(26) -> llc;
family(29) -> can;
family(30) -> tipc;
family(31) -> bluetooth;
family(32) -> iucv;
family(33) -> rxrpc;
family(34) -> isdn;
family(35) -> phonet;
family(36) -> ieee802154.

%% Socket type
type(stream) -> 1;
type(dgram) -> 2;
type(raw) -> 3;

type(1) -> stream;
type(2) -> dgram;
type(3) -> raw.


% Select a protocol within the family (0 means use the default
% protocol in the family)
protocol(ip) -> 0;
protocol(icmp) -> 1;
protocol(igmp) -> 2;
protocol(ipip) -> 4;
protocol(tcp) -> 6;
protocol(egp) -> 8;
protocol(pup) -> 12;
protocol(udp) -> 17;
protocol(idp) -> 22;
protocol(tp) -> 29;
protocol(dccp) -> 33;
protocol(ipv6) -> 41;
protocol(routing) -> 43;
protocol(fragment) -> 44;
protocol(rsvp) -> 46;
protocol(gre) -> 47;
protocol(esp) -> 50;
protocol(ah) -> 51;
protocol(icmpv6) -> 58;
protocol(none) -> 59;
protocol(dstopts) -> 60;
protocol(mtp) -> 92;
protocol(encap) -> 98;
protocol(pim) -> 103;
protocol(comp) -> 108;
protocol(sctp) -> 132;
protocol(udplite) -> 136;
protocol(raw) -> 255;

protocol(0) -> ip;
protocol(1) -> icmp;
protocol(2) -> igmp;
protocol(4) -> ipip;
protocol(6) -> tcp;
protocol(8) -> egp;
protocol(12) -> pup;
protocol(17) -> udp;
protocol(22) -> idp;
protocol(29) -> tp;
protocol(33) -> dccp;
protocol(41) -> ipv6;
protocol(43) -> routing;
protocol(44) -> fragment;
protocol(46) -> rsvp;
protocol(47) -> gre;
protocol(50) -> esp;
protocol(51) -> ah;
protocol(58) -> icmpv6;
protocol(59) -> none;
protocol(60) -> dstopts;
protocol(92) -> mtp;
protocol(98) -> encap;
protocol(103) -> pim;
protocol(108) -> comp;
protocol(132) -> sctp;
protocol(136) -> udplite;
protocol(255) -> raw;
protocol(X) -> X.


