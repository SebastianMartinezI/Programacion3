defmodule Estructuras1 do
  def main do
    "\nIngrese los datos del cliente: "
    |> Cliente.ingresar(:clientes)
    |> Cliente.escribir_csv("clientes.csv")
  end

  defp crear_lista_clientes() do
    [
      Cliente.crear("Ana", 16, 1.70),
      Cliente.crear("Juan", 20, 1.72),
      Cliente.crear("Diana", 48, 1.71),
      Cliente.crear("Julian", 51, 1.73),
      Cliente.crear("Isabella", 6, 1.00),
      Cliente.crear("Sara", 8, 1.30),
    ]
  end
end
Estructuras1.main()
