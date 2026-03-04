defmodule Aerolinea do
  def main do
    destino =
      "Seleccione destino:\n1: bogota\n2: medellin\n3: cartagena\n4: san andres"
      |> Util.ingresar(:entero)
      |> convertir_destino()

    silla =
      "¿Desea selección de silla? (1: sí  2: no)"
      |> Util.ingresar(:entero)

    maleta =
      "¿Desea maleta de bodega? (1: sí  2: no)"
      |> Util.ingresar(:entero)

    seguro =
      "¿Desea seguro de viaje? (1: sí  2: no)"
      |> Util.ingresar(:entero)

    {total, mensaje_extra} =
      calcular_total(destino, silla, maleta, seguro)

    mensaje =
      """
      --- RESUMEN DE COMPRA ---

      Destino: #{destino}
      Total a pagar: $#{total}
      #{mensaje_extra}
      """

    Util.mostrar_mensaje(mensaje)
  end

  # CONVERSIÓN DESTINO

  def convertir_destino(1), do: :bogota
  def convertir_destino(2), do: :medellin
  def convertir_destino(3), do: :cartagena
  def convertir_destino(4), do: :san_andres
  def convertir_destino(_), do: :bogota

  # TARIFAS BASE

  def tarifa_base(:bogota), do: 120_000
  def tarifa_base(:medellin), do: 150_000
  def tarifa_base(:cartagena), do: 200_000
  def tarifa_base(:san_andres), do: 300_000

  # CARGOS ADICIONALES

  def cargo_silla(1), do: 15_000
  def cargo_silla(_), do: 0

  def cargo_maleta(1), do: 45_000
  def cargo_maleta(_), do: 0

  def cargo_seguro(1), do: 12_000
  def cargo_seguro(_), do: 0

  # CÁLCULO TOTAL

  def calcular_total(destino, silla, maleta, seguro) do
    base = tarifa_base(destino)
    silla_cargo = cargo_silla(silla)
    seguro_cargo = cargo_seguro(seguro)

    {maleta_cargo, mensaje_extra} =
      aplicar_regla_maleta(destino, maleta)

    total = base + silla_cargo + maleta_cargo + seguro_cargo

    {total, mensaje_extra}
  end

  # REGLA ESPECIAL

  def aplicar_regla_maleta(destino, _) when destino == :san_andres do
    {45000, "La maleta fue agregada automáticamente por destino."}
  end

  def aplicar_regla_maleta(_, maleta) do
    {cargo_maleta(maleta), ""}
  end

end

Aerolinea.main()
