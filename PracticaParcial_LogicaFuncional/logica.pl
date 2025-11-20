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