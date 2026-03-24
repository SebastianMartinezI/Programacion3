defmodule SumaDivideVenceras do
  def main do
    lista = [1, 2, 3, 4, 5]

    resultado = suma(lista)

    IO.puts("Lista: #{inspect(lista)}")
    IO.puts("Suma total: #{resultado}")
  end

  # Caso base 1: lista vacía
  defp suma([]), do: 0

  # Caso base 2: un solo elemento
  defp suma([x]), do: x

  # Caso recursivo (divide y vencerás)
  defp suma(lista) do
    {izq, der} = dividir(lista)

    suma(izq) + suma(der)
  end

  # Función para dividir la lista
  defp dividir(lista) do
    mitad = div(length(lista), 2)
    Enum.split(lista, mitad)
  end
end

SumaDivideVenceras.main()
