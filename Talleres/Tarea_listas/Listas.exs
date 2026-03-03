defmodule ListaManager do

  def main do
    lista = ["juan", 24, "Martinez"]

    nueva_lista = agregar(lista, "Ingeniero")
    IO.inspect(nueva_lista)

    lista_sin_juan = eliminar(nueva_lista, "juan")
    IO.inspect(lista_sin_juan)

    IO.puts("Tamaño:")
    IO.inspect(tamanio(lista_sin_juan))

    lista_modificada = modificar(lista_sin_juan, 0, "Robinson")
    IO.inspect(lista_modificada)

    IO.puts("Recorrido:")
    recorrer(lista_modificada)
  end


  def agregar(lista, elemento) do
    lista ++ [elemento]
  end

  def eliminar(lista, elemento) do
    List.delete(lista, elemento)
  end

  def tamanio(lista) do
    length(lista)
  end

  def modificar(lista, indice, nuevo_valor) do
    List.replace_at(lista, indice, nuevo_valor)
  end

  def recorrer(lista) do
    Enum.each(lista, fn elemento ->
      IO.puts(elemento)
    end)
  end

end

ListaManager.main()
