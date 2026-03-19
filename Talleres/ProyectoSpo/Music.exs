defmodule Main do
  @moduledoc """
  gestionar una playlist

  Características:
  - (listas + mapas)
  - Búsqueda y estadísticas
  - Reproducción automática
  - Comandos en vivo: p=pausa, r=continuar, n=siguiente, q=salir
  - Shuffle
  """

  # =============================
  # INICIO
  # =============================

  def iniciar do
    loop([])
  end

  # =============================
  # LOOP PRINCIPAL
  # =============================

  def loop(playlist) do
    Util.titulo("GESTOR DE PLAYLIST")

    opcion =
      Util.menu([
        "Agregar canción",
        "Ver playlist",
        "Buscar canción",
        "Editar canción",
        "Eliminar canción",
        "Reproducir playlist",
        "Reproducir shuffle",
        "Estadísticas",
        "Salir"
      ])

    nueva_playlist =
      case opcion do
        1 -> agregar_cancion(playlist)
        2 -> listar_canciones(playlist); playlist
        3 -> buscar_cancion(playlist); playlist
        4 -> editar_cancion(playlist)
        5 -> eliminar_cancion(playlist)
        6 -> reproducir_playlist(playlist); playlist
        7 -> reproducir_shuffle(playlist); playlist
        8 -> estadisticas(playlist); playlist
        9 -> Util.mostrar_mensaje("Hasta luego"); System.halt()
        _ -> playlist
      end

    loop(nueva_playlist)
  end

  # =============================
  # CREATE
  # =============================

  def agregar_cancion(lista) do
    titulo = Util.ingresar("Título: ", :texto)
    artista = Util.ingresar("Artista: ", :texto)
    duracion = Util.ingresar("Duración (segundos): ", :entero)

    id =
      case lista do
        [] -> 1
        _ -> Enum.max_by(lista, fn c -> c.id end).id + 1
      end

    cancion = %{
      id: id,
      titulo: titulo,
      artista: artista,
      duracion: duracion
    }

    lista ++ [cancion]
  end

  # =============================
  # READ
  # =============================

  def listar_canciones(lista) do
    Util.titulo("PLAYLIST")

    if lista == [] do
      Util.mostrar_mensaje("La playlist está vacía")
    else
      Enum.each(lista, fn c ->
        IO.puts("#{c.id} | #{c.titulo} - #{c.artista} (#{c.duracion}s)")
      end)
    end
  end

  # =============================
  # SEARCH
  # =============================

  def buscar_cancion(lista) do
    titulo = Util.ingresar("Título a buscar: ", :texto)

    resultados =
      Enum.filter(lista, fn c ->
        String.downcase(c.titulo) == String.downcase(titulo)
      end)

    if resultados == [] do
      Util.mostrar_error("No se encontraron canciones")
    else
      Enum.each(resultados, fn c ->
        IO.puts("#{c.id} | #{c.titulo} - #{c.artista}")
      end)
    end
  end

  # =============================
  # UPDATE
  # =============================

  def editar_cancion(lista) do
    id = Util.ingresar("ID a editar: ", :entero)
    nuevo_titulo = Util.ingresar("Nuevo título: ", :texto)

    Enum.map(lista, fn c ->
      if c.id == id do
        %{c | titulo: nuevo_titulo}
      else
        c
      end
    end)
  end

  # =============================
  # DELETE
  # =============================

  def eliminar_cancion(lista) do
    id = Util.ingresar("ID a eliminar: ", :entero)

    Enum.reject(lista, fn c ->
      c.id == id
    end)
  end

  # =============================
  # REPRODUCIR PLAYLIST
  # =============================

  def reproducir_playlist(lista) do
    Enum.reduce_while(lista, nil, fn cancion, _ ->
      case reproducir(cancion) do
        :next -> {:cont, nil}
        :quit -> {:halt, nil}
        _ -> {:cont, nil}
      end
    end)
  end

  # =============================
  # SHUFFLE
  # =============================

  def reproducir_shuffle(lista) do
    lista
    |> Enum.shuffle()
    |> reproducir_playlist()
  end

  # =============================
  # REPRODUCIR CANCIÓN
  # =============================

  def reproducir(cancion) do
    IO.puts("\nReproduciendo: #{cancion.titulo} - #{cancion.artista}")
    IO.puts("Comandos: p=pause r=resume n=next q=quit")

    parent = self()

    # proceso reproductor
    player =
      spawn(fn ->
        loop_reproductor(cancion, 1, :play, parent)
      end)

    # proceso lector de comandos
    spawn(fn ->
      escuchar_comandos(player)
    end)

    esperar_fin()
  end

  # =============================
  # ESPERAR RESULTADO
  # =============================

  def esperar_fin do
    receive do
      :next -> :next
      :quit -> :quit
      :fin -> :ok
    end
  end

  # =============================
  # LOOP DEL REPRODUCTOR
  # =============================

  def loop_reproductor(cancion, segundo, estado, parent) do
    cond do
      segundo > cancion.duracion ->
        send(parent, :fin)

      estado == :pause ->
        receive do
          :play -> loop_reproductor(cancion, segundo, :play, parent)
          :next -> send(parent, :next)
          :quit -> send(parent, :quit)
        end

      true ->
        IO.write("\r#{segundo}/#{cancion.duracion}")
        :timer.sleep(1000)

        receive do
          :pause -> loop_reproductor(cancion, segundo, :pause, parent)
          :next -> send(parent, :next)
          :quit -> send(parent, :quit)
        after
          0 ->
            loop_reproductor(cancion, segundo + 1, :play, parent)
        end
    end
  end

  # =============================
  # ESCUCHAR COMANDOS
  # =============================

  def escuchar_comandos(player_pid) do
    comando =
      IO.gets("")
      |> String.trim()

    case comando do
      "p" -> send(player_pid, :pause)
      "r" -> send(player_pid, :play)
      "n" -> send(player_pid, :next)
      "q" -> send(player_pid, :quit)
      _ -> nil
    end

    escuchar_comandos(player_pid)
  end

  # =============================
  # ESTADÍSTICAS
  # =============================

  def estadisticas(lista) do
    total = Enum.count(lista)

    duracion_total =
      Enum.reduce(lista, 0, fn c, acc ->
        acc + c.duracion
      end)

    mas_larga =
      if lista != [] do
        Enum.max_by(lista, fn c -> c.duracion end)
      end

    IO.puts("Total canciones: #{total}")
    IO.puts("Duración total: #{duracion_total} segundos")

    if mas_larga do
      IO.puts("Canción más larga: #{mas_larga.titulo}")
    end
  end
end

Main.iniciar()
