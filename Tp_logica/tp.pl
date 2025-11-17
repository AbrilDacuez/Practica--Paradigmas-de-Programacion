% Nivel 2
% Ej 5
cant([], 0).
cant([_|R], N) :-
	cant(R, N1),
	N is N1 + 1.

% Ej 16
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

% Ej 8
eliminarIesimo([], _, []).
eliminarIesimo([_|X], N, Res) :-
	N = 1,
	Res = X.
eliminarIesimo([L|XS], N, [L|Res]) :-
	N > 1,
	N1 is N - 1,
	eliminarIesimo(XS, N1, Res).

% Ej 6
sumaLista([], 0).
sumaLista([P|R], S) :-
	sumaLista(R, S1),
	S is P + S1.

% Ej 10
mediaLista([], 0).
mediaLista(L, M) :-
	cant(L, C),
	sumaLista(L, S),
	M is S/C.

% Ej 11
agregar(L, X, P, Res):-
	P = 1,
	Res = [X|L].
agregar([L|R], X, P, [L|Res]) :-
	P > 1,
	P1 is P - 1,
	agregar(R, X, P1, Res).

% -------------------------------------------
