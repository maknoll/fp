-module(zipWith).
-export([fibs/1]).

take(N,Lazy) ->
    if 
        N == 0 -> [];
        true -> [hd(Lazy()) | take(N-1,tl(Lazy()))]
    end.

zipWith(F, Lazy1, Lazy2) ->
  fun() -> [F(hd(Lazy1()), hd(Lazy2())) | zipWith(F, tl(Lazy1()), tl(Lazy2()))] end.

fibgen(A, B) ->
  fun() -> [A | fibgen(B, A + B)] end.

fibs(N) -> take(N, zipWith(fun(A, B) -> A + B end, fibgen(0,1), fibgen(0,0))).
