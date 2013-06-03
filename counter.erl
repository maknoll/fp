-module(counter).
-export([start/1, stop/1, increment/1, decrement/1, show/2]).

increment(P) ->
  P ! inc.

decrement(P) ->
  P ! dec.

% merkwuerdige parameterzahl in aufgabenstellung
show(P, S) ->
  P ! {S, show},
  receive
    {_, N} ->
      N
  end.

stop(P) ->
  P ! terminate.

start(N) ->
  spawn(fun() -> counter(N) end).

counter(N) ->
  receive
    inc ->
      counter(N + 1);
    dec ->
      counter(N - 1);
    {S, show} ->
      S ! {self(), N},
      counter(N);
    terminate ->
      ok
  end.

% 1> c(counter).
% {ok,counter}
% 2> P = counter:start(5).
% <0.38.0>
% 3> counter:show(P, self()).
% 5
% 4> counter:increment(P).
% inc
% 5> counter:show(P, self()).
% 6
% 6> counter:decrement(P).   
% dec
% 7> counter:show(P, self()).
% 5
% 8> counter:stop(P).        
% terminate
