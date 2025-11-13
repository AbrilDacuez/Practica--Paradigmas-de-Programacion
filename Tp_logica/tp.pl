cant([], 0).
cant([_|R], N) :-
	cant(R, N1),
	N is N1 + 1.

minimo([P], P).
minimo([P|R], P) :-
	minimo(R, M),
	P < M.
minimo([P|R], M) :-
	minimo(R, M),
	P >= M.

% Escriba una función que calcule los n primeros números primos y los devuelva en una lista.

% IMPORTANTE ----->>> Acomodarlo en funcional primero

% esPrimo(N) :-
% 	N = 2.
% esPrimo(N) :-
% 	N = 3.

% probarImpares(_, I, Lim, true) :-
% 	I > Lim,
% 	!.
% probarImpares(N, I, _, false) :-
% 	N mod I =:= 0,
% 	!.
% probarImpares(N, I, Lim, R) :-
% 	In is I + 2,
% 	probarImpares(N, In, Lim, R).
