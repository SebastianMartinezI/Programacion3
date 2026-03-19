# =====================================================
#  APUESTAS DEPORTIVAS ⚽
#  Conceptos: Listas, Tuplas, Mapas, CRUD, Enum
#  Archivo: apuestas.exs
#  Ejecutar: elixir apuestas.exs
# =====================================================

defmodule Apuestas do

  # ── USUARIOS — LISTA de MAPAS ─────────────────────

  def usuarios_iniciales do
    [
      %{usuario: "admin", password: "admin", nombre: "Administrador"}
    ]
  end

  # ── REGISTRO — CREATE agrega usuario a la lista ───

  def registrar_usuario(usuarios) do
    Util.mostrar_mensaje(IO.ANSI.cyan() <> """

    ╔══════════════════════════════════════════════╗
    ║          📝  REGISTRAR USUARIO               ║
    ╚══════════════════════════════════════════════╝
    """ <> IO.ANSI.reset())

    usuario  = Util.ingresar("  👤 Nuevo usuario  : ", :texto)
    password = Util.ingresar("  🔑 Password       : ", :texto)
    nombre   = Util.ingresar("  📛 Nombre completo: ", :texto)

    existe = Enum.find(usuarios, fn u -> u.usuario == usuario end)

    cond do
      usuario == "" or password == "" or nombre == "" ->
        "  ❌ Todos los campos son obligatorios\n" |> Util.mostrar_error()
        registrar_usuario(usuarios)

      existe != nil ->
        "  ❌ El usuario '#{usuario}' ya existe\n" |> Util.mostrar_error()
        registrar_usuario(usuarios)

      true ->
        nuevo = %{usuario: usuario, password: password, nombre: nombre}
        usuarios_actualizados = usuarios ++ [nuevo]
        Util.mostrar_mensaje(
          "  " <> IO.ANSI.green() <>
          "✅ Usuario '#{usuario}' registrado correctamente!" <>
          IO.ANSI.reset() <> "\n"
        )
        usuarios_actualizados
    end
  end

  # ── LOGIN ─────────────────────────────────────────

  def login(usuarios) do
    Util.mostrar_mensaje(IO.ANSI.cyan() <> IO.ANSI.bright() <> """

    ╔══════════════════════════════════════════════╗
    ║       ⚽  APUESTAS DEPORTIVAS  ⚽             ║
    ║      Listas · Tuplas · Mapas · Enum          ║
    ╠══════════════════════════════════════════════╣
    ║  1. Iniciar sesion                           ║
    ║  2. Registrarse                              ║
    ║  0. Salir                                    ║
    ╚══════════════════════════════════════════════╝
    """ <> IO.ANSI.reset())

    opcion = Util.ingresar("  👉 Elige una opcion: ", :entero)

    case opcion do
      1 ->
        usuario  = Util.ingresar("  👤 Usuario  : ", :texto)
        password = Util.ingresar("  🔑 Password : ", :texto)

        encontrado = Enum.find(usuarios, fn u ->
          u.usuario == usuario and u.password == password
        end)

        cond do
          encontrado == nil ->
            "  ❌ Usuario o password incorrectos. Intenta de nuevo.\n" |> Util.mostrar_error()
            login(usuarios)

          true ->
            Util.mostrar_mensaje(
              "\n  " <> IO.ANSI.green() <>
              "✅ Bienvenido, #{encontrado.nombre}! Saldo inicial: $0" <>
              IO.ANSI.reset() <> "\n"
            )
            {%{nombre: encontrado.nombre, saldo: 0, apuestas: [], ganancias_totales: 0}, usuarios}
        end

      2 ->
        usuarios_actualizados = registrar_usuario(usuarios)
        login(usuarios_actualizados)

      0 ->
        Util.mostrar_mensaje("\n  👋 Hasta luego!\n")
        System.halt(0)

      _ ->
        "  ❌ Opcion invalida\n" |> Util.mostrar_error()
        login(usuarios)
    end
  end

  # ── DATOS — LISTA de MAPAS, cuotas como TUPLA ─────

  def partidos_disponibles do
    [
      # ⚽ FÚTBOL — Copa del Mundo (LISTA de MAPAS)
      # Cada cuota es una TUPLA {local, empate, visitante}
      %{id: 1,  deporte: "Copa Mundo ⚽", local: "Colombia",    visitante: "Brasil",     cuotas: {3.5, 3.2, 2.1}},
      %{id: 2,  deporte: "Copa Mundo ⚽", local: "Argentina",   visitante: "Uruguay",    cuotas: {1.8, 3.5, 4.0}},
      %{id: 3,  deporte: "Copa Mundo ⚽", local: "España",      visitante: "Francia",    cuotas: {2.2, 3.1, 3.0}},
      %{id: 4,  deporte: "Copa Mundo ⚽", local: "Alemania",    visitante: "Inglaterra", cuotas: {2.5, 3.3, 2.8}},

      # 🏆 UEFA Champions League (LISTA de MAPAS)
      # Cada cuota es una TUPLA {local, empate, visitante}
      %{id: 5,  deporte: "UEFA 🏆",       local: "Real Madrid", visitante: "Man. City",  cuotas: {2.1, 3.4, 3.2}},
      %{id: 6,  deporte: "UEFA 🏆",       local: "Barcelona",   visitante: "PSG",        cuotas: {2.4, 3.2, 2.9}},
      %{id: 7,  deporte: "UEFA 🏆",       local: "Bayern",      visitante: "Chelsea",    cuotas: {1.9, 3.6, 4.1}},
      %{id: 8,  deporte: "UEFA 🏆",       local: "Atletico",    visitante: "Juventus",   cuotas: {2.7, 3.1, 2.6}},

      # 🎾 TENIS (LISTA de MAPAS)
      # Tupla {local, 0.0, visitante} — sin empate
      %{id: 9,  deporte: "Tenis 🎾",      local: "Alcaraz",     visitante: "Djokovic",   cuotas: {2.8, 0.0, 1.9}},
      %{id: 10, deporte: "Tenis 🎾",      local: "Sinner",      visitante: "Medvedev",   cuotas: {2.2, 0.0, 2.5}},
      %{id: 11, deporte: "Tenis 🎾",      local: "Nadal",       visitante: "Federer",    cuotas: {1.7, 0.0, 3.8}},

      # 🏀 BALONCESTO NBA (LISTA de MAPAS)
      # Tupla {local, 0.0, visitante} — sin empate
      %{id: 12, deporte: "Basquetbol 🏀", local: "Lakers",      visitante: "Warriors",   cuotas: {2.3, 0.0, 2.6}},
      %{id: 13, deporte: "Basquetbol 🏀", local: "Bulls",       visitante: "Celtics",    cuotas: {3.1, 0.0, 1.8}},
      %{id: 14, deporte: "Basquetbol 🏀", local: "Heat",        visitante: "Nuggets",    cuotas: {2.9, 0.0, 2.2}}
    ]
  end

  # ── READ — lista partidos en orden fijo ───────────

  def listar_partidos do
    Util.mostrar_mensaje(IO.ANSI.cyan() <> """

    ╔══════════════════════════════════════════════════════════════╗
    ║               🎮  PARTIDOS DISPONIBLES                       ║
    ╚══════════════════════════════════════════════════════════════╝
    """ <> IO.ANSI.reset())

    # Orden fijo de deportes — LISTA
    orden = ["Copa Mundo ⚽", "UEFA 🏆", "Tenis 🎾", "Basquetbol 🏀"]

    Enum.each(orden, fn deporte ->
      # Filtra partidos por deporte — Enum.filter
      partidos = Enum.filter(partidos_disponibles(), fn p -> p.deporte == deporte end)

      Util.mostrar_mensaje(IO.ANSI.bright() <> "  ── #{deporte} ──────────────────────────────" <> IO.ANSI.reset())

      Enum.each(partidos, fn p ->
        {c_local, c_empate, c_visitante} = p.cuotas    # desestructura TUPLA

        linea_empate = if c_empate == 0.0 do
          ""
        else
          "  Empate " <> IO.ANSI.yellow() <> "x#{c_empate}" <> IO.ANSI.reset()
        end

        Util.mostrar_mensaje(
          "  [#{String.pad_leading("#{p.id}", 2)}] " <>
          IO.ANSI.green() <> String.pad_trailing(p.local, 12)     <> " x#{c_local}" <> IO.ANSI.reset() <>
          linea_empate <>
          "  " <>
          IO.ANSI.red()   <> String.pad_trailing(p.visitante, 12) <> " x#{c_visitante}" <> IO.ANSI.reset()
        )
      end)

      Util.mostrar_mensaje("")
    end)
  end

  # ── CREATE — agrega apuesta a la lista ────────────

  def hacer_apuesta(jugador) do
    listar_partidos()

    id     = Util.ingresar("  ID del partido (1-14): ", :entero)
    tipo_n = Util.ingresar("  Tipo:\n  1. Local  2. Empate  3. Visitante\n  Opcion: ", :entero)
    monto  = Util.ingresar("  Monto a apostar $: ", :entero)

    partido = Enum.find(partidos_disponibles(), fn p -> p.id == id end)

    tipo = case tipo_n do
      1 -> :local
      2 -> :empate
      3 -> :visitante
      _ -> :local
    end

    {_c_local, c_empate, _c_visitante} = if partido != nil, do: partido.cuotas, else: {0.0, 0.0, 0.0}

    cond do
      partido == nil ->
        "  ❌ Partido no encontrado\n" |> Util.mostrar_error()
        jugador

      tipo == :empate and c_empate == 0.0 ->
        "  ❌ Este deporte no tiene empate\n" |> Util.mostrar_error()
        jugador

      monto <= 0 ->
        "  ❌ El monto debe ser mayor a 0\n" |> Util.mostrar_error()
        jugador

      monto > jugador.saldo ->
        "  ❌ Saldo insuficiente. Tienes $#{jugador.saldo}\n" |> Util.mostrar_error()
        jugador

      true ->
        cuota = obtener_cuota(partido.cuotas, tipo)

        # Nueva apuesta como MAPA
        nueva_apuesta = %{
          id:         Enum.count(jugador.apuestas) + 1,
          partido_id: id,
          deporte:    partido.deporte,
          partido:    "#{partido.local} vs #{partido.visitante}",
          tipo:       tipo,
          monto:      monto,
          cuota:      cuota,
          estado:     :pendiente    # ATOMO como estado
        }

        Util.mostrar_mensaje(
          "  " <> IO.ANSI.green() <>
          "✅ Apuesta registrada: $#{monto} x #{cuota} = ganancia posible: $#{trunc(monto * cuota)}" <>
          IO.ANSI.reset()
        )

        # Retorna jugador actualizado — MAPA
        %{jugador |
          saldo:    jugador.saldo - monto,
          apuestas: jugador.apuestas ++ [nueva_apuesta]
        }
    end
  end

  # ── READ — ver apuestas con Enum.each ─────────────

  def ver_apuestas(jugador) do
    Util.mostrar_mensaje(IO.ANSI.cyan() <> """

    ╔══════════════════════════════════════════════╗
    ║            💰  MIS APUESTAS                  ║
    ╚══════════════════════════════════════════════╝
    """ <> IO.ANSI.reset())

    Util.mostrar_mensaje("  Usuario: #{jugador.nombre} | Saldo: $#{jugador.saldo}\n")

    if Enum.empty?(jugador.apuestas) do
      Util.mostrar_mensaje("  No tienes apuestas registradas.\n")
    else
      Enum.each(jugador.apuestas, fn a ->
        color_estado = case a.estado do
          :ganada    -> IO.ANSI.green()  <> "GANADA ✅"
          :perdida   -> IO.ANSI.red()    <> "PERDIDA ❌"
          :pendiente -> IO.ANSI.yellow() <> "PENDIENTE ⏳"
        end
        Util.mostrar_mensaje(
          "  [#{a.id}] #{String.pad_trailing(a.partido, 25)} | " <>
          "#{a.deporte} | #{nombre_tipo(a.tipo)} | $#{a.monto} x #{a.cuota} | " <>
          color_estado <> IO.ANSI.reset()
        )
      end)
    end

    Util.mostrar_mensaje("")
  end

  # ── UPDATE — simula resultados con Enum.map ───────

  def simular_resultados(jugador) do
    Util.mostrar_mensaje(IO.ANSI.yellow() <> "\n  🎲 Simulando resultados...\n" <> IO.ANSI.reset())

    # Genera resultado aleatorio por cada partido — Enum.map
    resultados = Enum.map(partidos_disponibles(), fn p ->
      {_c_local, c_empate, _c_visitante} = p.cuotas

      opciones = if c_empate == 0.0 do
        [:local, :visitante]
      else
        [:local, :empate, :visitante]
      end

      resultado  = Enum.random(opciones)
      color_res  = case resultado do
        :local     -> IO.ANSI.green()
        :empate    -> IO.ANSI.yellow()
        :visitante -> IO.ANSI.red()
      end

      # Muestra quién ganó el partido
      ganador = nombre_equipo("#{p.local} vs #{p.visitante}", resultado)
      Util.mostrar_mensaje(
        "  #{p.deporte} | #{p.local} vs #{p.visitante} -> " <>
        color_res <> "Gano #{ganador}" <> IO.ANSI.reset()
      )

      %{partido_id: p.id, resultado: resultado}
    end)

    # Actualiza estado de cada apuesta — Enum.map
    apuestas_resueltas = Enum.map(jugador.apuestas, fn apuesta ->
      resultado_partido = Enum.find(resultados, fn r ->
        r.partido_id == apuesta.partido_id
      end)

      if resultado_partido.resultado == apuesta.tipo do
        Map.put(apuesta, :estado, :ganada)
      else
        Map.put(apuesta, :estado, :perdida)
      end
    end)

    # Calcula ganancias — Enum.filter + Enum.reduce
    ganancias =
      apuestas_resueltas
      |> Enum.filter(fn a -> a.estado == :ganada end)
      |> Enum.reduce(0.0, fn a, acc -> acc + a.monto * a.cuota end)
      |> trunc()

    nuevo_saldo = jugador.saldo + ganancias

    # Separa ganadas y perdidas — Enum.filter
    ganadas  = Enum.filter(apuestas_resueltas, fn a -> a.estado == :ganada end)
    perdidas = Enum.filter(apuestas_resueltas, fn a -> a.estado == :perdida end)

    Util.mostrar_mensaje(IO.ANSI.green() <> "\n  ✅ APUESTAS GANADAS:" <> IO.ANSI.reset())

    if Enum.empty?(ganadas) do
      Util.mostrar_mensaje("  No ganaste ninguna apuesta.")
    else
      Enum.each(ganadas, fn a ->
        ganancia       = trunc(a.monto * a.cuota)
        equipo_ganador = nombre_equipo(a.partido, a.tipo)
        Util.mostrar_mensaje(
          IO.ANSI.green() <>
          "  [#{a.id}] #{String.pad_trailing(a.partido, 25)} | 🏆 Gano #{equipo_ganador} | " <>
          "$#{a.monto} x #{a.cuota} = +$#{ganancia}" <>
          IO.ANSI.reset()
        )
      end)
    end

    Util.mostrar_mensaje(IO.ANSI.red() <> "\n  ❌ APUESTAS PERDIDAS:" <> IO.ANSI.reset())

    if Enum.empty?(perdidas) do
      Util.mostrar_mensaje("  No perdiste ninguna apuesta.")
    else
      Enum.each(perdidas, fn a ->
        equipo_ganador = nombre_equipo(a.partido, a.tipo)
        Util.mostrar_mensaje(
          IO.ANSI.red() <>
          "  [#{a.id}] #{String.pad_trailing(a.partido, 25)} | ❌ Apostaste a #{equipo_ganador} | " <>
          "-$#{a.monto}" <>
          IO.ANSI.reset()
        )
      end)
    end

    Util.mostrar_mensaje(IO.ANSI.bright() <> "\n  💰 Ganancias esta ronda: $#{ganancias}")
    Util.mostrar_mensaje("  🏦 Nuevo saldo         : $#{nuevo_saldo}" <> IO.ANSI.reset())

    # Retorna jugador actualizado — MAPA
    %{jugador |
      apuestas:          apuestas_resueltas,
      saldo:             nuevo_saldo,
      ganancias_totales: jugador.ganancias_totales + ganancias
    }
  end

  # ── DELETE — cancela apuesta con Enum.reject ──────

  def cancelar_apuesta(jugador) do
    ver_apuestas(jugador)
    id = Util.ingresar("  ID de apuesta a cancelar: ", :entero)

    apuesta = Enum.find(jugador.apuestas, fn a -> a.id == id end)

    cond do
      apuesta == nil ->
        "  ❌ Apuesta no encontrada\n" |> Util.mostrar_error()
        jugador

      apuesta.estado != :pendiente ->
        "  ❌ Solo se pueden cancelar apuestas pendientes\n" |> Util.mostrar_error()
        jugador

      true ->
        nuevas = Enum.reject(jugador.apuestas, fn a -> a.id == id end)
        Util.mostrar_mensaje(
          "  " <> IO.ANSI.green() <>
          "✅ Apuesta cancelada. Reembolso: $#{apuesta.monto}" <>
          IO.ANSI.reset()
        )
        %{jugador |
          apuestas: nuevas,
          saldo:    jugador.saldo + apuesta.monto
        }
    end
  end

  # ── ESTADÍSTICAS — con Enum ───────────────────────

  def estadisticas(jugador) do
    todas = jugador.apuestas

    if Enum.empty?(todas) do
      Util.mostrar_mensaje("  No hay apuestas para mostrar estadisticas.\n")
    else
      Util.mostrar_mensaje(IO.ANSI.cyan() <> """

      ╔══════════════════════════════════════════════╗
      ║          📊  ESTADISTICAS                    ║
      ╚══════════════════════════════════════════════╝
      """ <> IO.ANSI.reset())

      Util.mostrar_mensaje("  Usuario          : #{jugador.nombre}")
      Util.mostrar_mensaje("  Total apuestas   : #{Enum.count(todas)}")
      Util.mostrar_mensaje(IO.ANSI.green()  <> "  Ganadas     ✅  : #{Enum.count(todas, fn a -> a.estado == :ganada end)}"    <> IO.ANSI.reset())
      Util.mostrar_mensaje(IO.ANSI.red()    <> "  Perdidas    ❌  : #{Enum.count(todas, fn a -> a.estado == :perdida end)}"   <> IO.ANSI.reset())
      Util.mostrar_mensaje(IO.ANSI.yellow() <> "  Pendientes  ⏳  : #{Enum.count(todas, fn a -> a.estado == :pendiente end)}" <> IO.ANSI.reset())
      Util.mostrar_mensaje("  Total apostado   : $#{Enum.sum(Enum.map(todas, & &1.monto))}")
      Util.mostrar_mensaje("  Ganancias totales: $#{jugador.ganancias_totales}")
      Util.mostrar_mensaje("  Saldo actual     : $#{jugador.saldo}\n")
    end
  end

  # ── RECARGAR SALDO ────────────────────────────────

  def recargar_saldo(jugador) do
    Util.mostrar_mensaje("  Saldo actual: $#{jugador.saldo}")
    monto = Util.ingresar("  Monto a recargar $: ", :entero)

    cond do
      monto <= 0 ->
        "  ❌ El monto debe ser mayor a 0\n" |> Util.mostrar_error()
        jugador

      true ->
        nuevo_saldo = jugador.saldo + monto
        Util.mostrar_mensaje(
          "  " <> IO.ANSI.green() <>
          "✅ Saldo recargado. Nuevo saldo: $#{nuevo_saldo}" <>
          IO.ANSI.reset()
        )
        %{jugador | saldo: nuevo_saldo}
    end
  end

  # ── HELPERS PRIVADOS ──────────────────────────────

  defp obtener_cuota({c_local, _e, _v}, :local),     do: c_local
  defp obtener_cuota({_l, c_empate, _v}, :empate),   do: c_empate
  defp obtener_cuota({_l, _e, c_visit}, :visitante), do: c_visit

  defp nombre_tipo(:local),     do: "Local    "
  defp nombre_tipo(:empate),    do: "Empate   "
  defp nombre_tipo(:visitante), do: "Visitante"

  defp nombre_equipo(partido, tipo) do
    [local, visitante] = String.split(partido, " vs ")
    case tipo do
      :local     -> local
      :visitante -> visitante
      :empate    -> "Empate"
    end
  end

  # ── MENÚ ─────────────────────────────────────────

  def menu(jugador) do
    Util.mostrar_mensaje(IO.ANSI.bright() <> """

    ╔══════════════════════════════════════════════╗
    ║             ⚽  MENU PRINCIPAL               ║
    ╠══════════════════════════════════════════════╣
    ║  1. Ver partidos disponibles                 ║
    ║  2. Hacer una apuesta                        ║
    ║  3. Ver mis apuestas                         ║
    ║  4. Cancelar apuesta pendiente               ║
    ║  5. Simular resultados                       ║
    ║  6. Ver estadisticas                         ║
    ║  7. Recargar saldo                           ║
    ║  0. Cerrar sesion                            ║
    ╚══════════════════════════════════════════════╝
    """ <> IO.ANSI.reset())

    Util.mostrar_mensaje("  👤 Usuario: #{jugador.nombre} | 💰 Saldo: $#{jugador.saldo}\n")

    opcion = Util.ingresar("  👉 Elige una opcion: ", :entero)
    procesar(opcion, jugador)
  end

  def procesar(1, jugador) do
    listar_partidos()
    menu(jugador)
  end

  def procesar(2, jugador) do
    nuevo_jugador = hacer_apuesta(jugador)
    menu(nuevo_jugador)
  end

  def procesar(3, jugador) do
    ver_apuestas(jugador)
    menu(jugador)
  end

  def procesar(4, jugador) do
    nuevo_jugador = cancelar_apuesta(jugador)
    menu(nuevo_jugador)
  end

  def procesar(5, jugador) do
    nuevo_jugador = simular_resultados(jugador)
    menu(nuevo_jugador)
  end

  def procesar(6, jugador) do
    estadisticas(jugador)
    menu(jugador)
  end

  def procesar(7, jugador) do
    nuevo_jugador = recargar_saldo(jugador)
    menu(nuevo_jugador)
  end

  def procesar(0, _jugador) do
    Util.mostrar_mensaje(
      "\n  " <> IO.ANSI.yellow() <>
      "🔒 Sesion cerrada. Volviendo al login..." <>
      IO.ANSI.reset() <> "\n"
    )
    {jugador, _usuarios} = login(usuarios_iniciales())
    menu(jugador)
  end

  def procesar(_, jugador) do
    "  ❌ Opcion invalida\n" |> Util.mostrar_error()
    menu(jugador)
  end

  # ── ARRANQUE ──────────────────────────────────────

  def main do
    {jugador, _usuarios} = login(usuarios_iniciales())
    menu(jugador)
  end
end

# ── PUNTO DE ENTRADA ──────────────────────────────
Apuestas.main()
