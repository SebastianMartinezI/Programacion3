defmodule Parqueadero do

  # MAIN

  def main do
    pid = iniciar(2)   # 2 cupos

    send(pid, {:llegar, "🚗 Auto 1"})
    send(pid, {:llegar, "🚗 Auto 2"})
    send(pid, {:llegar, "🚗 Auto 3"})  # espera
    send(pid, {:llegar, "🚗 Auto 4"})  # espera

    :timer.sleep(2000)

    send(pid, {:salir, "🚗 Auto 1"})

    :timer.sleep(2000)

    send(pid, {:salir, "🚗 Auto 2"})

    :timer.sleep(2000)
  end

  # INICIAR PROCESO

  def iniciar(capacidad) do
    spawn(fn -> loop(capacidad, [], []) end)
  end


  # LOOP (ESTADO)

  defp loop(capacidad, dentro, cola) do
    receive do

      # 🚗 LLEGA AUTO
      {:llegar, auto} ->
        if length(dentro) < capacidad do
          IO.puts("🟢 #{auto} entra al parqueadero")
          loop(capacidad, [auto | dentro], cola)
        else
          IO.puts("⛔ #{auto} en espera")
          loop(capacidad, dentro, cola ++ [auto])
        end

      # 🚪 SALE AUTO
      {:salir, auto} ->
        IO.puts("🚪 #{auto} sale")

        nuevos_dentro = List.delete(dentro, auto)

        case cola do
          [siguiente | resto] ->
            IO.puts("🟢 #{siguiente} entra desde la cola")
            loop(capacidad, [siguiente | nuevos_dentro], resto)

          [] ->
            loop(capacidad, nuevos_dentro, [])
        end

    end
  end

end

Parqueadero.main()
