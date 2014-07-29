-module(t09).

-compile(export_all).

-include_lib("kernel/include/file.hrl").

%% file:read_file_info(File)                -> -record
%% file:list_dir(".").
%% file:copy(Source, Destination).
%% file:delete(File).

%% filelib:file_size(File).
%% filelib:is_dir(X).

%% io:format(fd, "~p.~n", [Content]).      -> write line
%% io:get_line(fd, "").                    -> read line    
%% io:read(fd, "").                        -> one term
%% file:consult(File).                     -> all term
%% file:read_file(File).                   -> all to binary  
%% file:write_file(File, binary).          -> all to binary  
%% file:pwrite(fd, offset, binary).        -> random write binary
%% file:pread(fd, offset, size).           -> random read  binary

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
    lists:foreach(fun(X) -> io:format(S, "~p.~n",[X]) end, L),
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








