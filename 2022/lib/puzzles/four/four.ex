defmodule Puzzles.Four do
  defp parse_input(input) when is_nil(input) do
    Common.Utils.read_input(4) |> parse_input()
  end

  defp parse_input(input) do
    input
    |> String.split("\n")
    |> Enum.filter(&(&1 != ""))
    |> Enum.map(&String.split(&1, ","))
    |> Enum.map(&parse_assignments/1)
  end

  def part_one(input \\ nil) do
    input |> part(&fully_contains?/1)
  end

  def part_two(input \\ nil) do
    input |> part(&overlaps?/1)
  end

  defp part(input, mapper) do
    input
    |> parse_input()
    |> Enum.map(&mapper.(&1))
    |> Enum.reduce(0, fn bool, acc -> if bool, do: acc + 1, else: acc end)
  end

  defp parse_assignments(list) when is_list(list) do
    Enum.map(list, &parse_assignments/1)
  end

  defp parse_assignments(string) when is_bitstring(string) do
    [a | [b | _]] = string |> String.split("-") |> Enum.map(&String.to_integer/1)
    {a, b}
  end

  defp fully_contains?([{a, b} | [{x, y} | _]]) do
    cond do
      a <= x and b >= y -> true
      x <= a and y >= b -> true
      true -> false
    end
  end

  defp overlaps?([{a, b} | [{x, y} | _]]) do
    cond do
      a in x..y or b in x..y -> true
      x in a..b or y in a..b -> true
      true -> false
    end
  end
end
