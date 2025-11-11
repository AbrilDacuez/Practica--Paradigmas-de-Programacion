defmodule Nivel1 do
  def cuadrado(x) do
    x * x
  end

  def valorAbsoluto(x) do
    cond do
      x < 0 -> x * -1
      true -> x
    end
  end

  def calculo(n) do
    n * (n - 1) / 2
  end
end

defmodule Nivel2 do
  def potenciaEnesima(x, n) do
    cond do
      n == 0 -> 1
      true -> x * potenciaEnesima(x, n - 1)
    end
  end

  def cantidad([]) do
    0
  end

  def cantidad([_ | xs]) do
    1 + cantidad(xs)
  end

  def sumatoria([]) do
    0
  end

  def sumatoria([l | xs]) do
    l + sumatoria(xs)
  end

  def iEsimoLista([], _) do
    nil
  end

  def iEsimoLista([l | xs], n) do
    cond do
      n == 1 -> l
      true -> iEsimoLista(xs, n - 1)
    end
  end

  def eliminarIesimo([], _) do
    []
  end

  def eliminarIesimo([_ | xs], 1) do
    xs
  end

  def eliminarIesimo([l | xs], n) do
    [l | eliminarIesimo(xs, n - 1)]
  end

  def existe([], _) do
    "no existe"
  end

  def existe([l | xs], x) do
    cond do
      l == x ->
        "existe"

      true ->
        existe(xs, x)
    end
  end

  def media([]) do
    0
  end

  def media(l) do
    sumatoria(l) / cantidad(l)
  end

  def agregar(l, x, 1) do
    [x | l]
  end

  def agregar([l | xs], x, i) do
    [l | agregar(xs, x, i - 1)]
  end

  def agregarListaOrdenada([], x) do
    [x]
  end

  def agregarListaOrdenada([l | xs], x) do
    cond do
      x < l -> [x | [l | xs]]
      true -> [l | agregarListaOrdenada(xs, x)]
    end
  end

  def sumaTresPotencias(x) do
    x + potenciaEnesima(x, 2) + potenciaEnesima(x, 3)
  end

  def eliminarOcurrencias([], _) do
    []
  end

  def eliminarOcurrencias([l | xs], x) do
    cond do
      x == l -> eliminarOcurrencias(xs, x)
      true -> [l | eliminarOcurrencias(xs, x)]
    end
  end

  def reemplazo([], _, _) do
    []
  end

  def reemplazo([l | xs], x, y) do
    cond do
      l == x -> [y | xs]
      true -> [l | reemplazo(xs, x, y)]
    end
  end

  def minimo([l]) do
    l
  end

  def minimo([l | xs]) do
    cond do
      l < minimo(xs) -> l
      true -> minimo(xs)
    end
  end

  def maximo([l]) do
    l
  end

  def maximo([l | xs]) do
    cond do
      l > maximo(xs) -> l
      true -> maximo(xs)
    end
  end

  def lista3upla([l | xs]) do
    {media([l | xs]), maximo([l | xs]), minimo([l | xs])}
  end
end

defmodule Nivel3 do
  def sumaDivisores(x) do
    sumaDivisores(x, 1, 0)
  end

  def sumaDivisores(x, i, resultado) do
    cond do
      i == x -> resultado
      rem(x, i) == 0 -> sumaDivisores(x, i + 1, resultado + i)
      true -> sumaDivisores(x, i + 1, resultado)
    end
  end

  def esPerfecto(n) do
    sumaDivisores(n) == n
  end

  def buscarPerfecto(i) do
    cond do
      i <= 0 -> nil
      true -> buscarPerfecto(i, 1, 0)
    end
  end

  def buscarPerfecto(i, n, encontrados) do
    cond do
      esPerfecto(n) and encontrados + 1 == i -> n
      esPerfecto(n) -> buscarPerfecto(i, n + 1, encontrados + 1)
      true -> buscarPerfecto(i, n + 1, encontrados)
    end
  end

  def iEsimoNumPerfecto(i) do
    buscarPerfecto(i)
  end

  def raiz(n) do
    cond do
      n == 0 -> 0
      n < 0 -> "error"
      true -> n ** (1 / 2)
    end
  end

  def esPrimo(n) do
    cond do
      n <= 1 ->
        false

      n == 2 ->
        true

      n == 3 ->
        true

      rem(n, 2) == 0 ->
        false

      true ->
        lim = trunc(raiz(n))
        probarImpares(n, 3, lim)
    end
  end

  def probarImpares(n, i, lim) do
    cond do
      rem(n, i) == 0 -> false
      i > lim -> true
      true -> probarImpares(n, i + 2, lim)
    end
  end

  def buscarPrimos(n) do
    cond do
      n <= 0 -> nil
      true -> buscarPrimos(n, [], 1)
    end
  end

  def buscarPrimos(n, [], i) do
    cond do
      esPrimo(i) ->
        buscarPrimos(n, [i], i + 1)

      true ->
        buscarPrimos(n, [], i + 1)
    end
  end

  def buscarPrimos(n, [l | xs], i) do
    cond do
      esPrimo(i) and Nivel2.cantidad([l | xs]) + 1 == n + 1 ->
        Nivel2.agregarListaOrdenada([l | xs], i)

      esPrimo(i) ->
        buscarPrimos(n, Nivel2.agregarListaOrdenada([l | xs], i), i + 1)

      true ->
        buscarPrimos(n, [l | xs], i + 1)
    end
  end

  def iEsimoNumPrimo(n) do
    buscarPrimos(n)
  end

  def numerador([]) do
    0
  end

  def numerador([l | xs], media) do
    (l - media) ** 2 + numerador(xs, media)
  end

  def varianza([l | xs]) do
    media = Nivel2.media([l | xs])
    numerador([l | xs], media) / (Nivel2.cantidad([l | xs]) - 1)
  end

  def moda([l]) do
    l
  end

  def moda([l | xs]) do
    cond do
      frecuencia([l | xs], l) > moda(xs) ->
        l

      true ->
        moda(xs)
    end
  end

  def frecuencia([l | xs], x) do
    cond do
      l == x -> 1 + frecuencia(xs, x)
      true -> frecuencia(xs, x)
    end
  end

  def frecuencia([], _), do: 0

  def cantNumLista([]), do: 0

  def cantNumLista([l | xs]) do
    cond do
      is_number(l) -> 1 + cantNumLista(xs)
      true -> cantNumLista(xs)
    end
  end
