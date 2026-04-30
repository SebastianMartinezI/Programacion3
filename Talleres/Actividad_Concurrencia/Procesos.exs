defmodule MatrizProcesos do

  def main do
    matriz = [
      [60, 22, 41, 5],
      [13, 33, 44, 5],
      [89, 10, 100, 99],
      [5, 101, 6, 34]
    ]

    # t1 → suma debajo diagonal
    t1 = Task.async(fn -> suma_debajo_diagonal(matriz, 0) end)

    # t2 → promedio total
    t2 = Task.async(fn -> promedio_matriz(matriz) end)

    # esperar resultados
    a = Task.await(t1)
    b = Task.await(t2)

    #  s3
    c = a * b

    #  s4
    IO.puts("Resultado final C = #{c}")
  end

  # s1: SUMA DEBAJO DIAGONAL

  def suma_debajo_diagonal([], _i), do: 0

  def suma_debajo_diagonal([fila | resto], i) do
    suma_fila =
      fila
      |> Enum.with_index()
      |> Enum.filter(fn {_valor, j} -> j < i end)
      |> Enum.map(fn {valor, _} -> valor end)
      |> Enum.sum()

    suma_fila + suma_debajo_diagonal(resto, i + 1)
  end

  # s2: PROMEDIO

  def promedio_matriz(matriz) do
    lista = List.flatten(matriz)

    suma = Enum.sum(lista)
    cantidad = Enum.count(lista)

    suma / cantidad
  end

end

MatrizProcesos.main()
