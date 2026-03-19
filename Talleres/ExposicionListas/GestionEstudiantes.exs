defmodule SistemaEstudiantes do

  def main do
    estudiantes = []
    menu(estudiantes)
  end

  # MENÚ PRINCIPAL

  def menu(estudiantes) do
  IO.puts("""
  ===== SISTEMA DE ESTUDIANTES =====

  1. Crear estudiante
  2. Listar estudiantes
  3. Buscar estudiante
  4. Actualizar estudiante
  5. Eliminar estudiante
  6. Contar Estudiantes
  7. Salir
  """)

  opcion =
    IO.gets("Seleccione una opción: ")
    |> String.trim()
    |> String.to_integer()

  case opcion do
    1 ->
      nuevos = crear(estudiantes)
      menu(nuevos)

    2 ->
      listar(estudiantes)
      menu(estudiantes)

    3 ->
      case buscar(estudiantes) do
        {:ok, estudiante} ->
          IO.puts("Estudiante encontrado:")
          IO.inspect(estudiante)

        {:error, mensaje} ->
          IO.puts(mensaje)
      end

      menu(estudiantes)

    4 ->
      nuevos = actualizar(estudiantes)
      menu(nuevos)

    5 ->
      nuevos = eliminar(estudiantes)
      menu(nuevos)

    6 ->
      contar_estudiantes = contar(estudiantes)

    7 ->
      IO.puts("Saliendo del sistema...")

    _ ->
      IO.puts("Opción inválida")
      menu(estudiantes)
  end
end

  # CREAR ESTUDIANTE

  def crear(estudiantes) do
  id =
    IO.gets("Ingrese ID: ")
    |> String.trim()
    |> String.to_integer()

  if id_existe?(estudiantes, id) do
    IO.puts("Ya existe un estudiante con ese ID")
    estudiantes
  else
    nombre =
      IO.gets("Ingrese nombre: ")
      |> String.trim()

    edad =
      IO.gets("Ingrese edad: ")
      |> String.trim()
      |> String.to_integer()

    promedio =
      IO.gets("Ingrese promedio: ")
      |> String.trim()
      |> String.to_float()

    estudiante = %{
      id: id,
      nombre: nombre,
      edad: edad,
      promedio: promedio
    }

    estudiantes ++ [estudiante]
  end
end
  def id_existe?(estudiantes, id) do
  Enum.any?(estudiantes, fn est ->
    est.id == id
  end)
end

  # LISTAR ESTUDIANTES

  def listar(estudiantes) do
    if estudiantes == [] do
      IO.puts("No hay estudiantes registrados")
    else
      Enum.each(estudiantes, fn est ->
        IO.inspect(est)
      end)
    end
  end

  # BUSCAR ESTUDIANTES

  def buscar(estudiantes) do
  id =
    IO.gets("Ingrese ID del estudiante: ")
    |> String.trim()
    |> String.to_integer()

  resultado =
    Enum.find(estudiantes, fn est ->
      est.id == id
    end)

  case resultado do
    nil ->
      {:error, "Estudiante no encontrado"}

    estudiante ->
      {:ok, estudiante}
  end
end

  # ACTUALIZAR ESTUDIANTES

  def actualizar(estudiantes) do
    id =
      IO.gets("Ingrese ID del estudiante a actualizar: ")
      |> String.trim()
      |> String.to_integer()

    nuevo_nombre =
      IO.gets("Nuevo nombre: ")
      |> String.trim()

    Enum.map(estudiantes, fn est ->
      if est.id == id do
        %{est | nombre: nuevo_nombre}
      else
        est
      end
    end)
  end

  # ELIMINAR ESTUDIANTES

  def eliminar(estudiantes) do
    id =
      IO.gets("Ingrese ID del estudiante a eliminar: ")
      |> String.trim()
      |> String.to_integer()

    Enum.reject(estudiantes, fn est ->
      est.id == id
    end)
  end

  #CONTAR NUMERO DE ESTUDIANTES

  def contar(estudiantes) do
  total = Enum.count(estudiantes)
  IO.puts("Total de estudiantes registrados: #{total}")
  end

end

SistemaEstudiantes.main()
