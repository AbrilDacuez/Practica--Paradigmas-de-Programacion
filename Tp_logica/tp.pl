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

% Nivel 3

% Ej 20
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

% Ej 22
frecuencia([], _, 0).
frecuencia([P|R], X, Res) :-
	P = X,
	frecuencia(R, X, Res1),
	Res is Res1 + 1.
frecuencia([P|R], X, Res) :-
	P \= X,
	frecuencia(R, X, Res).

moda([L], L).
moda([L|R], Res) :-
	frecuencia([L|R], L, F),
		moda(R, M1),
	frecuencia([L|R], M1, F2),
	F > F2,
	Res is L.
moda([L|R], Res):-
	frecuencia([L|R], L, F),
		moda(R, M1),
	frecuencia([L|R], M1, F2),
	F2 >= F,
		moda(R, Res).

% -------------------------------------------

% Nivel 5

% Ej 45 minSort
elimElemento([], _, []).
elimElemento([L|R], X, Res) :-
	L = X,
	Res = R.
elimElemento([L|R], X, [L|Res]) :-
	L \= X,
	elimElemento(R, X, Res).

minSort([], []).
minSort([L], [L]).
minSort(L, Res) :-
	minimo(L, M1),
	elimElemento(L, M1, L1),
	minSort(L1, Res1),
	Res = [M1|Res1].

% Ej 46
% Escriba una función que tome una lista de números y un número N, y devuelva la lista resultado de eliminar los N números mayores de la lista de entrada.

elimMayores([], _, []).
elimMayores([L], N, Res) :-
	L > N,
	Res = [].
elimMayores([L], N, Res) :-
	N >= L,
	Res = [L].
elimMayores([L|R], N, Res) :-
	N >= L,
	elimMayores(R, N, Res2),
	Res = [L|Res2].
elimMayores([L|R], N, Res) :-
	L > N,
	elimMayores(R, N, Res2),
	Res = Res2.
