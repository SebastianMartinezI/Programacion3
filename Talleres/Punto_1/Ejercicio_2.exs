numeros = Enum.to_list(1..15)

resultado =
  numeros
  |> Enum.filter(&(rem(&1, 3) == 0))
  |> Enum.map(&(&1 + 1))
  |> Enum.reduce({0, 0}, fn x, {suma, conteo} -> {suma + x, conteo + 1} end)
  |> then(fn {suma, conteo} -> suma / conteo end)

IO.puts("Salida: #{resultado}")
