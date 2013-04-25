-module(reverse).
-export([reverse/1]).

reverse([]) -> [];
reverse([X|XS]) -> reverse(XS) ++ [X]. 
