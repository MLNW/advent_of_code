defmodule Puzzles.Day14 do
  alias Puzzles.Day14.Cave
  alias Puzzles.Day14.Parser

  def part_one(input \\ nil) do
    input |> part(false)
  end

  def part_two(input \\ nil) do
    input |> part(true)
  end

  defp part(input, has_floor) do
    cave = input |> Parser.parse_input()

    %Cave{sand: sand} =
      %{cave | has_floor: has_floor}
      |> Cave.fill()

    sand |> Map.keys() |> length()
  end
end
