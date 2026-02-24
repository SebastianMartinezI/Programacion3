defmodule Saludo_hora do
  def main do
nombre =
    "Ingrese el nombre de la persona"
    |>Util.ingresar(:texto)

  {hora, minuto, _seg} = Util.hora_actual()
    generar_mensaje(nombre, hora, minuto)
    |>Util.mostrar_mensaje()
  end

  defp generar_mensaje(nombre, hora, minuto) do
    saludo =
      cond do
        hora >= 0 and hora < 12 -> "Buenos días"
        hora >= 12 and hora <18 -> "Buenas tardes"
        hora >= 18 and hora <=23 -> "Buenas noches"
      end

    "#{hora}:#{minuto}: #{saludo} #{nombre}"
    end
end

Saludo_hora.main()
