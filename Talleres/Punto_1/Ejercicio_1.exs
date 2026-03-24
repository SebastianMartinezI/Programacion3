defmodule Ejercicio1 do

  def procesar(lista) do
    lista
    |> Enum.map(&(String.upcase(&1)))
    |> Enum.filter(fn w -> String.length(w) > 4 end)
    |> Enum.map(fn cadena -> String.reverse(cadena) end)
    |> Enum.sort()
    |> Enum.take(3)
    |> Enum.join(" - ")
  end

  def main do
    resultado =
      procesar(["Elixir", "es", "un", "lenguaje", "funcional", "muy", "poderoso"])

    IO.puts(resultado)
  end

end

Ejercicio1.main()
