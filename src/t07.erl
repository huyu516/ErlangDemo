-module(t07).

-compile(export_all).

rpc(Pid, M, F, A) ->                                
    Pid ! {rpc, self(), M, F, A},               
    receive
		{Pid, Response} -> Response
    end.

start(Node) ->							    					
    spawn(Node, fun() -> loop() end).                

loop() ->									 
    receive
		{rpc, Pid, M, F, A} ->
		    Pid ! {self(), (catch apply(M, F, A))},   
		    loop()
    end.
