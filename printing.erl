-module(printing).
-export([go/0, stop/0, print/1, init/0]).

init() ->
  receive
    String ->
      io:format("~s~n", [String])
  end,
  init().

go() ->
  register(?MODULE, Pid=spawn(?MODULE, init, [])),
  Pid.

print(String) ->
  ?MODULE ! String.

stop() ->
  exit(whereis(?MODULE), die).


%Eshell V5.9.2  (abort with ^G)
%1> c(printing).
%{ok,printing}
%2> printing:go().
%<0.38.0>
%3> printing:print("Hallo Welt").
%Hallo Welt
%"Hallo Welt"
%4> printing:stop().
%true
%5>
