-module(t4).

-compile(export_all).

-include("records.hrl").

%% 二进制更加省内存
%% <<1,2,3,4,5>>.
%% <<"hello">>.

%% list_to_binary([1, 2, <<3>>, [4, <<5, 6>>]]).
%% <<1,2,3,4,5,6>>

%% split_binary(<<1,2,3,4,5,6>>, 2). 
%% {<<1,2>>,<<3,4,5,6>>}

%% term_to_binary() binary_to_term() 用于文件存储网络传输 序列化

%% Red = 2.
%% Green = 61.
%% Blue = 20.
%% Mem = <<Red:5, Green:6, Blue:5>>.
%% <<R:5, G:6, B:5>> = Mem.

%% 字符串不是一个真正的类型， 由一串整数序列来表示

%% func([{tag, A, B} = Z | T]) -> 





