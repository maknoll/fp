-module(branch).
-export([go/1, loop/2]).

go(Lim) -> 
  Root = spawn(branch, loop, [1, Lim]),
  io:format("process ~w created at toplevel.~n", [Root]).

loop(Lim, Lim) ->
    receive
	{createdBy, Parentpid} ->
        io:format("process ~w created by ~w at count ~w.~n",
		      [self(),Parentpid,Lim]),
	    Parentpid ! {confirmed, self()}
    end;

loop(Count, Lim) when Count =< Lim -> 
    Count1 = Count + 1,
    Child1 = spawn(branch, loop, [Count1, Lim]), 
    Child2 = spawn(branch, loop, [Count1, Lim]),
    Child1 ! {createdBy, self()},
    Child2 ! {createdBy, self()}, 
    receive
	{createdBy, Parentpid} ->
	    io:format("process ~w created by ~w at count ~w.~n",
		      [self(),Parentpid,Count]),		   
	    Parentpid!{confirmed, self()}
    end,
    receive 
	{confirmed, Childpid1} ->
	    io:format("process ~w confirmed creation to ~w at count ~w.~n",
		      [Childpid1,self(),Count])
    end,
    receive 
	{confirmed, Childpid2} ->
	    io:format("process ~w confirmed creation to ~w at count ~w.~n",
		      [Childpid2,self(),Count])
    end.
