defmodule Util do

  def mostrar_mensaje(mensaje) do
    mensaje
    |> IO.puts()
  end

  def ingresar(mensaje, :texto) do
    mensaje
    |> IO.gets()
    |> String.trim()
  end

  def ingresar(mensaje, :entero) do
    try do
      mensaje
      |> ingresar(:texto)
      |> String.to_integer()
    rescue
      ArgumentError ->
        "❌ Error, se espera que ingrese un numero entero \n"
        |> mostrar_error()

        mensaje
        |> ingresar(:entero)
    end
  end

  def ingresar(mensaje, :boolean) do
    respuesta =
      mensaje
      |> ingresar(:texto)
      |> String.upcase()

    case respuesta do
      "S" -> true
      "N" -> false
      _ ->
        "❌ Error, ingrese S o N \n"
        |> mostrar_error()

        mensaje
        |> ingresar(:boolean)
    end
  end

  def mostrar_error(mensaje) do
    IO.puts(:standard_error, IO.ANSI.red() <> mensaje <> IO.ANSI.reset())
  end
end
