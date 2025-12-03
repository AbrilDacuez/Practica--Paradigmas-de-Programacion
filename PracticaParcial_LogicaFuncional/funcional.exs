defmodule Parcial do
  # Parcial 02/12/2024
  # ejercicio 1: escriba una funcion que reciba una lista sin sublistas L y un numero N y devuelva una lista con los elementos de L
  # que estan en las posiciones multiplos de N.

  def cant([]), do: 0
  def cant([_ | xs]), do: 1 + cant(xs)
  # 3,4,5,6,7 2 --> 4,6

  def multiplos([],_,_), do: []
  def multiplos([l | xs], n, pos) do
    cond do
      rem(pos, n) == 0 -> [l | multiplos(xs, n,pos+1)]
      true -> multiplos(xs, n,pos+1)
    end
  end

  def mult(l,n), do: multiplos(l,n,1)

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

  # ---------------------------------------------------
  # Final 2
  # Escriba una funcion que tome como entrada una lista con sublistas L y reordene los elementos de la lista principal y cada sublista de tal manera que queden todos los numeros al principio y las listas al final (de la lista y cada sublista)

  # Ej: L = [2,8,[3,1],2,[7,3,10,[4,2],9,[1]],4]
  # Res: [2,8,2,4,[3,1],[7,3,10,9,[4,2],[1]]]

  def dejarNum([]), do: []

  def dejarNum([x | xs]) do
    cond do
      is_list(x) -> dejarNum(xs)
      true -> [x | dejarNum(xs)]
    end
  end

  def dejarListas([]), do: []

  def dejarListas([x | xs]) do
    cond do
      is_list(x) -> [x | dejarListas(xs)]
      true -> dejarListas(xs)
    end
  end

  def reordena([]), do: []

  def reordena([x | xs]) do
    cond do
      is_list(x) -> [dejarNum(reordena(x)) ++ dejarListas(reordena(x))] ++ reordena(xs)
      true -> [x | reordena(xs)]
    end
  end

  def respFinal2([]), do: []

  def respFinal2(l) do
    dejarNum(reordena(l)) ++ dejarListas(reordena(l))
  end

  # ------------------------------------------
  # Final 3
  # Escriba la funcion Coinciden, que tome como entrada una lista L de numeros (sin sublistas) y una lista M que contiene sublistas, y devuelva otra lista formada unicamente por sublistas de un solo nivel. Estas sublistas deben ser aquellas de M que incluyan todos los elementos de L en su nivel 1 (es decir, sin considerar elementos que esten dentro de sublistas).

  # Ejemplo:
  # L = [2,6]
  # M = [[6,2,[1,2],3],[8,6,4],[2,[2,2],7,5,6],[9,1,6]]
  # Resultado: [[6,2,3],[2,7,5,6]]

  def buscarElm([], []), do: false
  def buscarElm([], [_]), do: false

  def buscarElm([x | xs], [y]) do
    cond do
      x == y -> true
      true -> buscarElm(xs, [y])
    end
  end

  def buscarElm([x | xs], [y | ys]) do
    cond do
      x == y -> true && buscarElm([x | xs], ys)
      true -> buscarElm(xs, [y]) && buscarElm([x | xs], ys)
    end
  end

  def elimSubList([]), do: []

  def elimSubList([x | xs]) do
    cond do
      is_list(x) -> elimSubList(xs)
      true -> [x | elimSubList(xs)]
    end
  end

  def coinciden([], []), do: []
  def coinciden([], _), do: []

  def coinciden([x | xs], l2) do
    cond do
      buscarElm(x, l2) -> [elimSubList(x) | coinciden(xs, l2)]
      true -> coinciden(xs, l2)
    end
  end

  # -------------------------------------
  # Final 4
  # Escriba una funcion que tome como entrada una lista con sublistas anidadas L y un numero N, y devuelva la suma de todos los elementos que se encuentran exactamente en el nivel N.

  # Ej: L = [1,[2,3],[[4],5],[[[6]]]]   N = 2
  # Resultado: 2 + 3 + 5 = 10

  def sumaNivel([],_), do: 0
  # Forma en la que Pascal separa en n = 1 y n > 1
  def sumaNivel([x|xs], 1) do
    cond do
      is_list(x) -> sumaNivel(xs,1)
      true -> x + sumaNivel(xs,1)
    end
  end
  def sumaNivel([x|xs],n) do
    cond do
      is_list(x) -> sumaNivel(x, n - 1) + sumaNivel(xs,n)
      true -> sumaNivel(xs, n)
    end
  end
  # Primera forma en que la hice
  # def sumaNivel([x|xs],n) do
  #   cond do
  #     is_list(x) && (n > 1) -> sumaNivel(x, n - 1) + sumaNivel(xs,n)
  #     is_list(x) && (n == 1) -> sumaNivel(xs,1)
  #     n == 1 -> x + sumaNivel(xs, 1)
  #     true -> sumaNivel(xs, n)
  #   end
  # end

  # -----------------------------------------------------
  # Final 5
  # Escriba una funcion que tome como entrada una lista L con sublistas de la forma (legajo listaNotas) que representan los legajos de los estudiantes inscriptos en un curso y la lista de sus notas en dicho curso. Devolver el legajo del estudiante de mayor promedio. Si un estudiante no rindió ningun examen la lista de notas estará vacia, y se considera que su nota es 0.

  # Ej: L = [[1,[5,4,6]],[2,[8,7]],[3,[4]],[4,[5,9,5,3]]]
  # Resultado: 2
  # El legajo 2 tiene notas 8 y 7, con promedio 7.5)

  def sumaLista([]), do: 0
  def sumaLista([x|xs]), do: x + sumaLista(xs)

  def cantidadLista([]), do: 0
  def cantidadLista([_|xs]), do: 1 + cantidadLista(xs)

  def promedio([]), do: 0
  def promedio(l), do: sumaLista(l)/cantidadLista(l)

  # quita el leg
  def elimNum([]), do: []
  def elimNum([x|xs]) do
    cond do
       is_list(x) -> [x | elimNum(xs)]
       true -> elimNum(xs)
    end
  end

  # linealiza
  def lin([]), do: []
  def lin([x|xs]) do
    cond do
      is_list(x) -> lin(x) ++ lin(xs)
      true -> [x | lin(xs)]
    end
  end

  def estudianteMayProm([]), do: []
  def estudianteMayProm([x|xs]) do
    cond do
      promedio(lin(elimNum(x))) > promedio(lin(elimNum(estudianteMayProm(xs)))) -> x
      true -> estudianteMayProm(xs)
    end
  end

  def numEstMayProm(l), do: hd(estudianteMayProm(l))

  # -----------------------------------------
  # Parcial 06/02/2025
  # Ejercicio 2
  # Escriba la funcion que tome como entrada una lista de pares ordenados y una lista de numeros (sin sublistas), y devuelva otra lista que contenga una sublista por cada par, donde cada sublista incluya los elementos de la lista de numeros que pertenecen a la secuencia aritmetica definida por dicho par. Cada par (A,S) define una secuencia que comienza en A y aumenta en S unidades cada paso (A,A+S,A+2S,...). Si S es negativo, la sublista correspondiente debe estar vacia. Cada numero puede aparecer en multiples sublistas o en ninguna. Los elementos en cada sublista deben mantener el orden de aparicion en la lista original.

  # Ej:
  # Lista de pares:[[3,2],[6,0],[12,3],[7,1]]
  # Lista de numeros: [4,6,4,10,3,2,5]
  # Resultado: [[3,5],[6],[],[10]]
  def multAS([x,0],_,_), do: [x]
  def multAS([x,y],n,lim) do
    cond do
      y < 0 -> []
      x+(y*n) > lim -> []
      true -> [x+(y*n) | multAS([x,y],n+1,lim)]
    end
  end

  def max([x]), do: x
  def max([x|xs]) do
    cond do
      x > max(xs) -> x
      true -> max(xs)
    end
  end

  def buscarEl([],_), do: false
  def buscarEl([x|xs],e) do
    cond do
      x == e -> true
      true -> buscarEl(xs,e)
    end
  end

  def buscarSec([],_), do: []
  def buscarSec(_,[]), do: []
  def buscarSec(l,[y|ys]) do
    cond do
      buscarEl(l,y) -> [y | buscarSec(l,ys)]
      true -> buscarSec(l,ys)
    end
  end

  def listaSec([],_), do: []
  def listaSec([x|xs],l) do
    [buscarSec(multAS(x,0,max(l)),l) | listaSec(xs,l)]
  end

end

# IO.inspect(Parcial.buscarSec([7, 8, 9, 10],[4,6,4,10,3,2,5]),charlists: true)
# IO.inspect(Parcial.multAS([2,2],0,10),charlists: true)
IO.inspect(Parcial.listaSec([[2,-2],[3,2],[6,0],[12,3],[7,1]],[4,6,4,10,3,2,5]),charlists: true)
# IO.inspect(Parcial.promedio([5,9,4]),charlists: true)
# IO.inspect(tl([2,[8,7]]),charlists: true)
# IO.inspect(Parcial.estudianteMayProm([[1,[5,4,6]],[2,[8,7]],[3,[4]],[4,[10,9,9,8]]]),charlists: true)
# IO.inspect(Parcial.numEstMayProm([[1,[5,4,6]],[2,[8,7]],[3,[4]],[4,[10,9,9,8]]]),charlists: true)

# IO.inspect(Parcial.buscarElm([8,6,4],[2,6]), charlists: true)
