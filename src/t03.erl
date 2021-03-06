-module(t03).

-compile(export_all).

generate_exception(1) -> ok;
generate_exception(2) -> throw(throw_msg);
generate_exception(3) -> exit(exit_msg);
generate_exception(4) -> erlang:error(error_msg).

catcher(N) ->
   try generate_exception(N) of   
       Val -> {N, success, Val}     
   catch
       throw:X -> {N, fail, X};     
       exit :X -> {N, fail, X};
       error:X -> {N, fail, X}
   end.

demo1() -> [catcher(I) || I <- [1,2,3,4]].

demo2() -> [{I, (catch generate_exception(I))} || I <- [1,2,3,4]].