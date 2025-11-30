% --------------------------------------
	% Parcial 06/02/2025
	% Ejercio 1: esriba la función (predicado) que tome como entrada una lista con sublistas de un sólo nivel y una posición P
	% y elimine de cada sublista los elementos que están en la posición P. [40 puntos]
	% Lista: ((3 8 4 2 3) (1 6 3 9 8) (12 15))
	% P=3 y Resultado: ((3 8 2 3) (1 6 9 8) (12 15))

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
