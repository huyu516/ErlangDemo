-module(t12).

-compile(export_all).

rpc(Pid, M, F, A) ->                               %% use remote Pid to execute function        
    Pid ! {rpc, self(), M, F, A},               
    receive
		{Pid, Response} ->
		    Response
    end.

start(Node) ->							    					
    spawn(Node, fun() -> loop() end).                %% start in remote and get Pid

loop() ->									 
    receive
		{rpc, Pid, M, F, A} ->
		    Pid ! {self(), (catch apply(M, F, A))},   %% execute function
		    loop()
    end.
