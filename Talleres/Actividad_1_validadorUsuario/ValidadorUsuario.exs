defmodule ValidadorUsuario do

  def main do
    usuario =
      "Ingrese el nombre de usuario:"
      |> Util.ingresar(:texto)

    resultado = validar_usuario(usuario)

    IO.inspect(resultado)
  end


  def validar_usuario(usuario) do
    errores =
      []
      |> validar_longitud(usuario)
      |> validar_minusculas(usuario)
      |> validar_espacios(usuario)
      |> validar_especiales(usuario)
      |> validar_letra(usuario)

    if errores == [] do
      {:ok, "Usuario válido"}
    else
      {:error, Enum.join(errores, " | ")}
    end
  end

  # VALIDACIONES

  defp validar_longitud(lista_errores, usuario) do
    if String.length(usuario) < 5 or String.length(usuario) > 12 do
      lista_errores ++ ["Debe tener entre 5 y 12 caracteres"]
    else
      lista_errores
    end
  end


  defp validar_minusculas(lista_errores, usuario) do
    if usuario != String.downcase(usuario) do
      lista_errores ++ ["Debe estar completamente en minúscula"]
    else
      lista_errores
    end
  end


  defp validar_espacios(lista_errores, usuario) do
    if String.contains?(usuario, " ") do
      lista_errores ++ ["No debe contener espacios"]
    else
      lista_errores
    end
  end


  defp validar_especiales(lista_errores, usuario) do
    especiales = ["#", "@", "$", "%"]

    if Enum.any?(especiales, fn c -> String.contains?(usuario, c) end) do
      lista_errores ++ ["No debe contener caracteres especiales (#, @, $, %)"]
    else
      lista_errores
    end
  end


  defp validar_letra(lista_errores, usuario) do
    solo_letras =
      usuario
      |> String.replace(~r/[^a-z]/, "")

    if String.length(solo_letras) == 0 do
      lista_errores ++ ["Debe contener al menos una letra"]
    else
      lista_errores
    end
  end

end

ValidadorUsuario.main()
