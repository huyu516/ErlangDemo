-module(server4).

-export([start/2, rpc/2, swap_code/2]).

start(Name, Mod) ->
    register(Name, spawn(fun() -> loop(Name,Mod,Mod:init()) end)).

swap_code(Name, Mod) -> rpc(Name, {swap_code, Mod}).

rpc(Name, Request) ->
    Name ! {self(), Request},
    receive
        {Name, crash} -> exit(rpc);
        {Name, ok, Response} -> Response
    end.

loop(Name, Mod, OldState) ->
    receive
		{From, {swap_code, NewCallbackMod}} ->
		    From ! {Name, ok, ack},
		    loop(Name, NewCallbackMod, OldState);
		{From, Request} ->
		    try Mod:handle(Request, OldState) of
				{Response, NewState} ->
				    From ! {Name, ok, Response},
				    loop(Name, Mod, NewState)
		    catch
				_: Why ->
				    From ! {Name, crash},
				    loop(Name, Mod, OldState)
		    end
    end.

%% server4:start(name_server, name_server).
%% name_server:add(joe, "at home").

%% server4:swap_code(name_server, new_name_server).
%% new_name_server:all_names().
%% new_name_server:whereis(joe).

