-module(t04).

-export([start/2, cancel/1]).

start(Time, Fun) -> spawn(fun() -> timer(Time, Fun) end).

cancel(Pid) -> Pid ! cancel.

timer(Time, Fun) ->
    receive
		cancel -> void
    after Time ->
	    Fun()
    end.

%% Pid = t04:start(5000, fun() -> io:format("hello world") end).
%% t04:cancel(Pid).