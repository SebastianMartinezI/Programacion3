defmodule Restaurante do

  # MAIN

  def main do
    IO.puts("🍽️ Bienvenido al restaurante\n")

    spawn(fn -> preparar("🍔 Hamburguesa", 2) end)
    spawn(fn -> preparar("🍕 Pizza", 3) end)
    spawn(fn -> preparar("🥤 Jugo", 1) end)

    # Espera para que terminen los procesos
    :timer.sleep(5000)
  end


  # FUNCIÓN RECURSIVA

  defp preparar(plato, tiempo) do
    IO.puts("👨‍🍳 Preparando #{plato}...")

    cocinar(plato, tiempo)
  end

  defp cocinar(plato, 0) do
    IO.puts("✅ #{plato} listo!")
  end

  defp cocinar(plato, tiempo) do
    IO.puts("⏳ #{plato} en proceso... (#{tiempo})")

    :timer.sleep(1000)

    cocinar(plato, tiempo - 1)
  end

end

Restaurante.main()
