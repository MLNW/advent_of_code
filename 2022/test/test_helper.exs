defmodule TestHelpers do
  defmacro aoc_test(expected, part) do
    {method, _line, parameters} = part

    [aliases | [method_name | _]] = method |> elem(tuple_size(method) - 1)

    module_name =
      aliases
      |> elem(tuple_size(aliases) - 1)
      |> Enum.reduce(fn x, acc -> "#{acc}.#{x}" end)

    real? = if [] == parameters, do: "real", else: "example"

    test_name = Macro.escape("#{module_name}.#{method_name} #{real?}")

    quote do
      test unquote(test_name), do: assert(unquote(expected) == unquote(part))
    end
  end
end

ExUnit.start()
