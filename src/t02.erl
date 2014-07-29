-module(t02).

-compile(export_all).

qsort([]) -> [];
qsort([Pivot|T]) ->
	qsort([X || X <- T, X < Pivot])
	++ [Pivot] ++
	qsort([X || X <- T, X >= Pivot]).

filter(F, [H|T]) -> 
	case F(H) of
	   true  -> [H | filter(F, T)];
	   false -> filter(F, T)   
	end;
filter(_, []) -> [].

split_odds_events(L) -> split_odds_events(L, [], []).                       
split_odds_events([H|T], Odds, Event) ->
    case (H rem 2) of
        1 -> split_odds_events(T, [H|Odds], Event);
        0 -> split_odds_events(T, Odds, [H|Event])
    end;
split_odds_events([], Odds, Event) -> {lists:reverse(Odds), lists:reverse(Event)}.  









