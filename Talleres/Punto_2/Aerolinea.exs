defmodule VuelosFunciones do

  def main do
    vuelos = [
      %{codigo: "AV201", aerolinea: "Avianca", origen: "BOG", destino: "MDE", duracion: 45, precio: 180_000, pasajeros: 120, disponible: true},
      %{codigo: "LA305", aerolinea: "Latam", origen: "BOG", destino: "CLO", duracion: 55, precio: 210_000, pasajeros: 98, disponible: true},
      %{codigo: "AV410", aerolinea: "Avianca", origen: "MDE", destino: "CTG", duracion: 75, precio: 320_000, pasajeros: 134, disponible: false},
      %{codigo: "VV102", aerolinea: "Viva Air", origen: "BOG", destino: "BAQ", duracion: 90, precio: 145_000, pasajeros: 180, disponible: true},
      %{codigo: "LA512", aerolinea: "Latam", origen: "CLO", destino: "CTG", duracion: 110, precio: 480_000, pasajeros: 76, disponible: false},
      %{codigo: "AV330", aerolinea: "Avianca", origen: "BOG", destino: "CTG", duracion: 135, precio: 520_000, pasajeros: 155, disponible: true},
      %{codigo: "VV215", aerolinea: "Viva Air", origen: "MDE", destino: "BOG", duracion: 50, precio: 130_000, pasajeros: 190, disponible: true},
      %{codigo: "LA620", aerolinea: "Latam", origen: "BOG", destino: "MDE", duracion: 145, precio: 390_000, pasajeros: 112, disponible: true},
      %{codigo: "AV505", aerolinea: "Avianca", origen: "CTG", destino: "BOG", duracion: 120, precio: 440_000, pasajeros: 143, disponible: false},
      %{codigo: "VV340", aerolinea: "Viva Air", origen: "BAQ", destino: "BOG", duracion: 85, precio: 160_000, pasajeros: 175, disponible: true}
    ]

    IO.puts("\n1️⃣ Códigos disponibles:")
    IO.inspect(codigos_disponibles(vuelos))

    IO.puts("\n2️⃣ Pasajeros por aerolínea:")
    IO.inspect(pasajeros_por_aerolinea(vuelos))

    IO.puts("\n3️⃣ Formato vuelos:")
    IO.inspect(formatear_vuelos(vuelos))

    IO.puts("\n4️⃣ Vuelos baratos (<400000):")
    IO.inspect(vuelos_baratos(vuelos, 400_000))

    IO.puts("\n5️⃣ Aerolíneas completas:")
    IO.inspect(aerolineas_completas(vuelos))

    IO.puts("\n6️⃣ Rutas más rentables:")
    IO.inspect(rutas_rentables(vuelos))
  end

  # FUNCIONES (igual a las tuyas)

  def codigos_disponibles(vuelos) do
    vuelos
    |> Enum.filter(& &1.disponible)
    |> Enum.map(& &1.codigo)
    |> Enum.sort()
  end

  def pasajeros_por_aerolinea(vuelos) do
    vuelos
    |> Enum.group_by(& &1.aerolinea)
    |> Enum.map(fn {aerolinea, lista} ->
      total =
        lista
        |> Enum.map(& &1.pasajeros)
        |> Enum.sum()

      {aerolinea, total}
    end)
  end

  def formatear_vuelos(vuelos) do
    vuelos
    |> Enum.map(fn v ->
      horas = div(v.duracion, 60)
      minutos = rem(v.duracion, 60)

      minutos_formateados =
        if minutos < 10, do: "0#{minutos}", else: "#{minutos}"

      "#{v.codigo} — #{v.origen} → #{v.destino}: #{horas}h #{minutos_formateados}m"
    end)
  end

  def vuelos_baratos(vuelos, limite) do
    vuelos
    |> Enum.filter(fn v -> v.precio < limite end)
    |> Enum.map(fn v ->
      {v.codigo, "#{v.origen}-#{v.destino}", v.precio * 0.9}
    end)
    |> Enum.sort_by(fn {_c, _r, precio} -> precio end)
  end

  def aerolineas_completas(vuelos) do
    clasificar = fn v ->
      cond do
        v.duracion < 60 -> :corto
        v.duracion <= 120 -> :medio
        true -> :largo
      end
    end

    vuelos
    |> Enum.group_by(& &1.aerolinea)
    |> Enum.filter(fn {_a, lista} ->
      categorias = Enum.map(lista, clasificar)

      Enum.member?(categorias, :corto) and
      Enum.member?(categorias, :medio) and
      Enum.member?(categorias, :largo)
    end)
    |> Enum.map(fn {a, _} -> a end)
  end

  def rutas_rentables(vuelos) do
    vuelos
    |> Enum.filter(& &1.disponible)
    |> Enum.map(fn v ->
      {"#{v.origen} → #{v.destino}", v.precio * v.pasajeros}
    end)
    |> Enum.sort_by(fn {_r, ingreso} -> -ingreso end)
    |> Enum.take(3)
  end

end

VuelosFunciones.main()
