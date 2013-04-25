-module(remdup).
-export([remdup/1]).

remdup([]) -> [];
remdup([X|XS]) -> [X | remdup([Y || Y <- XS, X =/= Y])]. 

% Erlang erlaubt verschiedenste Lösungsansätze. Die listcomprehension kann durch eine rekursive Funktion ersetzt werden, oder durch ein reduce und lambda.
