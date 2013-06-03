-module(sieve).
-export([takePrims/1]).

ints_from(N) ->
    fun() ->
        [N|ints_from(N+1)]
    end.

take(N,Lazy) ->
    if 
        N == 0 -> [];
        true -> [hd(Lazy()) | take(N-1,tl(Lazy()))]
    end.
	
filter(Pred, Lazy) ->
  fun() -> 
      Bla = Pred(hd(Lazy())), 
      if
        Bla ->
          [hd(Lazy()) | filter(Pred,tl(Lazy()))];
        true ->
          (filter(Pred,tl(Lazy())))()
        end
  end.

sieve(Lazy) ->
  fun() ->
    Head = hd(Lazy()),
    [Head | sieve(filter(fun(X) -> X rem Head /= 0 end, tl(Lazy())))]
  end.

takePrims(N) ->
  take(N, sieve(ints_from(2))).
