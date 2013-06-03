-module(mergesort).
-export([mergesort/1, worker/2, split/3, merge/2]).

mergesort([X]) ->
  [X];
mergesort(List) ->
  io:format("~w ~n", [List]),
  {Left, Right} = split(List, [], []),
  spawn(mergesort, worker, [self(), Left]),
  spawn(mergesort, worker, [self(), Right]),
  receive
    Left ->
      receive
        Right ->
          merge(Left,Right)
      end
  end.

worker(Pid, List) ->
  Pid ! mergesort(List).

split([], Left, Right) ->
  {Left, Right};
split([Head|Tail], Left, Right) ->
  split(Tail, Right ++ [Head], Left).

merge(Left, []) ->
  Left;
merge([], Right) ->
  Right;
merge([HL|Left], [HR|Right]) ->
  if
    HL < HR ->
      [HL|merge(Left, [HR|Right])];
    true ->
      [HR|merge([HL|Left], Right)]
  end.
