defmodule CamposComillas do
  def main do
    "\"Gomez, Ana Maria\", 16, 1.7"
    |>obtener_campos_ignorando()
    |>Enum.map(&IO.puts/1)
  end

  defp obtener_campo_ignorando_comillas(cadena) do
    expresion_regular = ~r/,(?=(?:[^"]*"[^"]*")*[^"]*$)/

    Regex.split(expresion_regular, cadena)
  end
end

CampoComillas.main()
