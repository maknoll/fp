-module(scalarProduct).
-export([scalarProduct/2]).

scalarProduct([],[]) -> 0;
scalarProduct([X|XS], [Y|YS]) -> X * Y + scalarProduct(XS,YS).
