defmodule Simulacion do

  def main do
    n = "Ingrese la cantidad de Matrushka: "
    |> Util.ingresar(:entero)

    imprimirMatrushka(n)
  end

 
  def imprimirMatrushka(0) do
    IO.puts("No hay más muñecas")
  end


  def imprimirMatrushka(n) when n > 0 do
    IO.puts("Abriendo matrushka #{n}")
    imprimirMatrushka(n - 1)
    IO.puts("Cerrando matrushka #{n}")
  end

end

Simulacion.main()
