defmodule GestionHotel do

  def main do
    noches =
      "Ingrese el número de noches: "
      |> Util.ingresar(:entero)

    tipo_cliente =
      "Seleccione el tipo de cliente:\n1: frecuente  2: corporativo  3: ocasional"
      |> Util.ingresar(:entero)

    temporada =
      "Seleccione la temporada:\n1: alta   2: baja"
      |> Util.ingresar(:entero)

    case calcular_total(noches, tipo_cliente, temporada) do
      {:ok, resultado} ->
        resultado
        |> mostrar_mensaje()
        |> Util.mostrar_mensaje()

      {:error, mensaje} ->
        Util.mostrar_mensaje("Error: #{mensaje}")
    end
  end


  def calcular_total(noches, tipo_cliente, temporada)
      when is_integer(noches) and noches > 0 do

    tarifa_base = tarifa_por_noche(noches)
    subtotal = tarifa_base * noches
    descuento = calcular_descuento(subtotal, tipo_cliente)
    recargo = calcular_recargo(subtotal - descuento, temporada)
    total = subtotal - descuento + recargo

    {:ok,
     %{
       tarifa_base: tarifa_base,
       subtotal: subtotal,
       descuento: descuento,
       recargo: recargo,
       total: total
     }}
  end

  def calcular_total(_, _, _),
    do: {:error, "Datos inválidos. Verifique las entradas."}


  # TARIFA BASE

  def tarifa_por_noche(noches) when noches <= 2, do: 120_000
  def tarifa_por_noche(noches) when noches <= 5, do: 100_000
  def tarifa_por_noche(noches) when noches > 5, do: 85_000

  # DESCUENTOS

  def calcular_descuento(subtotal, 1), do: subtotal * 0.20
  def calcular_descuento(subtotal, 2), do: subtotal * 0.15
  def calcular_descuento(_, 3), do: 0
  def calcular_descuento(_, _), do: 0

  # RECARGO

  def calcular_recargo(valor, 1), do: valor * 0.25
  def calcular_recargo(_, 2), do: 0
  def calcular_recargo(_, _), do: 0


  def mostrar_mensaje(resultado) do
    """
    --- Su reserva es: ---

    Tarifa base: $#{resultado.tarifa_base}
    Subtotal: $#{resultado.subtotal}
    Descuento: $#{trunc(resultado.descuento)}
    Recargo: $#{trunc(resultado.recargo)}
    TOTAL: $#{trunc(resultado.total)}
    """
  end

end

GestionHotel.main()
