  % Parcial 02/12/2024
  % ejercicio 1: escriba una funcion que reciba una lista sin sublistas L y un numero N y devuelva una lista con los elementos de L
  % que estan en las posiciones multiplos de N.
cant([], 0).
cant([_|R], Res) :-
	cant(R, Res2),
	Res is 1 + Res2.

mult([], _, []).
mult([L|R], N, [L|Res2]) :-
	cant([L|R], C),
	X is C mod N,
	X = 0,
	mult(R, N, Res2).
    % Res = [L|Res2].

mult([L|R], N, Res) :-
	cant([L|R], C),
	X is C mod N,
	X \= 0,
	mult(R, N, Res).

  % Ejercicio 2: Escriba una funcion que, dada una lista con sublistas L, devuelva una lista donde el iésimo elemento representa la sumatoria de los números contenidos en nivel i de profundidad de L. Si no hay elementos numéricos en un nivel específico, ese nivel tendrá valor 0 en la lista resultante.
  %  Ej L=[1,[2,3],[[4,5],6],[7,[8,[9]]]] -> Res [1,18,17,9]
  %  Nivel 1: 1
  %  Nivel 2: 2+3+6+7 = 18
  %  Nivel 3: 4+5+8 = 17
  %  Nivel 4: 9

sumNivel([], 0).
sumNivel([P|R], Res) :-
	is_list(P),
	sumNivel(R, Res).
sumNivel([P|R], Res) :-
	sumNivel(R, Res2),
	Res is P + Res2.
	
elmNivel([], []).
elmNivel([P|R], [P|Res2]) :-
	is_list(P),
	elmNivel(R, Res2).
elmNivel([_|R], Res) :-
	elmNivel(R, Res).

linNivel([], []).
linNivel([P|R], Res) :-
	is_list(P),
	linNivel(R, Res2),
	append(P, Res2, Res).
linNivel([P|R], [P|Res2]) :-
	linNivel(R, Res2).

lisSumIes([], []).
lisSumIes(L, [S|Res2]) :-
	sumNivel(L, S),
	elmNivel(L, N),
	linNivel(N, Lin),
	lisSumIes(Lin, Res2).

  % ----------------------------------------------------------
  % Final
  % Escriba una funcion que, dada una lista de sublistas de enteros, devuelva una nueva lista formada por todos los elementos de aquellas sublistas que sean estrictamente crecientes, intercalados de forma ordenada.

  % Ej: L = [[1,7],[5,5],[3,1],[],[4,10,15],[10]]

  % Resultado: [1,4,7,10,10,15] ya que las sublistas estrictamente crecientes son

  % [1,7],[],[4,10,15] y [10]


minimoLista([], 0).
minimoLista([X], X).
minimoLista([X|XS], X) :-
	minimoLista(XS, R1),
	X =< R1.
minimoLista([X|XS], R2) :-
	minimoLista(XS, R2),
	X > R2.

listCrec([]).
listCrec([_]).
listCrec([P|R]) :-
	minimoLista(R, Min),
	P < Min,
	listCrec(R).

soloCrec([], []).
soloCrec([X|XS], Res) :-
	listCrec(X),
	soloCrec(XS, Res2),
	Res = [X|Res2].
soloCrec([_|XS], Res2) :-
	soloCrec(XS, Res2).

linealiza([], []).
linealiza([X|XS], Res) :-
	is_list(X),
	linealiza(X, R1),
	linealiza(XS, R2),
	append(R1, R2, Res).
linealiza([X|XS], Res) :-
	linealiza(XS, R1),
	Res = [X|R1].

elimElmLista([], _, []).
elimElmLista([X|XS], Elem, XS) :-
	X == Elem.
elimElmLista([X|XS], Elem, [X|R1]) :-
	elimElmLista(XS, Elem, R1).

