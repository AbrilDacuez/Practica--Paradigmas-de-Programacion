defmodule Parcial do
  # ejercicio 1: escriba una funcion que reciba una lista sin sublistas L y un numero N y devuelva una lista con los elementos de L
  # que estan en las posiciones multiplos de N.

  # def multiplos_de_n([], _N), do: []

  # def multiplos_de_n_helper([], _N, _pos), do: []

  # def multiplos_de_n_helper([l | xs], N, pos) do
  #   cond do
  #     rem(pos, N) == 0 ->
  #       [l | multiplos_de_n_helper(xs, N, pos + 1)]
  #       true
  #       multiplos_de_n_helper(xs, N, pos + 1)
  #   end
  # end

  # def multiplos_de_n([l | xs], N) do
  #   multiplos_de_n_helper([l | xs], N, 1)
  # end

  def cant([]), do: 0
  def cant([_ | xs]), do: 1 + cant(xs)
  # 3,4,5,6,7 2 --> 4,6
  def mult([], _), do: []

  def mult([l | xs], n) do
    cond do
      rem(cant([l | xs]), n) == 0 -> [l | mult(xs, n)]
      true -> mult(xs, n)
    end
  end
end

IO.inspect(Parcial.mult([10, 20, 30, 40, 50, 60, 70, 80], 3))
IO.inspect(Parcial.mult([4, 5, 9, 6, 12, 8, 6, 5, 4, 3, 2, 3, 5, 10], 3))
