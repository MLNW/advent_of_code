defmodule Puzzles.Day17.Parser do
  def parse_input(input) when is_nil(input), do: Common.Utils.read_input(17) |> parse_input()

  def parse_input(input) do
    input
    |> String.trim()
    |> String.split("", trim: true)
    |> Enum.map(fn
      ">" -> :right
      "<" -> :left
    end)
  end
end
