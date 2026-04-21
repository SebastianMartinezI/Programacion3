defmodule Estructuras3 do
  def main do
    "Docentes_uniquindio_20252104.csv"
    |> CSV.leer_csv(&Docente.convertir_cadena_docente/1)
    |> Enum.filter(&(&1.formacion == "MAESTRIA" and &1.vinculacion == "PLANTA"))
    |> Docente.generar_mensaje_docente(&generar_mensaje/1)
    |> CSV.generar_mensaje_csv(&generar_mensaje())
    |> Util.mostrar_mensaje()
  end

  defp generar_mensaje(docente) do
    "#{docente.periodo}, #{docente.formacion}, #{docente.vinculacion}"
  end
end

Estructuras3.main()
