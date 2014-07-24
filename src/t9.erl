-module(t9).

-compile(export_all).

start(Time, Fun) -> 
    register(clock, spawn(fun() -> tick(Time, Fun) end)).

stop() -> clock ! stop.

tick(Time, Fun) ->
    receive
		stop -> void
    after Time ->
	    Fun(),
	    tick(Time, Fun)
    end.

%% t9:start(1000, fun() -> io:format("hello world") end).
%% t9:stop().