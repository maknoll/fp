-module(pyTriple).
-export([pyTriple/1, ppT/1]).

%pyTriple n = [(x,y,z)|x<-[2 .. n], y<-[x+1 .. n], z<- [y+1 ..n], x*x + y*y == z*z]

pyTriple(N) -> [{X, Y, Z} || X <- lists:seq(2, N), Y <- lists:seq(X + 1, N), Z <- lists:seq(Y + 1, N), X * X + Y * Y == Z * Z ].

% b) Ernsthaft? Der Faktor kürzt sich raus... qed

%ppT n = sieve (pyTriple n) where 
%	sieve [] = []
%	sieve (x:xs) = x:sieve [i|i<-xs, check x i]
%	check (a,b,c) (d,e,f) = not (div d a == div e b && div e b == div f c && mod d a == 0 && mod e b ==  0 && mod f c == 0) 

check({A,B,C},{D,E,F}) -> not ((D div A == E div B) and (E div B == F div C) and (D rem A == 0) and (E rem B == 0) and (F rem C == 0)). 

sieve([]) -> [];
sieve([H|T]) -> [H | sieve([X || X <- T, check(H, X)])].
ppT(N) -> sieve(pyTriple(N)).

%> pyTriple:ppT(100).                
%[{3,4,5},
% {5,12,13},
% {7,24,25},
% {8,15,17},
% {9,40,41},
% {11,60,61},
% {12,35,37},
% {13,84,85},
% {16,63,65},
% {20,21,29},
% {28,45,53},
% {33,56,65},
% {36,77,85},
% {39,80,89},
% {48,55,73},
% {65,72,97}]

