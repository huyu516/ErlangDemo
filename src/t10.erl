-module(t10).

-import(lists, [foreach/2]).

-compile(export_all).

-include_lib("stdlib/include/qlc.hrl").

-record(user, {user_id, user_name, dept_id}).
-record(dept, {dept_id, dept_name}).

init_db() ->
    mnesia:create_schema([node()]),
    mnesia:start(),
    mnesia:create_table(user, [{attributes, record_info(fields, user)}]),
    mnesia:create_table(dept, [{attributes, record_info(fields, dept)}]),
    mnesia:stop().

start() ->
    mnesia:start(),
    mnesia:wait_for_tables([user, dept], 20000).

init_data() ->
    mnesia:clear_table(user),
    mnesia:clear_table(dept),
	Data = fun() -> 
			  [{user, u1,  tom,  d1},
		       {user, u2, andy,  d1},
		       {dept, d1,  dep}] 
		   end,
    Tx = fun() ->
			foreach(fun mnesia:write/1, Data())
		 end,
    mnesia:transaction(Tx).

do(Q) ->
    Tx = fun() -> qlc:e(Q) end,
    {atomic, Val} = mnesia:transaction(Tx),
    Val.

findUserById(Id) ->
    do(qlc:q([ X || X <- mnesia:table(user), X#user.user_id =:= Id ])).

findUserById1(User_id) ->
    Tx = fun() -> 
		    mnesia:read({user, User_id}) 
		 end,
    {atomic, Val} = mnesia:transaction(Tx),
	Val.

findUserAndDept() ->
    do(qlc:q([ { X#user.user_name, Y#dept.dept_name} 
			   || X <- mnesia:table(user), 
				  Y <- mnesia:table(dept), 
				  X#user.dept_id =:= Y#dept.dept_id ])).

addUser(User_id, User_name, Dept_id) ->
    User = #user{user_id=User_id, user_name=User_name, dept_id=Dept_id},
    Tx = fun() ->
			mnesia:write(User)
	     end,
    mnesia:transaction(Tx).

delUser(User_id) ->
    Oid = {user, User_id},
    Tx = fun() ->
		    mnesia:delete(Oid)
	     end,
    mnesia:transaction(Tx).

%% mnesia:abort(oranges)

