defmodule Puzzles.Day01 do
  defp parse_input(input) when is_nil(input) do
    Common.Utils.read_input(1) |> parse_input()
  end

  defp parse_input(input) do
    input
    |> String.split("\n")
    |> Enum.chunk_by(fn x -> x == "" end)
    |> Enum.filter(fn [head | _] -> head != "" end)
    |> Enum.map(fn x -> Enum.reduce(x, 0, fn e, acc -> String.to_integer(e) + acc end) end)
  end

  def part_one(input \\ nil) do
    input |> parse_input() |> Enum.max()
  end

  def part_two(input \\ nil) do
    input
    |> parse_input()
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.reduce(&(&1 + &2))
  end
end
