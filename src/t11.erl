-module(t11).

-compile(export_all).

nano_get_url() ->
    nano_get_url("www.baidu.com").

nano_get_url(Host) ->
    {ok, Socket} = gen_tcp:connect(Host, 80, [binary, {packet, 0}]),
    ok = gen_tcp:send(Socket, "GET / HTTP/1.0\r\n\r\n"),  
    receive_data(Socket, []).

receive_data(Socket, Result) ->
    receive
		{tcp, Socket,  Data} -> receive_data(Socket, [Data|Result]);
		{tcp_closed, Socket} -> list_to_binary(lists:reverse(Result))
    end.

tcp_client(Str) ->
    {ok, Socket} = gen_tcp:connect("localhost", 2345, [binary, {packet, 4}]),
    ok = gen_tcp:send(Socket, term_to_binary(Str)),
    receive
		{tcp, Socket, Bin} ->
		    Val = binary_to_term(Bin),
		    io:format("server's reply = ~p~n",[Val]),
		    gen_tcp:close(Socket)
    end.

tcp_server() ->
    {ok, Listen} = gen_tcp:listen(2345, [binary, {packet, 4}, {reuseaddr, true}, {active, true}]),
    {ok, Socket} = gen_tcp:accept(Listen),  
    gen_tcp:close(Listen),  
    tcp_server_loop(Socket).

tcp_server_loop(Socket) ->
    receive
		{tcp, Socket, Bin} ->
		    Request = binary_to_term(Bin),  
		    Reply = "u send :" ++ Request,
		    gen_tcp:send(Socket, term_to_binary(Reply)),  
		    tcp_server_loop(Socket);
		{tcp_closed, Socket} ->
		    io:format("Server socket closed~n")
    end.

udp_server() ->
    {ok, Socket} = gen_udp:open(2000, [binary]),
    udp_server_loop(Socket).

udp_server_loop(Socket) ->
    receive
		{udp, Socket, Host, Port, Bin} ->
		    Request = binary_to_term(Bin),
		    Reply = "u send :" ++ Request,
		    gen_udp:send(Socket, Host, Port, term_to_binary(Reply)),
		    udp_server_loop(Socket)
    end.
    
udp_client(N) ->
    {ok, Socket} = gen_udp:open(0, [binary]),
    ok = gen_udp:send(Socket, "localhost", 2000, term_to_binary(N)),
    receive
		{udp, Socket, _, _, Bin} ->
			Val = binary_to_term(Bin),
		    io:format("server's reply = ~p~n",[Val]),
		    gen_udp:close(Socket)
    end.


    




	







