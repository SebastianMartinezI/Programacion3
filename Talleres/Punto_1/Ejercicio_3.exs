personas = [
  %{nombre: "Antonio", edad: 23},
  %{nombre: "Luis", edad: 30},
  %{nombre: "Marta", edad: 19},
  %{nombre: "Pedro", edad: 40},
  %{nombre: "Andrés", edad: 28},
  %{nombre: "Ana", edad: 35}
]

resultado =
  personas
  |> Enum.filter(fn %{nombre: nombre, edad: edad} ->
    edad >= 21 and (nombre |> String.downcase() |> String.starts_with?("a"))
  end)
  |> Enum.map(fn %{nombre: nombre} -> String.upcase(nombre) end)
  |> Enum.sort_by(&String.length(&1))
  |> Enum.join(" | ")

IO.puts(resultado)
