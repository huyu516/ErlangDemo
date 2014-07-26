-module(t11).

-compile(export_all).

on_exit(Pid, Fun) ->
    spawn(fun() -> 
			  process_flag(trap_exit, true),  
			  link(Pid),                     
			  receive
			      {'EXIT', Pid, Why} ->      
				  Fun(Why)   
			  end
	      end).

%% Pid = spawn(fun() -> receive X -> list_to_atom(X) end end).
%% t11:on_exit(Pid, fun(Why) -> io:format("error") end).
%% Pid!hello.