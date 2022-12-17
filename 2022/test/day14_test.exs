defmodule Day14Test do
  use ExUnit.Case
  import TestHelpers
  alias Puzzles.Day14.Cave
  alias Common.Coordinate

  @input """
  498,4 -> 498,6 -> 496,6
  503,4 -> 502,4 -> 502,9 -> 494,9

  """

  @small_input """
  498,4 -> 498,6 -> 496,6

  """

  aoc_test(
    %Cave{
      rock: %{
        %Coordinate{x: 498, y: 4} => true,
        %Coordinate{x: 498, y: 5} => true,
        %Coordinate{x: 496, y: 6} => true,
        %Coordinate{x: 497, y: 6} => true,
        %Coordinate{x: 498, y: 6} => true
      },
      sand: %{},
      ingest: %Coordinate{x: 500, y: 0},
      lowest_point: 6
    },
    Puzzles.Day14.Parser.parse_input(@small_input)
  )

  aoc_test(24, Puzzles.Day14.part_one(@input))
  aoc_test(745, Puzzles.Day14.part_one())

  aoc_test(93, Puzzles.Day14.part_two(@input))
  aoc_test(27551, Puzzles.Day14.part_two())
end
