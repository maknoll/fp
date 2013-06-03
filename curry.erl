-module(curry).
-export([curry3/1, replace/3, replaceLL/3]).

curry3(F) -> fun (X, Y) -> fun (Z) -> F(X, Y, Z) end end.

replace(_, _, []) -> []; 
replace(Elem, ElemNeu, [Elem|Liste]) -> [ElemNeu | replace(Elem, ElemNeu, Liste)];
replace(Elem, ElemNeu, [Else|Liste]) -> [Else | replace(Elem, ElemNeu, Liste)].


replaceLL(Elem, ElemNeu, Liste) -> 
  lists:map((curry3(fun curry:replace/3))(Elem, ElemNeu), Liste).
