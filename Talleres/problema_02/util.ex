defmodule Util do
  def mostrar_mensaje(mensaje) do
    System.cmd("java", ["-cp", ".", "Mensaje", mensaje])
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
end
