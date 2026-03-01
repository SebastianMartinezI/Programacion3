defmodule Parqueadero do

  def main do
    horas =
      "Ingrese las horas de permanencia:"
      |> Util.ingresar(:entero)

    tipo_cliente =
      "Tipo de cliente (1=frecuente, 2=regular):"
      |> Util.ingresar(:entero)

    tipo_vehiculo =
      "Tipo de vehículo (1=eléctrico, 2=convencional):"
      |> Util.ingresar(:entero)

    tipo_dia =
      "Día (1=fin de semana, 2=entre semana):"
      |> Util.ingresar(:entero)

    tarifa_base = calcular_tarifa_base(horas)

    porcentaje_descuento =
      calcular_descuento(tipo_cliente, tipo_vehiculo, tipo_dia)

    {valor_sin_descuento, valor_con_descuento} =
      aplicar_descuento(tarifa_base, porcentaje_descuento)

    generar_mensaje(horas, valor_sin_descuento, porcentaje_descuento, valor_con_descuento)
    |>Util.mostrar_mensaje()
  end

  # Calcular tarifa base

  def calcular_tarifa_base(horas) do
    cond do
      horas <= 2 ->
        3000

      horas <= 5 ->
        3000 + (horas - 2) * 2500

      horas <= 8 ->
        3000 + (3 * 2500) + (horas - 5) * 2000

      horas > 8 ->
        18000
    end
  end

  # Calcular porcentaje total

  def calcular_descuento(tipo_cliente, tipo_vehiculo, tipo_dia) do
    descuento_cliente =
      if tipo_cliente == 1, do: 0.15, else: 0

    descuento_vehiculo =
      if tipo_vehiculo == 1, do: 0.20, else: 0

    descuento_dia =
      if tipo_dia == 1, do: 0.10, else: 0

    descuento_cliente + descuento_vehiculo + descuento_dia
  end

  # Aplicar descuento

  def aplicar_descuento(tarifa_base, porcentaje) do
    descuento = tarifa_base * porcentaje
    valor_final = tarifa_base - descuento

    {tarifa_base, trunc(valor_final)}
  end

    # Mostrar resultado

  defp generar_mensaje(horas, base, porcentaje, final) do
    IO.puts("\n--- DESGLOSE ---")
    IO.puts("Horas: #{horas}")
    IO.puts("Tarifa base: $#{base}")
    IO.puts("Descuento aplicado: #{porcentaje * 100}%")
    IO.puts("Valor final a pagar: $#{final}")
  end

end

Parqueadero.main()
