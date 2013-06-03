-module(ring).
-export([go_ring/3, init/1]).


go_ring(N, M, Msg) ->
  Pid = spawn(ring,init,[N]),
  send(Pid, N, M, Msg).

init(0) -> 
  ok;
init(N) ->
  Pid = spawn(ring,init,[N-1]),
  listen(Pid).

listen(Pid) ->
  receive
    {0, _} ->
      listen(Pid);
    {M, Msg} ->
      io:format("~w: ~s~n", [M, Msg]),
      Pid ! {M - 1, Msg},
      listen(Pid);
    quit ->
      Pid ! quit
  end.

send(Pid, _, 0, _) ->
  timer:sleep(500),
  Pid ! quit;
send(Pid, N, M, Msg) ->
  Pid ! {N, Msg},
  send(Pid, N, M - 1, Msg).
