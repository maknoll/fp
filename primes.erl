-module(primes).
-export([go/3, count/2, sieve/1, init/4]).

go(From, To, Min) ->
  init(From, To, Min, self()),
  receive
    Result ->
      Result
  end.

init(From, To, Min, Pid) ->
  if
    To - From =< Min ->
      Pid ! count(From, To);
    true ->
      Middle = From + (length(lists:seq(From,To)) div 2),
      spawn(primes,init,[From, Middle, Min, self()]),
      spawn(primes,init,[Middle, To, Min, self()]),
      receive
        R1 ->
          receive
            R2 ->
              R1 + R2
          end
      end
  end.

sieve([]) -> [];
sieve([Head|Tail]) ->
  [Head | sieve([X || X <- Tail, X rem Head /= 0])].

count(From, To) ->
  Numbers = sets:from_list(lists:seq(From,To)),
  Primes = sets:from_list(sieve(lists:seq(2,To))),
  length(sets:to_list(sets:intersection(Numbers, Primes))).


% Die Performance verschlechtert sich, da das Sieb für jeden Knoten neu berechnet werden muss

%Eshell V5.9.2  (abort with ^G)
%1> c(primes).
%{ok,primes}
%2> primes:go(10000,50000,40000).
%3904
%3> primes:go(10000,50000,20000).
%3904
%4> primes:go(10000,50000,10000).
%3904
%5> primes:go(10000,50000,5000).
%3904
%6> primes:go(10000,50000,4000).
%3904
%7> primes:go(10000,50000,3000).
%3904
%8> 
