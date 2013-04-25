-module(ackermann).
-export([ackermann/2]).

ackermann(0, M) -> M + 1;
ackermann(N, 0) -> ackermann(N - 1, 1);
ackermann(N, M) -> ackermann(N - 1, ackermann(N, M - 1)).

% Die Funktion wächst abhängig von M sehr stark exponentiell, für kleine M wächst sie abhängig von N erst linear, dann auch stark exponentiell.
