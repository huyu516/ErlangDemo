-module(t11).

-compile(export_all).

%% 创建了一个监视Pid死亡的进程
on_exit(Pid, Fun) ->
    spawn(fun() -> 
			  process_flag(trap_exit, true),   %% 变为系统进程，可以捕获退出信号
			  link(Pid),                     
			  receive
			      {'EXIT', Pid, Why} ->      
				  Fun(Why)   
			  end
	      end).

%% Pid = spawn(fun() -> receive X -> list_to_atom(X) end end).
%% t11:on_exit(Pid, fun(Why) -> io:format("error") end).
%% Pid!hello.