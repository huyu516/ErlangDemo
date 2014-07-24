-module(t1).

-compile(export_all).

%% Area = fun({rectangle, Width, Height}) -> Width * Height;
%%           ({circle, R}) -> 3.14 * R * R end.  

%% 返回fun的函数(闭包)
%% Mult = fun(T) -> ( fun(N) -> N * T end ) end.

%% MakeTest = fun(L) -> ( fun(X) -> lists:member(X, L) end) end. 
%% IsFruit = MakeTest([apple, orange]).
%% lists:filter(IsFruit, [blue, yellow, apple]).

for(Max, Max, Fun) -> [Fun(Max)];
for(I, Max, Fun)   -> [Fun(I) | for(I+1, Max, Fun)].
%% t1:for(1, 10, fun(X) -> X end).

%% 第一个子句匹配非空，第二个子句匹配空，两个互不干扰 
sum([T|H]) -> T + sum(H);
sum([]) -> 0.

map(F, [H|T]) -> [F(H) | map(F, T)];
map(_, []) -> [].

cost(orange) -> 5; 
cost(apple) -> 10; 
cost(pears) -> 10.

total(L) -> sum([cost(What) * N || {What, N} <- L]).   
%% total(L) -> sum(lists:map( fun({What, N}) -> cost(What) * N end, L) ).
%% total([{What, N}|T]) -> cost(What) * N + total(T); 
%% total([]) -> 0.    

%% t1:total([{orange, 2}, {apple, 5}, {pears, 10}]). 





