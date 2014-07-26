
-module(lib_find).

-compile(export_all).

-include_lib("kernel/include/file.hrl").

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






