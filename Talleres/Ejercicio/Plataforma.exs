defmodule Plataforma do

  def main do
    nombre =
      "Ingrese el nombre:"
      |> Util.ingresar(:texto)

    edad =
      "Ingrese la edad:"
      |> Util.ingresar(:entero)

    credencial =
      "¿Tiene credenciales: true o false?"
      |> Util.ingresar(:boolean)

    intentos_fallidos =
      "Ingrese el numero de intentos fallidos:"
      |> Util.ingresar(:entero)

    resultado = validar_usuario(nombre, edad, credencial, intentos_fallidos)

    IO.inspect(resultado)
  end


  def validar_usuario(nombre, edad, credencial, intentos_fallidos) do
    # Validar credenciales
    unless credencial do
      {:error, "Acceso denegado: credenciales inválidas"}

    else
      # Validar edad
      if edad < 18 do
        {:error, "Acceso restringido: usuario menor de edad"}

      else
        # Validar intentos fallidos
        if intentos_fallidos >= 3 do
          {:error, "Cuenta bloqueada por múltiples intentos fallidos"}

        else
          {:ok, "Acceso concedido"}
        end
      end
    end
  end

end

Plataforma.main()
