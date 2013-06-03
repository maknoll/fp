-module(map).
-export([ints/0,take/2,map/2,takeDoubledInts/1]).

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

map(F, Lazy) ->
  fun() -> [F(hd(Lazy())) | map(F, tl(Lazy()))] end.

takeDoubledInts(N) ->
  take(N, map(fun(A) -> 2 * A end, ints())).
