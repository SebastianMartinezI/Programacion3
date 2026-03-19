defmodule Inventario do

  @moduledoc """
  Sistema de inventario de ropa por consola.
  Maneja referencias con talla, precio, colores y unidades por color.
  """

  def main do

    #crea un mapa vacio y guarda los datos
    inventario = %{} 
    menu(inventario)
  end

  # Menu principal del inventario

  defp menu(inventario) do

    Util.mostrar_mensaje("\n... INVENTARIO DE ROPA ...")
    Util.mostrar_mensaje("1. Agregar referencia")
    Util.mostrar_mensaje("2. Ver todas las referencias")
    Util.mostrar_mensaje("3. Buscar referencia")
    Util.mostrar_mensaje("4. Actualizar referencia")
    Util.mostrar_mensaje("5. Eliminar referencia")
    Util.mostrar_mensaje("6. Salir")

    opcion = "Seleccione una opción: "
    |> Util.ingresar(:entero)

    case opcion do

      # llama a agregar() que devuelve un inventario nuevo y ese resultado se lo pasa a menu() para volver al menu
      1 -> inventario |> agregar()    |> menu()
      2 -> inventario |> ver_todos()
           menu(inventario)
      3 -> inventario |> buscar()
           menu(inventario)
      4 -> inventario |> actualizar() |> menu()
      5 -> inventario |> eliminar()   |> menu()
      6 -> Util.mostrar_mensaje("Has salido del inventario")
      _ -> Util.mostrar_mensaje("Opción inválida")
           menu(inventario)
    end
  end

  # Funcion de agregar una prenda al inventario
  defp agregar(inventario) do
    referencia = "Nombre de la referencia: "
    |> Util.ingresar(:texto)

    talla = "Talla (unica/xs/s/m/l/xl): "
    |> Util.ingresar(:texto)
    |> String.downcase()

    precio = "Precio: "
    |> Util.ingresar(:entero)

    # Pide los colores y por cada uno pide las unidades
    # Se guarda como mapa %{"rojo" => 5, "azul" => 3}
    colores = "Colores disponibles (separados por coma): "
    |> Util.ingresar(:texto)
    |> String.split(",")
    |> Enum.map(&String.trim/1)
    |> ingresar_unidades_color()

    producto = {referencia, talla, precio, colores}

    inventario_actualizado = Map.put(inventario, referencia, producto)
    Util.mostrar_mensaje("Referencia agregada exitosamente")
    inventario_actualizado
  end

  # Recorre cada color y pide sus unidades
  # Retorna un mapa %{color => unidades}
  defp ingresar_unidades_color(colores) do
    Enum.reduce(colores, %{}, fn color, acc ->
      unidades = "Unidades para el color #{color}: "
      |> Util.ingresar(:entero)
      Map.put(acc, color, unidades)
    end)
  end

  # Funcion de listar todas las referencias de prendas

  defp ver_todos(inventario) do
    case map_size(inventario) == 0 do
      true ->
        Util.mostrar_mensaje("No hay referencias en el inventario")
      false ->
        Util.mostrar_mensaje("\n... REFERENCIAS ...")
        Enum.each(inventario, fn {_clave, producto} ->
          mostrar_producto(producto)
        end)
    end
  end

  # Funcion de buscar una referencia en el inventario

  defp buscar(inventario) do
    referencia = "Nombre de la referencia a buscar: "
    |> Util.ingresar(:texto)

    case Map.get(inventario, referencia) do
      nil      -> Util.mostrar_mensaje("Referencia no encontrada")
      producto -> mostrar_producto(producto)
    end
  end

  # Funcion de actualizar una referencia del inventario

  defp actualizar(inventario) do
    referencia = "Nombre de la referencia a actualizar: "
    |> Util.ingresar(:texto)

    case Map.get(inventario, referencia) do
      nil ->
        Util.mostrar_mensaje("Referencia no encontrada")
        inventario

      {ref, talla, precio, colores} ->
        Util.mostrar_mensaje("¿Qué desea actualizar?")
        Util.mostrar_mensaje("1. Talla")
        Util.mostrar_mensaje("2. Precio")
        Util.mostrar_mensaje("3. Colores y unidades")
        Util.mostrar_mensaje("4. Unidades de un color existente")

        opcion = "Seleccione: "
        |> Util.ingresar(:entero)

        producto_actualizado = case opcion do
          1 ->
            nueva_talla = "Nueva talla (unica/xs/s/m/l/xl): "
            |> Util.ingresar(:texto)
            |> String.downcase()
            {ref, nueva_talla, precio, colores}

          2 ->
            nuevo_precio = "Nuevo precio: "
            |> Util.ingresar(:entero)
            {ref, talla, nuevo_precio, colores}

          3 ->
            nuevos_colores = "Nuevos colores (separados por coma): "
            |> Util.ingresar(:texto)
            |> String.split(",")
            |> Enum.map(&String.trim/1)
            |> ingresar_unidades_color()
            {ref, talla, precio, nuevos_colores}

          4 ->
            color = "Color a actualizar: "
            |> Util.ingresar(:texto)
            |> String.trim()

            case Map.get(colores, color) do
              nil ->
                Util.mostrar_mensaje("Color no encontrado")
                {ref, talla, precio, colores}

              _ ->
                nuevas_unidades = "Nuevas unidades para #{color}: "
                |> Util.ingresar(:entero)
                colores_actualizados = Map.put(colores, color, nuevas_unidades)
                {ref, talla, precio, colores_actualizados}
            end

          _ ->
            Util.mostrar_mensaje("Opción inválida")
            {ref, talla, precio, colores}
        end

        Util.mostrar_mensaje("Referencia actualizada exitosamente")
        Map.put(inventario, referencia, producto_actualizado)
    end
  end

  # Funcion de eliminar una referencia del inventario

  defp eliminar(inventario) do
    referencia = "Nombre de la referencia a eliminar: "
    |> Util.ingresar(:texto)

    case Map.get(inventario, referencia) do
      nil ->
        Util.mostrar_mensaje("Referencia no encontrada")
        inventario

      _ ->
        inventario_actualizado = Map.delete(inventario, referencia)
        Util.mostrar_mensaje("Referencia eliminada exitosamente")
        inventario_actualizado
    end
  end

  # Funcion de mostrar una referencia del inventario

  defp mostrar_producto({referencia, talla, precio, colores}) do
    Util.mostrar_mensaje("---------------------------")
    Util.mostrar_mensaje("Referencia : #{referencia}")
    Util.mostrar_mensaje("Talla      : #{talla}")
    Util.mostrar_mensaje("Precio     : $#{precio}")
    Util.mostrar_mensaje("Colores y unidades:")
    Enum.each(colores, fn {color, unidades} ->
      Util.mostrar_mensaje("  #{color}: #{unidades} unidades")
    end)
  end

end

Inventario.main()
