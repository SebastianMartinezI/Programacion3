defmodule Util do
  @moduledoc """
  Utilidades generales reutilizables para aplicaciones de consola.
  """

  # =========================
  # ENTRADA DE DATOS
  # =========================

  def ingresar(mensaje, :texto) do
    mensaje
    |> IO.gets()
    |> String.trim()
  end

  def ingresar(mensaje, :entero) do
    try do
      mensaje
      |> ingresar(:texto)
      |> String.to_integer()
    rescue
      ArgumentError ->
        mostrar_error("Se esperaba un número entero")
        ingresar(mensaje, :entero)
    end
  end

  def ingresar(mensaje, :real) do
    try do
      mensaje
      |> ingresar(:texto)
      |> String.to_float()
    rescue
      ArgumentError ->
        mostrar_error("Se esperaba un número real")
        ingresar(mensaje, :real)
    end
  end

  # =========================
  # SALIDA
  # =========================

  def mostrar_mensaje(mensaje) do
    IO.puts(mensaje)
  end

  def mostrar_error(mensaje) do
    IO.puts(:standard_error, mensaje)
  end

  # =========================
  # INTERFAZ
  # =========================

  def separador do
    IO.puts("--------------------------------")
  end

  def titulo(texto) do
    separador()
    IO.puts(texto)
    separador()
  end

  # =========================
  # MENÚ
  # =========================

  def menu(opciones) do
    opciones
    |> Enum.with_index(1)
    |> Enum.each(fn {opcion, i} ->
      IO.puts("#{i}. #{opcion}")
    end)

    ingresar("Seleccione una opción: ", :entero)
  end

  # =========================
  # CONFIRMAR
  # =========================

  def confirmar(mensaje) do
    respuesta =
      ingresar("#{mensaje} (s/n): ", :texto)
      |> String.downcase()

    case respuesta do
      "s" -> true
      "n" -> false
      _ ->
        mostrar_error("Ingrese s o n")
        confirmar(mensaje)
    end
  end
end
