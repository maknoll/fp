-module(worker).
-export([do/2]).

do(F, A) ->
  P = self(),
  spawn(fun() -> worker(P, F, A) end),
  receive
     {_, R} ->
       R
  end.

worker(P, F, A) ->
  P ! {self(), apply(F, A)}.

%2> worker:do(fun(X, Y) -> X + Y end, [21, 21]).
%42
