-module(bank).
-export([go_bank/1, account/1, user/1]).

go_bank(N) ->
  Pid = spawn(bank,account,[N]),
  spawn(bank, user, [Pid]),
  spawn(bank, user, [Pid]).

account(N) ->
  receive
    {From, Request} ->
      if
        N >= 0 ->
          From ! {self(), true},
          io:format("~w received ~n", [Request]),
          account(N - Request);
        N < 0 ->
          From ! {self(), false},
          io:format("~w denied ~n", [Request]),
          account(N)
      end
  end.

user(Pid) ->
  Pid ! {self(), random:uniform(50)},
  receive
    {_, true} ->
      timer:sleep(random:uniform(100)),
      user(Pid);
    {_, false} ->
      io:format("~w: empty~n", [self()])
  end.
