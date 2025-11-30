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

  # L = [1,[2,3],[[4,5],6],[7,[8,[9]]]]
  # L[0] = 1
  # L[1] = [2,3]
  # L[2] = [[4,5],6]

  def sumNivel([]), do: 0
  # def sumNivel([x]), do: x
  def sumNivel([x | xs]) do
    cond do
      is_list(x) -> sumNivel(xs)
      true -> x + sumNivel(xs)
    end
  end

  def elmNivel([]), do: []

  def elmNivel([x | xs]) do
    cond do
      is_list(x) -> [x | elmNivel(xs)]
      true -> elmNivel(xs)
    end
  end

  def linNivel([]), do: []

  def linNivel([x | xs]) do
    cond do
      is_list(x) -> x ++ linNivel(xs)
      true -> [x | linNivel(xs)]
    end
  end

  def lisSumIes([]), do: []

  def lisSumIes(l) do
    [sumNivel(l) | lisSumIes(linNivel(elmNivel(l)))]
  end

  # ----------------------------------------------------------
  # Final
  # Escriba una funcion que, dada una lista de sublistas de enteros, devuelva una nueva lista formada por todos los elementos de aquellas sublistas que sean estrictamente crecientes, intercalados de forma ordenada.

  # Ej: L = [[1,7],[5,5],[3,1],[],[4,10,15],[10]]

  # Resultado: [1,4,7,10,10,15] ya que las sublistas estrictamente crecientes son

  # [1,7],[],[4,10,15] y [10]
  def minimoLista([]), do: nil
  def minimoLista([x]),do: x
  def minimoLista([x|xs]) do
    cond do
      x < minimoLista(xs) -> x
      true -> minimoLista(xs)
    end
  end

  def listCrec([]), do: true
  def listCrec([x|xs]) do
    cond do
      x < minimoLista(xs) -> listCrec(xs)
      true -> false
    end
  end

  def soloCrec([]), do: []
  def soloCrec([x|xs]) do
    cond do
      listCrec(x) -> [x | soloCrec(xs)]
      true -> soloCrec(xs)
    end
  end

  def linealiza([]), do: []
  def linealiza([x|xs]) do
    cond do
      is_list(x) -> linealiza(x) ++ linealiza(xs)
      true -> [ x | linealiza(xs) ]
    end
  end


  def elimElmLista([],_), do: []
  def elimElmLista([x|xs],el) do
    cond do
      x == el -> xs
      true -> [x | elimElmLista(xs,el)]
    end
  end

  def ordenar([]), do: []
  def ordenar([x]), do: [x]
  def ordenar(l) do
     [minimoLista(l) | ordenar(elimElmLista(l,minimoLista(l)))]
  end

  def resultParcial([]), do: []
  def resultParcial(l) do
    ordenar(linealiza(soloCrec(l)))
  end
end

IO.inspect(Parcial.resultParcial([[1,7],[5,5],[3,1],[],[4,10,15],[10]]), charlists: true)
