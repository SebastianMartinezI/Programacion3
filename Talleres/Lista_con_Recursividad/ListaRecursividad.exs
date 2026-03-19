defmodule ListaRecursiva do

  def main do
    n = "Ingrese un número: "
    |> Util.ingresar(:entero)

    lista = crear_lista(n)

    IO.inspect(lista)
  end

  def crear_lista(0) do
    []
  end

  def crear_lista(n) when n > 0 do
    crear_lista(n - 1) ++ [n]
  end

end

ListaRecursiva.main()
