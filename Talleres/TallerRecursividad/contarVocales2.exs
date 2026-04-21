defmodule ContarVocalesCharlist do

  def main do
    texto = "Hola amigo"

    cantidad = contar_vocales(texto)

    IO.puts("Cantidad de vocales: #{cantidad}")
  end

  def contar_vocales(texto) do
    texto
    |> String.downcase()
    |> to_charlist()
    |> contar()
  end

  defp contar([]), do: 0

  defp contar([cabeza | cola]) when cabeza in 'aeiou' do
    1 + contar(cola)
  end

  defp contar([_cabeza | cola]) do
    contar(cola)
  end

end

ContarVocalesCharlist.main()
