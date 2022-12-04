defmodule Puzzles.Four do
  defp parse_input(input) when is_nil(input) do
    Common.Utils.read_input(4) |> parse_input()
  end

  defp parse_input(input) do
    input
    |> String.split("\n")
    |> Enum.filter(&(&1 != ""))
  end

  def part_one(input \\ nil) do
    input
    |> parse_input()
    |> Enum.map(&String.split(&1, ","))
    |> Enum.map(&parse_assignments/1)
    |> Enum.map(&fully_contains?/1)
    |> Enum.reduce(0, fn bool, acc -> if bool, do: acc + 1, else: acc end)
  end

  defp parse_assignments(list) when is_list(list) do
    Enum.map(list, &parse_assignments/1)
  end

  defp parse_assignments(string) when is_bitstring(string) do
    [a | [b | _]] = string |> String.split("-") |> Enum.map(&String.to_integer/1)
    {a, b}
  end

  defp fully_contains?([{first_a, second_a} | [{first_b, second_b} | _]]) do
    cond do
      first_a <= first_b and second_a >= second_b -> true
      first_b <= first_a and second_b >= second_a -> true
      true -> false
    end
  end
end
