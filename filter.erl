-module(filter).
-export([ints/0, take/2, filter/2, takeOdds/1]).

ints() -> ints_from(0).

ints_from(N) ->
    fun() ->
        [N|ints_from(N+1)]
    end.

take(N,Lazy) ->
    if 
        N == 0 -> [];
        true -> [hd(Lazy()) | take(N-1,tl(Lazy()))]
    end.

filter(Pred, Lazy) ->
  fun() -> 
      Bla = Pred(hd(Lazy())), 
      if
        Bla ->
          [hd(Lazy()) | filter(Pred,tl(Lazy()))];
        true ->
          (filter(Pred,tl(Lazy())))()
        end
  end.

takeOdds(N) ->
  take(N, filter(fun(X) -> X rem 2 /= 0 end, ints())).
