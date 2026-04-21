defmodule NumeroReversible do

  def main do
    n = 57

    case es_reversible?(n) do
      true  -> IO.puts("#{n} es reversible")
      false -> IO.puts("#{n} NO es reversible")
    end
  end

  def es_reversible?(n) when is_integer(n) and n > 0 do
    invertido = invertir(n, 0)
    suma = n + invertido

    todos_impares?(suma)
  end

  def es_reversible?(_), do: false

  defp invertir(0, acc), do: acc

  defp invertir(n, acc) do
    digito = rem(n, 10)
    nuevo_acc = acc * 10 + digito
    invertir(div(n, 10), nuevo_acc)
  end

  defp todos_impares?(0), do: true

  defp todos_impares?(n) do
    digito = rem(n, 10)

    if rem(digito, 2) == 0 do
      false
    else
      todos_impares?(div(n, 10))
    end
  end

end

NumeroReversible.main()
