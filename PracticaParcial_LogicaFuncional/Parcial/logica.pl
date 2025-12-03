min([], 0).
min([X], X).
min([X|R], X) :-
	min(R, X1),
	X =< X1.
min([X|R], X1) :-
	min(R, X1),
	X > X1.

esCrec([]).
esCrec([_]).
esCrec([X|R]) :-
	min(R, R1),
	X < R1,
	esCrec(R).

soloCrec([], []).
soloCrec([X], X).
soloCrec([X|R], [X|R1]) :-
	esCrec(X),
	soloCrec(R, R1).
soloCrec([_|R], R1) :-
	soloCrec(R, R1).

linealiza([], []).
linealiza([X|R], Res) :-
	is_list(X),
	linealiza(X, R1),
	linealiza(R, R2),
	append(R1, R2, Res).
linealiza([X|R], [X|R1]) :-
	not(is_list(X)),
	linealiza(R, R1).

eliminarElm([], _, []).
eliminarElm([X|R], Elm, R) :-
	X == Elm.
eliminarElm([X|R], Elm, [X|R1]) :-
	X \== Elm,
	eliminarElm(R, Elm, R1).

ordenar([], []).
ordenar([X], [X]).
ordenar(L, [R1|R3]) :-
	min(L, R1),
	eliminarElm(L, R1, R2),
	ordenar(R2, R3).

resultado([], []).
resultado(L, R3) :-
	soloCrec(L, R1),
	linealiza(R1, R2),
	ordenar(R2, R3).

%-----------------------------------------------------------------------------
% Parcial 2
ordenar2([], []).

ordenar2([X|XS], Res) :-
	is_list(X),
	ordenar2(XS, X1),
	ordenar2(X, X2),
	append(X1, [X2], Res).

ordenar2([X|XS], [X|X1]) :-
	not(is_list(X)),
	ordenar2(XS, X1).

%-------------------------------------------------------------------------
%Parcial3
eliminarNivelesSuperiores([], []).
eliminarNivelesSuperiores([X|XS], Res) :-
	is_list(X),
	eliminarNivelesSuperiores(XS, Res).
eliminarNivelesSuperiores([X|XS], [X|R]) :-
	not(is_list(X)),
	eliminarNivelesSuperiores(XS, R).
eliminarNivelSuperior([], []).
eliminarNivelSuperior([X], [R]) :-
	eliminarNivelesSuperiores(X, R).
eliminarNivelSuperior([X|XS], [R1|R2]) :-
	eliminarNivelesSuperiores(X, R1),
	eliminarNivelSuperior(XS, R2).

contiene1([H|_], X) :-
	H == X.
contiene1([_|T], X) :-
	contiene1(T, X).

contiene2(_, []).
contiene2(L, [X|XS]) :-
	contiene1(L, X),
	contiene2(L, XS).

% contiene3(+ListaDeListas, +ListaElementos, -Sublistas)
% Devuelve en Sublistas las sublistas de ListaDeListas que contienen todos
% los elementos de ListaElementos (sin consumir ocurrencias).
contiene3([], _, []).
contiene3([X|XS], Ys, [X|R]) :-
	contiene2(X, Ys),
	contiene3(XS, Ys, R).
contiene3([_|XS], Ys, R) :-
	contiene3(XS, Ys, R).

contiene([X|XS], [Y|YS], R) :-
	eliminarNivelSuperior([X|XS], L),
	contiene3(L, [Y|YS], R).

%parcial4

sumanivel([], _, 0).

sumanivel([X|XS], 1, R) :-
	number(X),
	sumanivel(XS, 1, R1),
	R is X + R1.

sumanivel([X|XS], N, R) :-
	is_list(X),
	N1 is N - 1,
	sumanivel(X, N1, R1),
	sumanivel(XS, N, R2),
	R is R1 + R2.

sumanivel([_|XS], N, R) :-
	sumanivel(XS, N, R).

%Parcial 5
quitarPosP([], _, _, []).

quitarPosP([X|XS], P, I, [X|R]) :-
	I < P,
	I2 is I + 1,
	quitarPosP(XS, P, I2, R).

quitarPosP([_|XS], P, P, XS).

elimPos([], _, []).

elimPos([X|XS], P, [R1|R2]) :-
	quitarPosP(X, P, 1, R1),
	elimPos(XS, P, R2).

