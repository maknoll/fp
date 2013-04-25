-module(removeOdd).
-export([removeOdd/1]).

removeOdd(XS) -> [X || X <- XS, X rem 2 =:= 0]. 