end

defmodule Moda_que_no_le_gusta_a_Andres do
  def moda([l]) do
    l
  end

  def moda([l | xs]) do
    maximo(calcularCantidadElemento([l | xs], []))
  end

  def calcularMayor([l | xs]) do
    maximo([l | xs])
  end

  def maximo([[c, n] | xs]) do
    cond do
      Nivel2.cantidad([[c, n] | xs]) == 1 -> n
      c > maximo(xs) -> n
      true -> maximo(xs)
    end
  end

  def calcularCantidadElemento([l | xs], lista) do
    cond do
      lista == [] ->
        calcularCantidadElemento(
          Nivel2.eliminarOcurrencias([l | xs], l),
          agregarLista(
            lista,
            l,
            Nivel2.cantidad([l | xs]) - Nivel2.cantidad(Nivel2.eliminarOcurrencias([l | xs], l))
          )
        )

      true ->
        calcularCantidadElemento(
          Nivel2.eliminarOcurrencias([l | xs], l),
          agregarLista(
            lista,
            l,
            Nivel2.cantidad([l | xs]) - Nivel2.cantidad(Nivel2.eliminarOcurrencias([l | xs], l))
          )
        )
    end
  end

  def calcularCantidadElemento([], lista) do
    lista
  end

  # tiene dos campos, uno con el elemento y otro con la cantidad
  def agregarLista(lista, elem, cant) do
    [[cant, elem] | lista]
  end
end

defmodule Nivel4 do
  # 39.	Escriba una función llamada "Cantidad-de" que toma como argumentos una lista y una condición (función),
  # y  devuelve la cantidad de elementos de la lista que cumplen con dicha condición.

  def cantidadDe([], _), do: 0

  def cantidadDe([l | xs], condicion) do
    cond do
      condicion.(l) -> 1 + cantidadDe(xs, condicion)
      true -> cantidadDe(xs, condicion)
    end
  end

  # 40.	Defina una función que tome una lista de números y una condición (función)
  # como parámetros y devuelva la sumatoria de los elementos que cumplen dicha condición.

  def sumCond([], _), do: 0

  def sumCond([l | xs], condicion) do
    cond do
      condicion.(l) -> l + sumCond(xs, condicion)
      true -> sumCond(xs, condicion)
    end
  end

  # 41.	Defina una función llamada “Select” que devuelva la lista de elementos que cumplen con una determinada condición.
  def select([], _), do: []

  def select([l | xs], condicion) do
    cond do
      condicion.(l) -> [l | select(xs, condicion)]
      true -> select(xs, condicion)
    end
  end

  # 42.	Defina una función llamada “Map” o “Collect” que devuelva la lista de los resultados de aplicar una
  # función que se pasa como parámetro a cada elemento de la lista de entrada.

  def map([], _), do: []

  def map([l | xs], condicion) do
    [condicion.(l) | map(xs, condicion)]
  end

  def intercalarSegun([], [], _), do: []

  def intercalarSegun([], [l | xs], _), do: [l | xs]

  def intercalarSegun([l | xs], [], _), do: [l | xs]

  def intercalarSegun([l | xs], [p | xd], orden) do
    cond do
      orden.(l, p) == true -> [l | intercalarSegun(xs, [p | xd], orden)]
      true -> [p | intercalarSegun([l | xs], xd, orden)]
    end
  end
end

defmodule Nivel5 do
  # ordenamiento midsort
  def minSort([]), do: []

  def minSort([l]) do
    [l]
  end

  def eliminarElemento([], _), do: []

  def eliminarElemento([l | xs], x) do
    cond do
      l == x -> xs
      true -> [l | eliminarElemento(xs, x)]
    end
  end

  def minSort(list) do
    [minimoLista(list) | minSort(eliminarElemento(list, minimoLista(list)))]
  end

  def minimoLista([l]), do: l

  def minimoLista([l | xs]) do
    cond do
      l < minimoLista(xs) -> l
      true -> minimoLista(xs)
    end
  end

  def menoresQue([l | xs], x) do
    cond do
      l <= x -> [l | menoresQue(xs, x)]
      true -> menoresQue(xs, x)
    end
  end

  def mayoresQue([l | xs], x) do
    cond do
      l > x -> [mayoresQue(xs, x) | l]
      true -> mayoresQue(xs, x)
    end
  end

  def mayoresQue([], _), do: []

  def menoresQue([], _), do: []

  def quickSort([]), do: 0

  def quickSort([l | xs]) do
  end
end

IO.inspect(Nivel5.mayoresQue([5, 3, 8, 1, 4], 4))
