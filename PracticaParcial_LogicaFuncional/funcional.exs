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
  # Parcial 06/02/2025
#  Ejercio 1: esriba la función (predicado) que tome como entrada una lista con sublistas de un sólo nivel y una posición P
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


  # Ejercicio 2: Escriba la función (predicado) que tome como entrada una lista de pares ordenados y una lista de números (sin sublistas)
  #y devuelva otra lista que contenga una sublista por cada par, donde cada sublista incluya
  #los elementos de la lista de números que pertenecen a la secuencia aritmética definida por dicho par.
  #Cada par (A, S) define una secuencia que comienza en A y aumenta en S unidades cada paso (A, A+S, A+2S, ...).
  #Si S es negativo, la sublista correspondiente debe estar vacía.
  #Cada número puede aparecer en múltiples sublistas o en ninguna.
  #Los elementos en cada sublista deben mantener el orden de aparición en la lista original. [60 puntos]
  #Ejemplo:
  #Lista de pares: ((3 2) (6 0) (12 3) (7 1))
  #(3,2) -> 3,5,7,9,11,13
  #Lista de números: (4 6 4 10 3 2 5)
  #Resultado: ((3 5) (6) () (10))

def pertenecesecuencia(base,0,_i,num) do
base==num
end
def pertenecesecuencia(base,inc,i,num) do
cond do
base+inc*i>num -> false
base+inc*i==num -> true
true -> pertenecesecuencia(base,inc,i+1,num)
end
end
def parensecuencia([_b,_s], []), do: []
def parensecuencia([b,s], [p|r]) do
    cond do
        s < 0 -> []
pertenecesecuencia(b,s,0,p) -> [p|parensecuencia([b,s],r)]
true -> parensecuencia([b,s],r)
end
end
def secuencias([],[_p|_r]), do: []
def secuencias([par|res],[p|r]) do
   cond do
true -> [parensecuencia(par, [p|r]) | secuencias(res, [p|r])]
end
end

end

IO.inspect(Parcial.lisSumIes([[2,3],[[4,5],6],[7,[8,[9]]],3]),charlists: true)
IO.inspect(Parcial.lisSumIes([1,[2,3],[[4,5],6],[7,[8,[9]]],3]),charlists: true)
IO.inspect(Parcial.lisSumIes([1,[2,3],[[4,5],6],[7,[8,[9]]]]),charlists: true)
IO.inspect(Parcial.lisSumIes([[2,3],[[4,5],6],2,[7,[8,[9]]]]),charlists: true)
