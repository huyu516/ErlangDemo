-module(t8).

-export([start/2, cancel/1]).

start(Time, Fun) -> spawn(fun() -> timer(Time, Fun) end).

cancel(Pid) -> Pid ! cancel.

timer(Time, Fun) ->
    receive
		cancel -> void
    after Time ->
	    Fun()
    end.

%% Pid = t8:start(5000, fun() -> io:format("hello world") end).
%% t8:cancel(Pid).cancel