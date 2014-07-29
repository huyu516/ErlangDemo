
-module(server5).

-export([start/0, rpc/2]).

start() -> spawn(fun() -> wait() end).

wait() ->
    receive
		{become, F} -> F() 	%% wait() will change to F(), see my_fac_server:loop/0 	
    end.

rpc(Pid, Q) ->
    Pid ! {self(), Q},
    receive
		{Pid, Reply} -> Reply
    end.

%% Pid = server5:start().
%% Pid!{become, fun my_fac_server:loop/0}.
%% server5:rpc(Pid, {fac, 30}).