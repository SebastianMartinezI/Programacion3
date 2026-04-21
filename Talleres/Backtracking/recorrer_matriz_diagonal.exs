defmodule MatrizRecursiva do

  def main do
    matriz = [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9]
    ]

    IO.puts("Diagonal principal:")
    diagonal(matriz, 0)
  end

  # CASO BASE
  def diagonal([], _indice), do: :ok

  # CASO RECURSIVO
  def diagonal([fila | resto], indice) do
    valor = Enum.at(fila, indice)
    IO.puts(valor)

    diagonal(resto, indice + 1)
  end

end

MatrizRecursiva.main()
