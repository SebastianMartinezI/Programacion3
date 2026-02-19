defmodule EntradaEnteros do
  def main do
    valor_total = "Ingrese valor total de la factura: "
    |> Util.ingresar(:entero)

    valor_entregado = "Ingrese valor entregado para el pago: "
    |> Util.ingresar(:entero)

    calcular_devuelta(valor_entregado, valor_total)
    |> general_mensaje()
    |> Util.mostrar_mensaje()
  end

  defp calcular_devuelta(valor_pago, valor_total) do
    valor_pago - valor_total
  end
  defp general_mensaje(devuelta) do
    "El valor de devuelta es $ #{devuelta}"
  end
end
EntradaEnteros.main()
