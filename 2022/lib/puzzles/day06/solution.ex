defmodule Puzzles.Day06 do
  defp parse_input(input) when is_nil(input) do
    Common.Utils.read_input(6) |> parse_input()
  end

  defp parse_input(input) do
    input
  end

  def part_one(input \\ nil) do
    input
    |> parse_input()
  end

  def part_two(input \\ nil) do
  end
end
