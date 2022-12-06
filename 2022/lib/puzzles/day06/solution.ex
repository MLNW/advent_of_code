defmodule Puzzles.Day06 do
  defp parse_input(input) when is_nil(input) do
    Common.Utils.read_input(6) |> parse_input()
  end

  defp parse_input(input) do
    input
    |> String.to_charlist()
  end

  defp part(input, marker_length) do
    input
    |> parse_input()
    |> Enum.chunk_every(marker_length, 1)
    |> Enum.map(&Enum.uniq/1)
    |> Enum.with_index(marker_length)
    |> Enum.find(fn {chars, _index} -> length(chars) == marker_length end)
    |> elem(1)
  end

  def part_one(input \\ nil), do: part(input, 4)
  def part_two(input \\ nil), do: part(input, 14)
end
