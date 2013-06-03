-module(flip).
-export([flip/1, flipc/1]).

flip(F) -> fun(X, Y) -> F(Y, X) end.

flipc(F) -> fun(X) -> fun(Y) -> F(Y, X) end end.

%> Minus = fun (A,B) -> A - B end.
%> Minus(5, 2).
%3
%> (flip:flip(Minus))(5, 2).
%-3
%> (flip:flipc(Minus))(5, 2).
%** exception error: flip:'-flipc/1-fun-1-'/1 called with two arguments
%> ((flip:flipc(Minus))(5))(2).
