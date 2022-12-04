defmodule Puzzles.Day05 do
  defp parse_input(input) when is_nil(input) do
    Common.Utils.read_input(5) |> parse_input()
  end

  defp parse_input(input) do
    input
    |> String.split("\n")
    |> Enum.filter(&(&1 != ""))
  end

  def part_one(input \\ nil) do
    input
    |> parse_input()
  end
end
