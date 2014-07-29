
-module(t12).

-compile(export_all).

%%  TableId = ets:new(storage, [set, private]).
%%  ets:insert(TableId, {u1, tom}).
%%  ets:lookup(TableId, u1).
%%  ets:delete(TableId).

%% ?MODULE
open() ->
    case dets:open_file(mydata, [{file,"mydata.dets"}]) of
        {ok,    mydata} ->  true;
        {error, Reason} ->  exit(Reason)
	end.

%%  dets:insert(mydata, {u1, tom}).
%%  dets:lookup(mydata, u1).
%% 	dets:close(mydata).



