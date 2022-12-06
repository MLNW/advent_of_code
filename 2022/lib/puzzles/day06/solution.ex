defmodule Puzzles.Day06 do
  defp parse_input(input) when is_nil(input) do
    Common.Utils.read_input(6) |> parse_input()
  end

  defp parse_input(input) do
    input
    |> String.to_charlist()
  end

  def part_one(input \\ nil) do
    input
    |> parse_input()
    |> Enum.chunk_every(4, 1)
    |> Enum.map(&Enum.uniq/1)
    |> Enum.with_index(4)
    |> Enum.find(fn {chars, _index} -> length(chars) == 4 end)
    |> elem(1)
  end

  def part_two(input \\ nil) do
  end
end
