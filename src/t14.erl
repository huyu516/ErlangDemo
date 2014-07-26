-module(t14).

-compile(export_all).

-include_lib("kernel/include/file.hrl").

%% file:read_file_info(file)                  -> -record
%% file:list_dir(".").
%% file:copy(Source ,Destination).
%% file:delete(File)
%% filelib:file_size(File)
%% filelib:is_dir(X)
%% 
%% file:consult(file). -> all to obj  
%% 
%% fd = file.open
%% 	io:format(fd, "~p.~n",[Content])       -> write line
%% 	file:read_file(file)                   -> all to binary  
%% 	file:pwrite(S, 10, <<"new">>).         -> random write binary
%% 	file:pread(S, 22, 46).                 -> random read  binary

consult(File) ->
    case file:open(File, read) of
		{ok, S} ->
		    Val = consult1(S),
		    file:close(S), 
		    {ok, Val};
		{error, Why} ->
		    {error, Why}
    end.

consult1(S) ->
    case io:read(S, '') of
		{ok, Term} -> [Term|consult1(S)];
		eof        -> [];
		Error      -> Error
    end.

unconsult(File, L) ->
    {ok, S} = file:open(File, write),
    lists:foreach(fun(X) -> io:format(S, "~p.~n",[X]) end, L), %% ~n nextline ~p print all params 
    file:close(S).

file_size_and_type(File) ->
    case file:read_file_info(File) of
		{ok, Facts} ->
		    {Facts#file_info.type, Facts#file_info.size};
		_ ->
		    error
    end.

find_files(File) ->
    case filelib:is_dir(File) of
		false -> io:format("~n ~p", [File]);
		true ->  Dir = File,
				 { ok, SubFileList } = file:list_dir(Dir),
				 [ begin SubFileFullName = filename:join([Dir, SubFile]),
				         find_files(SubFileFullName) end
				   || SubFile <- SubFileList ];
		error -> error
    end.








