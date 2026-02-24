defmodule Tarifa_parqueadero do
  def main do
registro =
  "Ingrese las horas de permanencia: "
  |>Util.ingresar(:entero)

  "Ingrese tipo de cliente :\n
  1: Frecuente , 2: regular"
  |>Util.ingresar(:entero)

  "Ingrese tipo de vehículo :\n
  1: Eléctrico , 2: Convencional"
  |>Util.ingresar(:entero)

  "Ingrese tipo de día :\n
  1: Fin de semana , 2: Entre Semana"
  |>Util.ingresar(:entero)
end

defp obtener_descuento do
  
end
end
