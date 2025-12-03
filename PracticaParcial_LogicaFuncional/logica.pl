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

	% ------------------------------------------
	% Final 3
  % Escriba la funcion Coinciden, que tome como entrada una lista L de numeros (sin sublistas) y una lista M que contiene sublistas, y devuelva otra lista formada unicamente por sublistas de un solo nivel. Estas sublistas deben ser aquellas de M que incluyan todos los elementos de L en su nivel 1 (es decir, sin considerar elementos que esten dentro de sublistas).

  % Ejemplo:
  % L = [2,6]
  % M = [[6,2,[1,2],3],[8,6,4],[2,[2,2],7,5,6],[9,1,6]]
  % Resultado: [[6,2,3],[2,7,5,6]]

buscarElm(_, []). 
	% Para contemplar el vacio dentro del conjunto
buscarElm([P|_], [S]) :-
	P == S.
buscarElm([P|R], [S]) :-
	P \= S,
	buscarElm(R, [S]).
buscarElm([P|R], [S|T]) :-
	P == S,
	buscarElm([P|R], T).
buscarElm([P|R], [S|T]) :-
	P \= S,
	buscarElm(R, [S]),
	buscarElm([P|R], T).

elimSubList([], []).
elimSubList([P|R], Res):-
	is_list(P),
	elimSubList(R, Res).
elimSubList([P|R], [P|Res]) :-
	elimSubList(R, Res).

coinciden([], [], []).
coinciden([], _, []).
coinciden([P|R], L2, [Res|Res2]) :-
	buscarElm(P, L2),
	elimSubList(P, Res),
	coinciden(R, L2, Res2).
coinciden([_|R], L2, Res) :-
	coinciden(R, L2, Res).

%  -------------------------------------
  %  Final 4
  %  Escriba una funcion que tome como entrada una lista con sublistas anidadas L y un numero N, y devuelva la suma de todos los elementos que se encuentran exactamente en el nivel N.

  %  Ej: L = [1,[2,3],[[4],5],[[[6]]]]   N = 2
  %  Resultado: 2 + 3 + 5 = 10

sumaNivel([], _, 0).
sumaNivel([P|R], 1, Res) :-
	is_list(P),
	sumaNivel(R, 1, Res).
sumaNivel([P|R], 1, Res) :-
	not(is_list(P)),
	sumaNivel(R, 1, Res2),
	Res is P + Res2.
sumaNivel([P|R], N, Res) :-
	N > 1,
	is_list(P),
	N2 is N - 1,
	sumaNivel(P, N2, Res2),
	sumaNivel(R, N, Res3),
	Res is Res2 + Res3.
sumaNivel([P|R], N, Res):-
	N > 1,
	not(is_list(P)),
	sumaNivel(R, N, Res).

  % Final 5
  % Escriba una funcion que tome como entrada una lista L con sublistas de la forma (legajo listaNotas) que representan los legajos de los estudiantes inscriptos en un curso y la lista de sus notas en dicho curso. Devolver el legajo del estudiante de mayor promedio. Si un estudiante no rindió ningun examen la lista de notas estará vacia, y se considera que su nota es 0.

  % Ej: L = [[1,[5,4,6]],[2,[8,7]],[3,[4]],[4,[5,9,5,3]]]
  % Resultado: 2
  % El legajo 2 tiene notas 8 y 7, con promedio 7.5)

sumaLista([], 0).
sumaLista([P|R], Res) :-
	sumaLista(R, Res2),
	Res is P + Res2.

cantidadLista([], 0).
cantidadLista([_|R], Res) :-
	cantidadLista(R, Res2),
	Res is 1 + Res2.

promedio([], 0).
promedio(L, Res) :-
	sumaLista(L, Res1),
	cantidadLista(L, Res2),
	Res is Res1/Res2.

elimNum([], []).
elimNum([P|R], [P|Res]) :-
	is_list(P),
	elimNum(R, Res).
elimNum([P|R], Res) :-
	not(is_list(P)),
	elimNum(R, Res).



  %  -----------------------------------------
  % Parcial 06/02/2025
  %  Ejercicio 2
  %  Escriba la funcion que tome como entrada una lista de pares ordenados y una lista de numeros (sin sublistas), y devuelva otra lista que contenga una sublista por cada par, donde cada sublista incluya los elementos de la lista de numeros que pertenecen a la secuencia aritmetica definida por dicho par. Cada par (A,S) define una secuencia que comienza en A y aumenta en S unidades cada paso (A,A+S,A+2S,...). Si S es negativo, la sublista correspondiente debe estar vacia. Cada numero puede aparecer en multiples sublistas o en ninguna. Los elementos en cada sublista deben mantener el orden de aparicion en la lista original.

  %  Ej:
  %  Lista de pares:[[3,2],[6,0],[12,3],[7,1]]
  %  Lista de numeros: [4,6,4,10,3,2,5]
  %  Resultado: [[3,5],[6],[],[10]]

multAS([P, 0], _, _, [P]).
multAS([_, S], _, _, []) :-
	S < 0.
multAS([P, S], N, Lim, []) :-
	P + (S*N) > Lim.
multAS([P, S], N, Lim, [Res|Res2]) :-
	Res is P + (S*N),
	N2 is N + 1,
	multAS([P, S], N2, Lim, Res2).

max1([P], P).
max1([P|R], P) :-
	max1(R, Res),
	P > Res.
max1([P|R], Res) :-
	max1(R, Res),
	P =< Res.

buscarEl([P|_], E) :-
	P == E.
buscarEl([P|R], E) :-
	P \= E,
	buscarEl(R, E).

buscarSec([], _, []).
buscarSec(_, [], []).
buscarSec(L, [P|R], [P|Res]) :-
	buscarEl(L, P),
	buscarSec(L, R, Res).
buscarSec(L, [_|R], Res) :-
	buscarSec(L, R, Res).

listaSec([], _, []).
listaSec([P|R], L, [Res|Res2]) :-
	max1(L, M),
	multAS(P, 0, M, Mul),
	buscarSec(Mul, L, Res),
	listaSec(R, L, Res2).
