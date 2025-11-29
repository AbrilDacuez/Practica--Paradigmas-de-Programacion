defmodule Parcial do
  # Parcial 02/12/2024
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

  # Ejercicio 2: Escriba una funcion que, dada una lista con sublistas L, devuelva una lista donde el iésimo elemento representa la sumatoria de los números contenidos en nivel i de profundidad de L. Si no hay elementos numéricos en un nivel específico, ese nivel tendrá valor 0 en la lista resultante.
  # Ej L=[1,[2,3],[[4,5],6],[7,[8,[9]]]] -> Res [1,18,17,9]
  # Nivel 1: 1
  # Nivel 2: 2+3+6+7 = 18
  # Nivel 3: 4+5+8 = 17
  # Nivel 4: 9

  def sumNivel([]), do: 0
  # def sumNivel([x]), do: x
  def sumNivel([x|xs]) do
    cond do
      is_list(x) -> sumNivel(xs)
      true -> x + sumNivel(xs)
    end
  end

  #L = [1,[2,3],[[4,5],6],[7,[8,[9]]]]
  #L[0] = 1
  #L[1] = [2,3]
  #L[2] = [[4,5],6]

  def elmNivel([]), do: []
  def elmNivel([x|xs]) do
    cond do
      is_list(x) -> [x | elmNivel(xs)]
      true -> elmNivel(xs)
    end
  end

  def linNivel([]), do: []
  def linNivel([x|xs]) do
    cond do
      is_list(x) -> x ++ linNivel(xs)
      true -> [x | linNivel(xs)]
    end
  end

  def lisSumIes([]), do: []
  def lisSumIes(l) do
     [sumNivel(l) | lisSumIes(linNivel(elmNivel(l)))]
  end

  # ----------------------------------
  # Parcial
#  esriba la función (predicado) que tome como entrada una lista con sublistas de un sólo nivel y una posición P
#  y elimine de cada sublista los elementos que están en la posición P. [40 puntos]
#  Lista: ((3 8 4 2 3) (1 6 3 9 8) (12 15))
# P=3 y Resultado: ((3 8 2 3) (1 6 9 8) (12 15))

  def eliminarX([],_x), do: []
  def eliminarX([p | r], x) do
    cond do
      x == 1 -> r
      true -> [p | eliminarX(r, x-1)]
    end
  end
  def eliminarsegunX([],_x), do: []
  def eliminarsegunX([p|r],x), do: [eliminarX(p,x) | eliminarsegunX(r,x)]

end

IO.inspect(Parcial.lisSumIes([[2,3],[[4,5],6],[7,[8,[9]]],3]),charlists: true)
IO.inspect(Parcial.lisSumIes([1,[2,3],[[4,5],6],[7,[8,[9]]],3]),charlists: true)
IO.inspect(Parcial.lisSumIes([1,[2,3],[[4,5],6],[7,[8,[9]]]]),charlists: true)
IO.inspect(Parcial.lisSumIes([[2,3],[[4,5],6],2,[7,[8,[9]]]]),charlists: true)
# IO.inspect(Parcial.linNivel([[2,3],[[4,5],6],[7,[8,[9]]]]),charlists: true)
# IO.inspect(Parcial.linNivel([[4, 5],[8, [9]]]),charlists: true)
# IO.inspect(Parcial.mult([4, 5, 9, 6, 12, 8, 6, 5, 4, 3, 2, 3, 5, 10], 3))
