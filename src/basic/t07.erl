-module(t07).

-compile(export_all).

priority_receive() ->
    receive
		{alarm, X} -> {alarm, X}
	after 0 ->
		receive
		    Any -> Any
		end
    end.