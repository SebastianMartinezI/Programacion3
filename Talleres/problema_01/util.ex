defmodule Util do
  def mostrar_mensaje(mensaje) do
    System.cmd("cmd.exe",["/c", "python3", "mostrar_dialogo.py", mensaje])  end
end