%parcial6
profundidad([], 1).
profundidad([X|XS], R) :-
	profundidad(X, R1),
	profundidad(XS, R2),
	R1 >= R2,
	R is R1 + 1.
profundidad([X|XS], R2) :-
	profundidad(X, R1),
	profundidad(XS, R2),
	not(R1 >= R2).
profundidad(X, 0) :-
	number(X).

sumaNivel([], _, 0).
sumaNivel([X|XS], 1, R) :-
	number(X),
	sumaNivel(XS, 1, R1),
	R is X + R1.
sumaNivel([X|XS], 1, R) :-
	not(number(X)),
	sumaNivel(XS, 1, R).
sumaNivel([X|XS], N, R) :-
	is_list(X),
	N1 is N - 1,
	sumaNivel(X, N1, R1),
	sumaNivel(XS, N, R2),
	R is R1 + R2.
sumaNivel([X|XS], N, R) :-
	not(is_list(X)),
	sumaNivel(XS, N, R).

generarLista([], _, []).
generarLista([X|XS], I, []) :-
	profundidad([X|XS], R1),
	I > R1.
generarLista([X|XS], I, [R2|R3]) :-
	profundidad([X|XS], R1),
	not(I > R1),
	sumaNivel([X|XS], I, R2),
	I2 is I + 1,
	generarLista([X|XS], I2, R3).

result(L, R) :-
	generarLista(L, 1, R).

%Parcial7
esMult(I, N) :-
	R1 is mod(I, N),
	R1 == 0.

devolverPos([], _, []).
devolverPos([X], N, I, X) :-
	R1 is mod(I, N),
	R1 == 0. 
devolverPos([_], N, I, []) :-
	R1 is mod(I, N),
	not(R1 == 0). 
devolverPos([X|XS], N, I, [X|R]) :-
	esMult(I, N),
	I2 is I + 1,
	devolverPos(XS, N, I2, R).
devolverPos([_|XS], N, I, R) :-
	not(esMult(I, N)),
	I2 is I + 1,
	devolverPos(XS, N, I2, R).

result(L, N, R) :-
	devolverPos(L, N, 1, R).


%Parcial8
perteneceSecuencia(X, [X, _], _).
perteneceSecuencia(L, [X, Y], _) :-
	X1 is X + Y,
	L == X1.
perteneceSecuencia(L, [X, Y], I) :-
	X1 is Y*I + X,
	L == X1.
	
perteneceSecuencia(L, [X, Y], I) :-
	L > I,
	I2 is I + 1,
	perteneceSecuencia(L, [X, Y], I2).

perteneceSecuencia2([], _, []).
perteneceSecuencia2([L|XS], [X, Y], [L|R]) :-
	perteneceSecuencia(L, [X, Y], 0),
	perteneceSecuencia2(XS, [X, Y], R).
perteneceSecuencia2([_|XS], [X, Y], R) :-
	perteneceSecuencia2(XS, [X, Y], R).

perteneceSecuencia3([], _, []).
perteneceSecuencia3(_, [], []).
perteneceSecuencia3(L, [P|R], [R1|R2]) :-
	perteneceSecuencia2(L, P, R1),
	perteneceSecuencia3(L, R, R2).

%Parcial 9

cantL([], 0).
cantL([_|XS], R) :-
	cantL(XS, R1),
	R is 1 + R1.

suma([], 0).
suma([X|XS], R) :-
	suma(XS, R1),
	R is X + R1.

promedio([], 0).
promedio(L, R) :-
	suma(L, R1),
	cantL(L, R2),
	R is R1/R2.

legajo([X|_], X).
promedio2([], 0).
promedio2([_, X], R) :-
	promedio(X, R1),
	R is R1.

listaPromedios([], []).
listaPromedios([X|R], R5) :-
	legajo(X, R1),
	promedio2(X, R2),
	R3 = [R1, R2],
	listaPromedios(R, R4),
	R5 = [R3|R4].

segundo([_, Y], Y).
primero([X, _], X).

max([], [0, 0]).
max([[X, Y]], [X, Y]).
max([[X, Y]|XS], [X, Y]) :-
	max(XS, R1),
	segundo(R1, R2),
	Y >= R2.

max([[_, Y]|XS], R1) :-
	max(XS, R1),
	segundo(R1, R2),
	Y < R2.

legajo_mayor_promedio(L, R3) :-
	listaPromedios(L, R1),
	max(R1, R2),
	primero(R2, R3).




