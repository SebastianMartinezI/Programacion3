defmodule Cliente do
  defstruct nombre: "", edad: 0, altura: 0.0

  def crear(nombre, edad, altura) do
    %Cliente{nombre: nombre, edad: edad, altura: altura}
  end

  def ingresar(mensaje) do
    mensaje
    |> Util.mostrar_mensaje()
    nombre = "Ingrese nombre: "
    |> Util.ingresar(:texto)
    edad = "Ingresar edad: "
    |> Util.ingresar(:entero)
    altura = "Ingresar la altura: "
    |> Util.ingresar(:real)
    crear(nombre, edad, altura)
  end
  def ingresar(mensaje, :clientes) do
    mensaje|> ingresar([], :clientes)
  end
  defp ingresar(mensaje, lista, :clientes) do
    cliente =
      mensaje
      |> ingresar()

      nueva_lista = lista ++ [cliente]

      mas_clientes =
        "\nIngresar más clientes (s/n): "
        |> Util.ingresar(:boolean)

        case mas_clientes do
          true ->
            mensaje
            |> ingresar(nueva_lista, :clientes)

          false ->
            nueva_lista
        end
  end
  def generar_mensaje_clientes(lista_clientes, parser) do
    lista_clientes
    |> Enum.map(parser)
    |> Enum.join("\n")
  end

  def escribir_csv(clientes, nombre) do
    clientes
    |> generar_mensaje_clientes(&convertir_cliente_linea_csv/1)
    |> (&("\nnombre, edad, altura\n"<> &1)).() #adiciona los titulos
    |> (&File.write(nombre, &1, [:append])).()
  end

  defp convertir_cliente_linea_csv(cliente) do
    "#{cliente.nombre},#{cliente.edad}, #{cliente.altura}"
  end

  def leer_csv(nombre) do
    nombre
    |> File.stream!()
    |> Stream.drop(1) # ignora los encabezados
    |> Enum.map(&convertir_cadena_cliente/1)
  end

  depp convertir_cadena_cliente(cadena) do
    [nombre, edad, altura] =
      cadena
      |> String.split(",")
      |> Enum.map(&String.trimp/1)

      edad = edad |> String.to_integer()
      altura= altura |> String.to_float()

      Cliente.crear(nombre, edad, altura)
  end
end
