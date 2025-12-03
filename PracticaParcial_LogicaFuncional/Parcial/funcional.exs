# Dada una lista de sublistas de enteros, devuelve una nueva lista formada
# por todos los elementos de aquellas sublistas que sean estrictamente crecientes, intercalados de forma ordenada.
# Ej: L = [[1,7],[5,5],[3,1],[],[4,10,15],[10]]
# Resultado: [1,4,7,10,10,15] ya que las sublistas estrictamente crecientes son
# [1,7],[],[4,10,15] y [10]

defmodule Parcial1 do
  def min([]), do: nil
  def min([x]), do: x

  def min([x | r]) do
    cond do
      x < min(r) -> x
      true -> min(r)
    end
  end

  def esCrec([]), do: true
  def esCrec([_]), do: true

  def esCrec([x | r]) do
    cond do
      x < min(r) -> esCrec(r)
      true -> false
    end
  end

  def soloCrec([]), do: []

  def soloCrec([x]), do: x

  def soloCrec([x | r]) do
    cond do
      esCrec(x) -> [x | soloCrec(r)]
      true -> soloCrec(r)
    end
  end

  def linealiza([]), do: []

  def linealiza([x | r]) do
    cond do
      is_list(x) -> linealiza(x) ++ linealiza(r)
      true -> [x | linealiza(r)]
    end
  end

  def eliminarElm([], _), do: []

  def eliminarElm([x | r], elm) do
    cond do
      x == elm -> r
      true -> [x | eliminarElm(r, elm)]
    end
  end

  def ordenar([]), do: []

  def ordenar([x]), do: [x]

  def ordenar(l) do
    [min(l) | ordenar(eliminarElm(l, min(l)))]
  end

  def resultado([]), do: []

  def resultado(l) do
    ordenar(linealiza(soloCrec(l)))
  end
end

defmodule Parcial2 do
  # Escriba una función (predicado) que tome como entrada una lista con sublistas L y reordene los elementos de la lista principal
  # y cada sublista de tal manera que queden todos los números al principio y las listas al final (de la lista y cada sublista).
  # Ej.: L=[2, 8, [31], 2, [7, 3, 10, [42], 9,[1]], 4]
  # Resultado: [2, 8, 2, 4, [31], [7 3 10 9 [42] [1]]]

  def ordenar([]), do: []

  def ordenar([x | xs]) do
    cond do
      is_list(x) -> ordenar(xs) ++ [ordenar(x)]
      true -> [x | ordenar(xs)]
    end
  end
end

defmodule Parcial3 do
  #   Escriba la función (predicado) Coinciden, que tome como entrada una lista L de números (sin sublistas)
  #   y una lista M que contiene sublistas, y devuelva otra lista formada únicamente por sublistas de un solo nivel.
  #   Estas sublistas deben ser aquellas de M que incluyan todos los elementos de L en su nivel 1
  #   (es decir, sin considerar elementos que estén dentro de sub-sublistas).
  # Ejemplo:
  # L = [2,6]
  # M = [[6, 2, [1, 2], 3], [8, 6, 4], [2, [2, 2], 7, 5, 6], [9, 1, 6]]
  # Resultado: [[6, 2, 3], [2, 7, 5, 6]]

  def eliminarNivelesSuperiores([]), do: []

  def eliminarNivelesSuperiores([x | xs]) do
    cond do
      is_list(x) -> eliminarNivelesSuperiores(xs)
      true -> [x | eliminarNivelesSuperiores(xs)]
    end
  end

  def eliminarNivelSuperior([]), do: []

  def eliminarNivelSuperior([x]) do
    [eliminarNivelesSuperiores(x)]
  end

  def eliminarNivelSuperior([x | xs]) do
    [eliminarNivelesSuperiores(x) | eliminarNivelSuperior(xs)]
  end

  def contiene1([], _x), do: false
  def contiene1([h | _], h), do: true
  def contiene1([_ | t], x), do: contiene1(t, x)

  def contiene2(_l, []), do: true
  def contiene2([], [_ | _]), do: false

  def contiene2(l, [x | xs]) do
    cond do
      contiene1(l, x) -> contiene2(l, xs)
      true -> false
    end
  end

  def contiene3([], [_ | _]), do: []

  def contiene3([x | xs], [y | ys]) do
    cond do
      contiene2(x, [y | ys]) -> [x | contiene3(xs, [y | ys])]
      true -> contiene3(xs, [y | ys])
    end
  end

  def contiene([x | xs], [y | ys]) do
    contiene3(eliminarNivelSuperior([x | xs]), [y | ys])
  end
end

defmodule Parcial4 do
  # Escriba una función (predicado) que tome como entrada una
  # lista con sublistas anidadas L y un número N, y devuelva la
  # suma de todos los elementos que se encuentran
  # exactamente en el nivel N.
  # Ej: L = [1, [2,3], [[4], 5], [[[6]]]], N = 2 Resultado: 2+3+5=10
  [1, [2, 3], [[4], 5], [[[6]]]]

  def sumaNivel([], _), do: 0

  def sumaNivel([x | xs], 1) do
    cond do
      is_number(x) -> x + sumaNivel(xs, 1)
      true -> sumaNivel(xs, 1)
    end
  end

  def sumaNivel([x | xs], n) do
    cond do
      is_list(x) -> sumaNivel(x, n - 1) + sumaNivel(xs, n)
      true -> sumaNivel(xs, n)
    end
  end
end

