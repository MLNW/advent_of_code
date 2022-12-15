defmodule Puzzles.Day13.Parser do
  def parse_input(input) when is_nil(input), do: Common.Utils.read_input(13) |> parse_input()

  def parse_input(input) do
    input
    |> String.split("\n")
    |> Enum.filter(&(&1 != ""))
    |> Enum.map(&Code.eval_string/1)
    |> Enum.map(fn {list, _} -> list end)
    |> Enum.chunk_every(2)
    |> Enum.map(fn [a | [b]] -> {a, b} end)
  end
end
