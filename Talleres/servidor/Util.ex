defmodule Util do
  def mostrar_mensaje (mensaje)do
    IO.puts(mensaje)
  end

    defp mostrar_error(mensaje) do
    mensaje
    |> IO.puts()
  end
end
