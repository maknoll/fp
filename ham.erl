-module(ham).
-export([hamming/0,take/2]).

ints() -> ints_from(1).

ints_from(N) ->
    fun() ->
        [N|ints_from(N+1)]
    end.

take(N,Lazy) ->
    if 
        N == 0 -> [];
        true -> [hd(Lazy()) | take(N-1,tl(Lazy()))]
    end.

map(F, Lazy) ->
    fun() ->
        [ F(hd(Lazy())) | map(F, tl(Lazy())) ]
    end.

scaleStream(N, Lazy) ->
  map(fun(Elem) -> N * Elem end, Lazy).

mergeStream(Lazy1,Lazy2) ->
  fun() ->
      Head1 = hd(Lazy1()),
      Head2 = hd(Lazy2()),
      if
        Head1 < Head2 ->
          [Head1 | mergeStream(tl(Lazy1()),Lazy2)];
        Head1 > Head2 ->
          [Head2 | mergeStream(Lazy1,tl(Lazy2()))];
        true ->
          [Head1 | mergeStream(tl(Lazy1()),tl(Lazy2()))]
      end
  end.

hamming() -> 
  A = mergeStream(scaleStream(2, hamming()),scaleStream(3, hamming())),
  fun () -> 
      [1 | mergeStream(A, scaleStream(5, hamming()))]
  end.

