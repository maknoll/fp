-module(sync).
-export([do/4]).

do(F1, A1, F2, A2) ->
  P = self(),
  spawn(fun() -> worker(P, F1, A1) end),
  spawn(fun() -> worker(P, F2, A2) end),
  receive
    {_, R1} ->
      receive
        {_, R2} ->
          R1 * R2
      end
  end.

worker(P, F, A) ->
  P ! {self(), apply(F, A)}.

% 7> sync:do(fun(X, Y) -> X + Y end, [1, 5], fun(X, Y) -> X + Y end, [3, 4]).
% 42
