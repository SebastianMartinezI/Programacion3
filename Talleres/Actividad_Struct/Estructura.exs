defmodule Estructuras do
  def main do
    "Ingrese los datos del cliente: "
    |> Cliente.ingresar(:clientes)
    |> Cliente.generar_mensaje_clientes(&generar_mensaje/1)
    |> Util.mostrar_mensaje()
  end
  def generar_mensaje(cliente) do
    altura = cliente.altura |> Float.round(2)
    "Hola #{cliente.nombre}, tu edad es de #{cliente.edad} años y " <>
  "tienes una altua de #{altura} \n"
  end
  defp generar_mensaje_clientes(lista_clientes) do
    lista_clientes
    |> Enum.map(&generar_mensaje/1)
    |> Enum.join()
  end
end
Estructuras.main()
