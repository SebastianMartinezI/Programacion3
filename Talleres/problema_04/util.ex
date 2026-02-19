defmodule Util do
  def mostrar_mensaje(mensaje) do
    mensaje = to_string(mensaje)
    System.cmd("java", ["-cp", ".", "Mensaje", mensaje])
  end

def mostrar_error(mensaje) do
  IO.puts(:standard_error, mensaje)
end


def ingresar(mensaje, :texto) do
  # Llama al programa Java para ingresar texto y capturar la entrada
  case System.cmd("java", ["-cp", ".", "Mensaje", "input", mensaje]) do
    {output, 0} ->
        IO.puts("Texto ingresado correctamente.")
        IO.puts("Entrada: #{output}")
        String.trim(output) # Retorna la entrada son espacios extra
    {error, code} ->
      IO.puts("Error al ingresar el texto. Codigo: #{code}")
      IO.puts("Detalles: #{error}")
      nil
  end
end


def ingresar(mensaje, :entero) do
  ingresar(
    mensaje,
    &String.to_integer/1,
    :entero
    )
  end

  def ingresar(mensaje, :real) do
  ingresar(
    mensaje,
    &String.to_float/1,
    :real
  )
  end

  defp ingresar(mensaje, parser, tipo_dato) do
    try do
      mensaje
      |> ingresar(:texto)
      |> parser.()
    rescue
      ArgumentError ->
        "Error, se espera que ingrese un número #{tipo_dato}\n"
        |>mostrar_error()

        mensaje
        |>ingresar(parser, tipo_dato)

    end
  end
end
