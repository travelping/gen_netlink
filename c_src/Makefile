CFLAGS +=-fPIC -I. $(shell erl -noinput -eval 'io:format("-I~s -I~s/erts-~s/include", [code:lib_dir(erl_interface, include), code:root_dir(), erlang:system_info(version)]), halt(0).')

all: ../priv/gen_socket.so 

clean: 
	rm -f ../priv/*.so
	rm -f *.o

../priv/gen_socket.so: gen_socket.o
	$(CC) $(LDFLAGS) -fPIC -shared -lei -lerl_interface gen_socket.o -o ../priv/gen_socket.so