defmodule Parcial5 do
  #   1. Escriba la función (predicado) que tome como entrada una
  #   lista con sublistas de un sólo nivel y una posición P, y
  #   elimine de cada sublista los elementos que están en la
  #   posición P. [40 puntos]
  # Ejemplo:
  # Lista: ((3 8 4 2 3) (1 6 3 9 8) (12 15))
  # P=3
  # Resultado: ((3 8 2 3) (1 6 9 8) (12 15))

  def quitarPosP([], _, _), do: []

  def quitarPosP([x | xs], p, i) do
    cond do
      i < p -> [x | quitarPosP(xs, p, i + 1)]
      i == p -> xs
    end
  end

  def elimPos([], _), do: []

  def elimPos([x | xs], p) do
    [quitarPosP(x, p, 1) | elimPos(xs, p)]
  end
end

defmodule Parcial6 do
  #   Escriba una función (predicado) que, dada una lista con sublistas L,
  #   devuelva una lista donde el iésimo elemento representa la sumatoria de
  #   los números contenidos en nivel i de profundidad de L. Si no hay elementos
  #   numéricos en un nivel específico, ese nivel tendrá valor 0 en la lista resultante. [60 puntos]
  # Ej: L=(1,(2 3)((4 5)6) (7(8(9))) ), resultado: (1 18 17 9)
  # Nivel 1: 1
  # Nivel 2: 2 + 3 + 6 + 7 = 18
  # Nivel 3: 4 + 5 + 8 = 17
  # Nivel 4: 9

  def profundidad([]), do: 1

  def profundidad([x | xs]) do
    cond do
      profundidad(x) >= profundidad(xs) ->
        profundidad(x) + 1

      true ->
        profundidad(xs)
    end
  end

  def profundidad(_), do: 0

  def sumaNivel([], _i), do: 0

  def sumaNivel([x | xs], 1) do
    cond do
      is_number(x) -> x + sumaNivel(xs, 1)
      true -> sumaNivel(xs, 1)
    end
  end

  def sumaNivel([x | xs], n) do
    cond do
      is_list(x) -> sumaNivel(x, n - 1) + sumaNivel(xs, n)
      true -> sumaNivel(xs, n)
    end
  end

  def generarLista([], _), do: []

  def generarLista([x | xs], i) do
    cond do
      i > profundidad([x | xs]) -> []
      true -> [sumaNivel([x | xs], i) | generarLista([x | xs], i + 1)]
    end
  end

  def result(l) do
    generarLista(l, 1)
  end
end

defmodule Parcial7 do
  #   Escriba una función (predicado) que tome como entrada una lista
  #   sin sublistas L y un número N, y devuelva una lista con los
  #   elementos de L que están en las posiciones múltiplos de N.

  # Por ejemplo, si N = 3, las posiciones serían 3, 6, 9, etc.
  # [40 puntos]

  # Ej.: L = (4 5 9 6 12 8 6 5 4 3 2 3 5 10), N = 3
  # Resultado: (9 8 4 3)

  def esMult(i, n) do
    cond do
      rem(i, n) == 0 -> true
      true -> false
    end
  end

  def devolverPos([], _), do: []

  def devolverPos([x], n, i) do
    cond do
      rem(i, n) == 0 -> [x]
      true -> []
    end
  end

  def devolverPos([x | xs], n, i) do
    cond do
      esMult(i, n) -> [x | devolverPos(xs, n, i + 1)]
      true -> devolverPos(xs, n, i + 1)
    end
  end

  def result([x | xs], n) do
    devolverPos([x | xs], n, 1)
  end
end

defmodule Parcial8 do
  # 2. Escriba la función (predicado) que tome como entrada una lista
  # de pares ordenados y una lista de números (sin sublistas),
  # y devuelva otra lista que contenga una sublista por cada par,
  # donde cada sublista incluya los elementos de la lista de números
  # que pertenecen a la secuencia aritmética definida por dicho par.
  # Cada par (A, S) define una secuencia que comienza en A y aumenta en
  # S unidades cada paso (A, A+S, A+2S, ...). Si S es negativo,
  # la sublista correspondiente debe estar vacía. Cada número puede
  # aparecer en múltiples sublistas o en ninguna. Los elementos en
  # cada sublista deben mantener el orden de aparición en la lista
  # original. [60 puntos]
  # Ejemplo:
  # Lista de pares: ((32) (60) (123) (7 1))
  # Lista de números: (4 6 4 10 3 2 5)
  # Resultado: ((35) (6) () (10))

  # [2,4,6,8,10,12]

  def perteneceSecuencia(x, [x, _], _), do: true

  def perteneceSecuencia(l, [x, y], i) do
    cond do
      l == x + y -> true
      l == y * i + x -> true
      y < 0 -> false
      l > i -> perteneceSecuencia(l, [x, y], i + 1)
      true -> false
    end
  end

  def perteneceSecuencia2([], _), do: []

  def perteneceSecuencia2([l | xs], [x, y]) do
    cond do
      perteneceSecuencia(l, [x, y], 0) -> [l | perteneceSecuencia2(xs, [x, y])]
      true -> perteneceSecuencia2(xs, [x, y])
    end
  end

  def perteneceSecuencia3([], _), do: []

  def perteneceSecuencia3(_, []), do: []

  def perteneceSecuencia3(lista, [par | resto]) do
    [perteneceSecuencia2(lista, par) | perteneceSecuencia3(lista, resto)]
  end
end

defmodule Parcial9 do
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

IO.inspect(
  Parcial8.perteneceSecuencia3([4, 6, 4, 10, 3, 2, 5], [[3, 2], [6, 0], [12, -3], [7, 1]]),
  charlists: true
)
