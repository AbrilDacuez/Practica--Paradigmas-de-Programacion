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
