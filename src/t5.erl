-module(t5).

-compile(export_all).

start() -> spawn(fun t5:loop/0).                   %% 启动服务端

area(Pid, What) -> rpc(Pid, What).

loop() -> 
	receive
		{From, {rectangle, Width, Height}} -> 
			From!{self(), Width * Height}, loop(); 
		{From, {circle, R}} -> 
			From!{self(), 3.14 * R * R}, loop()
	end.

rpc(Pid, Request) ->
	Pid ! {self(), Request}, 						%% self()是客户进程自己的Pid
    receive
		{Pid, Response} -> Response
    end.

%% Pid = t5:start().
%% t5:area(Pid, {circle, 10}).

%% register(area, Pid)

%% register(calcArea, Pid).
%% calcArea!{self, }




