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

% minimoLista([], nil).
minimoLista([P], P).
minimoLista([P|R], Res) :-
	minimoLista(R, Res2),
	P < Res2,
	Res is P.
minimoLista([P|R], Res) :-
	minimoLista(R, Res),
	P >= Res.

listCrec([]).
listCrec([_]).
listCrec([P|R]) :-
	minimoLista(R, Min),
	P < Min,
	listCrec(R).

soloCrec([], []).
soloCrec([P|R], [P|Res2]) :-
	listCrec(P),
	soloCrec(R, Res2).
soloCrec([_|R], Res) :-
	soloCrec(R, Res).

linealiza([], []).
linealiza([P|R], Res) :-
	is_list(P),
	linealiza(P, Res1),
	linealiza(R, Res2),
	append(Res1, Res2, Res).
linealiza([P|R], [P|Res]) :-
	linealiza(R, Res).

elimElmList([], _, []).
elimElmList([P|R], El, R) :-
	P == El.
elimElmList([P|R], El, [P|Res]) :-
	elimElmList(R, El, Res).

ordenar([], []).
% ordenar([P], [P]).
ordenar(L, [Res|Res2]) :-
	minimoLista(L, Res),
	% minimoLista(L, Min),
	elimElmList(L, Res, L2),
	ordenar(L2, Res2).

resultParcial([], []).
resultParcial(L, Res) :-
	soloCrec(L, S),
	linealiza(S, Lin),
	ordenar(Lin, Res).

  % ---------------------------------------------------
  % Final 2
  % Escriba una funcion que tome como entrada una lista con sublistas L y reordene los elementos de la lista principal y cada sublista de tal manera que queden todos los numeros al principio y las listas al final (de la lista y cada sublista)

  % Ej: L = [2,8,[3,1],2,[7,3,10,[4,2],9,[1]],4]
  % Res: [2,8,2,4,[3,1],[7,3,10,9,[4,2],[1]]]

dejarNum([], []).
dejarNum([P|R], Res) :-
	is_list(P),
	dejarNum(R, Res).
dejarNum([P|R], [P|Res]):-
	dejarNum(R, Res).

dejarListas([], []).
dejarListas([P|R], [P|Res]) :-
	is_list(P),
	dejarListas(R, Res).
dejarListas([_|R], Res) :-
	dejarListas(R, Res).

reordena([], []).
reordena([P|R], Res) :-
	is_list(P),
	reordena(P, Res1),
	dejarNum(Res1, Res2),
	dejarListas(Res1, Res3),
	reordena(R, Res4),
	append(Res2, Res3, Res5),
	append([Res5], Res4, Res).
reordena([P|R], [P|Res]) :-
	reordena(R, Res).

respFinal2([], []).
respFinal2(L, Res) :-
	reordena(L, Res1),
	dejarNum(Res1, Res2),
	dejarListas(Res1, Res3),
	append(Res2, Res3, Res).
