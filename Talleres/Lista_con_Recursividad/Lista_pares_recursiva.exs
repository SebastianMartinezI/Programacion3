defmodule Lista do

  def main do
    n =
      "Ingrese un número: "
      |> Util.ingresar(:entero)

    lista = crear_lista(n)

    IO.puts("Lista completa:")
    IO.inspect(lista)

    lista_pares = pares(lista)

    IO.puts("Números pares:")
    IO.inspect(lista_pares)
  end

  
  def crear_lista(0), do: []

  def crear_lista(n) when n > 0 do
    crear_lista(n - 1) ++ [n]
  end


  def pares([]), do: []


  def pares([h | t]) do
    if rem(h, 2) == 0 do
      [h | pares(t)]
    else
      pares(t)
    end
  end

end

Lista.main()
