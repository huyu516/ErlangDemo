-module(t01).

-compile(export_all).

%% Area = fun({rectangle, Width, Height}) -> Width * Height;
%%           ({circle, R}) -> 3.14 * R * R end.  

%% Mult = fun(T) -> ( fun(N) -> N * T end ) end.

for(Max, Max, Fun) -> [Fun(Max)];   
for(I, Max, Fun)   -> [Fun(I) | for(I+1, Max, Fun)].

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

					