ordenar([], []).
ordenar([X], [X]).
ordenar([X|XS], R) :-
	minimoLista([X|XS], R1),
	elimElmLista([X|XS], R1, R2),
	ordenar(R2, R3),
	R = [R1|R3].

resultParcial([], []).
resultParcial(L, R) :-
	soloCrec(L, R1),
	linealiza(R1, R2),
	ordenar(R2, R).

%------------------------------------------------------------
%Escriba la función (predicado) que tome como entrada una lista con sublistas de un sólo nivel y una posición P
%y elimine de cada sublista los elementos que están en la posición P. [40 puntos]
%Lista: ((3 8 4 2 3) (1 6 3 9 8) (12 15))
%P=3 y Resultado: ((3 8 2 3) (1 6 9 8) (12 15))
eliminarX([], _X, []).
eliminarX([_X|R], 1, R).
eliminarX([P|R], X, [P|R1]):-
	X > 1,
	X1 is X - 1,
	eliminarX(R, X1, R1).
eliminarsegunX([], _Pos, []).
eliminarsegunX([P|R], Pos, [Res1|Res2]):-
	eliminarX(P, Pos, Res1),
	eliminarsegunX(R, Pos, Res2).

%Escriba la función (predicado) que tome como entrada una lista de pares ordenados y una lista de números (sin sublistas)
%y devuelva otra lista que contenga una sublista por cada par, donde cada sublista incluya
%los elementos de la lista de números que pertenecen a la secuencia aritmética definida por dicho par.
%Cada par (A, S) define una secuencia que comienza en A y aumenta en S unidades cada paso (A, A+S, A+2S, ...).
%Si S es negativo, la sublista correspondiente debe estar vacía.
%Cada número puede aparecer en múltiples sublistas o en ninguna.
%Los elementos en cada sublista deben mantener el orden de aparición en la lista original. [60 puntos]
%Ejemplo:
%Lista de pares: ((3 2) (6 0) (12 3) (7 1))
%(3,2) -> 3,5,7,9,11,13
%Lista de números: (4 6 4 10 3 2 5)
%Resultado: ((3 5) (6) () (10))

pertenecesecuencia(Base, 0, _I, Num):-
	Num =:= Base.
pertenecesecuencia(Base, Inc, I, Num):-
	Inc > 0,
	V is Base + (I*Inc),
	V =:= Num.
pertenecesecuencia(Base, Inc, I, Num):-
	Inc > 0,
	V is Base + (I*Inc),
	V < Num,
	I2 is I + 1,
	pertenecesecuencia(Base, Inc, I2, Num).

parensecuencia([_B, _S], [], []).
parensecuencia([_B, S], [_P|_R], []):-
	S < 0.
parensecuencia([B, S], [P|R], [P|P2]):-
	S >= 0,
	pertenecesecuencia(B, S, 0, P),
	parensecuencia([B, S], R, P2).
parensecuencia([B, S], [P|R], P2):-
	S >= 0,
	not(pertenecesecuencia(B, S, 0, P)),
	parensecuencia([B, S], R, P2).

secuencias([], [_P|_R], []).
 secuencias([Par|Resto], [P|R], [R1|R2]):-
	parensecuencia(Par, [P|R], R1),
	secuencias(Resto, [P|R], R2).

%   # ----------------------------------------------------------
%   #   Escriba una función (predicado) que tome como entrada una lista L con sublistas de la forma (legajo listaNotas)
%   #   que representan los legajos de los estudiantes inscriptos en un curso y la lista de sus notas en dicho curso.
%   #   Devolver el legajo del estudiante de mayor promedio. Si un estudiante no rindió ningún examen la lista de notas estará vacía,
%   #   y se considera que su nota es 0.
%   # Ej.: L = ((1,(5,4,6)),(2,(8,7)),(3,(4)),(4,(5,9,5,3)))
%   # Resultado: 2 (el legajo 2 tiene notas 8 y 7, con promedio 7,5)

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
