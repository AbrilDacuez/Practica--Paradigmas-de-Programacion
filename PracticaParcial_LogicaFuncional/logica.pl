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








