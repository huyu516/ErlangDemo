-module(t13).

-compile(export_all).

start() -> register(kvs, spawn(fun() -> loop() end)).

store(Key, Value) -> rpc({store, Key, Value}).

lookup(Key) -> rpc({lookup, Key}).

rpc(Q) ->                              %%  kvs rpc : request -> kvs -> reponse  
    kvs ! {self(), Q},
    receive
		{kvs, Reply} -> Reply
    end.

loop() ->
    receive
		{From, {store, Key, Value}} ->  %%  from request
		    put(Key, {ok, Value}),      %%  operate
		    From ! {kvs, true},         %%  from reponse
		    loop();                     %%  tail loop 
		{From, {lookup, Key}} ->
		    From ! {kvs, get(Key)},
		    loop()
    end.

%%  kvs:start().
%%  lib_chan:start_server("D:/Users/lacom/.erlang_config/lib_chan.conf").
%%  lib_chan:start_server("../src/lib_chan.conf").

%%  {ok, Pid} = lib_chan:connect("localhost", 1234, nameServer, "123456", "").
%%  lib_chan:cast(Pid, {store, jeo, "writing a book"}).
%%  lib_chan:rpc(Pid, {lookup, jeo}).