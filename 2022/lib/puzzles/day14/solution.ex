defmodule Puzzles.Day14 do
  alias Puzzles.Day14.Cave
  alias Puzzles.Day14.Parser

  def part_one(input \\ nil) do
    %Cave{sand: sand} =
      input
      |> Parser.parse_input()
      |> Cave.fill()

    length(sand)
  end
end
