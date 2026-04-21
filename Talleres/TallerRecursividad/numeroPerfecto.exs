defmodule NumeroPerfecto do

  def main do
    numero = "Ingresar numero"

    |>Util.ingresar(:entero)

    if es_perfecto?(numero) do
      IO.puts("#{numero} es un número perfecto")
    else
      IO.puts("#{numero} NO es un número perfecto")
    end
  end


  def es_perfecto?(numero) when numero > 0 do
    suma = sumar_divisores(numero, 1, 0)
    suma == numero
  end

  defp sumar_divisores(numero, i, acumulador) when i >= numero do
    acumulador
  end

  defp sumar_divisores(numero, i, acumulador) do
    if rem(numero, i) == 0 do
      sumar_divisores(numero, i + 1, acumulador + i)
    else
      sumar_divisores(numero, i + 1, acumulador)
    end
  end

end

NumeroPerfecto.main()
