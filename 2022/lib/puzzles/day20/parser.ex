defmodule Puzzles.Day20.Parser do
  alias Puzzles.Day20.Element
  def parse_input(input) when is_nil(input), do: Common.Utils.read_input(20) |> parse_input()

  def parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.with_index()
    |> Enum.into(%{}, fn {number, index} -> {index, Element.new(number, index)} end)
  end
end
