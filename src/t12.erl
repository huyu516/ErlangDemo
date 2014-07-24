-module(t12).

-compile(export_all).

%%  module function argument
rpc(Pid, M, F, A) ->                        %% 向该服务节点请求 rpc
    Pid ! {rpc, self(), M, F, A},               
    receive
		{Pid, Response} ->
		    Response
    end.

start(Node) ->							     %% 在别的节点上开始服务ID								
    spawn(Node, fun() -> loop() end).        %% !!!可以在别的node上启动进程 !!!

loop() ->									 %% 服务
    receive
		{rpc, Pid, M, F, A} ->
		    Pid ! {self(), (catch apply(M, F, A))},
		    loop()
    end.

%% 先编译 RPC 非BIF 原理