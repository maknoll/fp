-module(database).
-export([server/1, run/0, set/3, get/2]).

run() ->
  spawn(database, server, [orddict:new()]).

server(Dict) ->
  receive
    {From, set, Key, Value} ->
      From ! {self(), orddict:is_key(Key, Dict)},
      server(orddict:store(Key, Value, Dict));
    {From, get, Key} ->
      From ! {self(), orddict:fetch(Key, Dict)}
  end.

set(Key, Value, Pid) ->
  Pid ! {self(), set, Key, Value},
  receive
    {_, Success} ->
      Success
  end.

get(Key, Pid) ->
  Pid ! {self(), get, Key},
  receive
    {_, Value} ->
      Value
  end.
