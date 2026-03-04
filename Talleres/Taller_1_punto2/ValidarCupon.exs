defmodule ValidadorCupon do
  def main do
    cupon =
      "Ingrese el código del cupón:"
      |> Util.ingresar(:texto)

    case validar(cupon) do
      {:ok, mensaje} ->
        Util.mostrar_mensaje(mensaje)

      {:error, mensaje} ->
        Util.mostrar_mensaje(mensaje)
    end
  end

  # VALIDACIÓN PRINCIPAL

  def validar(cupon) do
    []
    |> validar_longitud(cupon)
    |> validar_mayuscula(cupon)
    |> validar_numero(cupon)
    |> validar_espacios(cupon)
    |> construir_respuesta()
  end

  # VALIDACIONES

  def validar_longitud(errores, cupon) do
    if String.length(cupon) >= 10 do
      errores
    else
      errores ++ ["debe tener al menos 10 caracteres"]
    end
  end

  def validar_mayuscula(errores, cupon) do
    if String.downcase(cupon) != cupon do
      errores
    else
      errores ++ ["debe contener al menos una letra mayúscula"]
    end
  end

  def validar_numero(errores, cupon) do
    tiene_numero =
      Enum.any?(0..9, fn n ->
        String.contains?(cupon, Integer.to_string(n))
      end)

    if tiene_numero do
      errores
    else
      errores ++ ["debe contener al menos un número"]
    end
  end

  def validar_espacios(errores, cupon) do
    sin_espacios = String.replace(cupon, " ", "")

    if sin_espacios == cupon do
      errores
    else
      errores ++ ["no debe contener espacios en blanco"]
    end
  end

  # CONSTRUCCIÓN DE RESPUESTA

  def construir_respuesta([]),
    do: {:ok, "Cupón válido"}

  def construir_respuesta(errores) do
    mensaje =
      errores
      |> Enum.join(" y ")

    {:error, "El cupón #{mensaje}"}
  end

end

ValidadorCupon.main()
