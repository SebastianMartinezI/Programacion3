defmodule ContarVocales do
  def main do
    texto = "Hola amigo"

    cantidad = contar_vocales (texto)

    IO.puts("La cantidad de vocales son : #{cantidad}")
  end

  def contar_vocales (texto) do
    texto
    |>String.downcase()
    |>String.graphemes()
    |>contarLista()
  end

  defp contarLista([]), do: 0

  defp contarLista([cabeza | cola]) when cabeza in ["a", "e", "i", "o", "u"] do
    1 + contarLista(cola)
  end

  defp contarLista([_cabeza | cola]) do
    contarLista(cola)
  end

  # Funcion sin String.graphemes

  
end
ContarVocales.main()
