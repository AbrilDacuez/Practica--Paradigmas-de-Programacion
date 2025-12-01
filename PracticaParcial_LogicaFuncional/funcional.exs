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
  def minimoLista([x]), do: x

  def minimoLista([x | xs]) do
    cond do
      x < minimoLista(xs) -> x
      true -> minimoLista(xs)
    end
  end

  def listCrec([]), do: true

  def listCrec([x | xs]) do
    cond do
      x < minimoLista(xs) -> listCrec(xs)
      true -> false
    end
  end

  def soloCrec([]), do: []

  def soloCrec([x | xs]) do
    cond do
      listCrec(x) -> [x | soloCrec(xs)]
      true -> soloCrec(xs)
    end
  end

  def linealiza([]), do: []

  def linealiza([x | xs]) do
    cond do
      is_list(x) -> linealiza(x) ++ linealiza(xs)
      true -> [x | linealiza(xs)]
    end
  end

  def elimElmLista([], _), do: []

  def elimElmLista([x | xs], el) do
    cond do
      x == el -> xs
      true -> [x | elimElmLista(xs, el)]
    end
  end

  def ordenar([]), do: []
  def ordenar([x]), do: [x]

  def ordenar(l) do
    [minimoLista(l) | ordenar(elimElmLista(l, minimoLista(l)))]
  end

  def resultParcial([]), do: []

  def resultParcial(l) do
    ordenar(linealiza(soloCrec(l)))
  end

  # ----------------------------------------------------------
  # Escriba la función (predicado) que tome como entrada una lista con sublistas de un sólo nivel y una posición P,
  # y elimine de cada sublista los elementos que están en la posición P. [40 puntos]
  # Ejemplo:
  # Lista: ((3 8 4 2 3) (1 6 3 9 8) (12 15))
  # P = 3
  # Resultado: ((3 8 2 3) (1 6 9 8) (12 15))
  def eliminarX([], _x), do: []

  def eliminarX([p | r], x) do
    cond do
      x == 1 -> r
      true -> [p | eliminarX(r, x - 1)]
    end
  end

  def eliminarsegunX([], _x), do: []
  def eliminarsegunX([p | r], x), do: [eliminarX(p, x) | eliminarsegunX(r, x)]

  # Escriba la función (predicado) que tome como entrada una lista de pares ordenados y una lista de números (sin sublistas)
  # y devuelva otra lista que contenga una sublista por cada par, donde cada sublista incluya
  # los elementos de la lista de números que pertenecen a la secuencia aritmética definida por dicho par.
  # Cada par (A, S) define una secuencia que comienza en A y aumenta en S unidades cada paso (A, A+S, A+2S, ...).
  # Si S es negativo, la sublista correspondiente debe estar vacía.
  # Cada número puede aparecer en múltiples sublistas o en ninguna.
  # Los elementos en cada sublista deben mantener el orden de aparición en la lista original. [60 puntos]
  # Ejemplo:
  # Lista de pares: ((3 2) (6 0) (12 3) (7 1))
  # (3,2) -> 3,5,7,9,11,13
  # Lista de números: (4 6 4 10 3 2 5)
  # Resultado: ((3 5) (6) () (10))
  def pertenecesecuencia(base, 0, _i, num) do
    base == num
  end

  def pertenecesecuencia(base, inc, i, num) do
    cond do
      base + inc * i > num -> false
      base + inc * i == num -> true
      true -> pertenecesecuencia(base, inc, i + 1, num)
    end
  end

  def parensecuencia([_b, _s], []), do: []

  def parensecuencia([b, s], [p | r]) do
    cond do
      s < 0 -> []
      pertenecesecuencia(b, s, 0, p) -> [p | parensecuencia([b, s], r)]
      true -> parensecuencia([b, s], r)
    end
  end

  def secuencias([], [_p | _r]), do: []

  def secuencias([par | res], [p | r]) do
    cond do
      true -> [parensecuencia(par, [p | r]) | secuencias(res, [p | r])]
    end
  end

  # ----------------------------------------------------------
  #   Escriba una función (predicado) que tome como entrada una lista L con sublistas de la forma (legajo listaNotas)
  #   que representan los legajos de los estudiantes inscriptos en un curso y la lista de sus notas en dicho curso.
  #   Devolver el legajo del estudiante de mayor promedio. Si un estudiante no rindió ningún examen la lista de notas estará vacía,
  #   y se considera que su nota es 0.
  # Ej.: L = ((1,(5,4,6)),(2,(8,7)),(3,(4)),(4,(5,9,5,3)))
  # Resultado: 2 (el legajo 2 tiene notas 8 y 7, con promedio 7,5)

  def cantL([]), do: 0

  def cantL([_ | xs]) do
    1 + cantL(xs)
  end

  def suma([]), do: 0

  def suma([x | xs]) do
    x + suma(xs)
  end

  def promedio([]), do: 0

  def promedio([l]) do
    suma(l) / cantL(l)
  end

  def legajo([x | _]), do: x

  def promedio2([]), do: 0

  def promedio2([_ | xs]) do
    promedio(xs)
  end

  def listaPromedios([]), do: []

  def listaPromedios([x | xs]) do
    [{legajo(x), promedio2(x)} | listaPromedios(xs)]
  end

  def segundo({_, y}), do: y
  def primero({x, _}), do: x

  def max([]), do: {0, 0}

  def max({x, y}), do: {x, y}

  def max([{x, y} | xs]) do
    cond do
      segundo(max(xs)) == 0 -> {x, y}
      segundo(max({x, y})) > segundo(max(xs)) -> {x, y}
      true -> max(xs)
    end
  end

  def legajo_mayor_promedio(l) do
    primero(max(listaPromedios(l)))
  end
end

IO.inspect(Parcial.listaPromedios([[1, [5, 4, 6]], [2, [8, 7]], [3, [4]], [4, [5, 9, 5, 3]]]))
IO.puts(Parcial.legajo_mayor_promedio([[1, [5, 4, 6]], [2, [8, 7]], [3, [4]], [4, [5, 9, 5, 3]]]))
