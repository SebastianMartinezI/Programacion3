defmodule MatrizRecursiva do
  def recorrer_matriz([]), do: :ok

  def recorrer_matriz([fila | resto_filas]) do
    recorrer_fila(fila)
    IO.puts("")   # Salto de línea después de cada fila
    recorrer_matriz(resto_filas)
  end

  def recorrer_fila([]), do: :ok

  def recorrer_fila([elemento | resto]) do
    IO.write("#{elemento} ")
    recorrer_fila(resto)
  end
end

matriz = [
  [1, 2, 3],
  [4, 5, 6],
  [7, 8, 9]
]

MatrizRecursiva.recorrer_matriz(matriz)
