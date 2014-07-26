-module(t06).

-compile(export_all).

max(N) ->		
    L = for(1, N, fun() -> spawn(fun() -> wait() end) end),
%% 	L = for(1, N, fun() -> spawn(fun() -> receive die -> void end end) end),

    lists:foreach(fun(Pid) -> Pid ! die end, L), 
	done.

wait() ->
    receive 
		die -> void
    end.

for(N, N, F) -> [F()];
for(I, N, F) -> [F()|for(I+1, N, F)].
