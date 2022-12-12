defmodule Day12Test do
  alias Puzzles.Day12.Parser
  use ExUnit.Case
  import TestHelpers

  @input """
  Sabqponm
  abcryxxl
  accszExk
  acctuvwj
  abdefghi

  """

  aoc_test(31, Puzzles.Day12.part_one(@input))
  aoc_test(380, Puzzles.Day12.part_one())

  # aoc_test(2_713_310_158, Puzzles.Day12.part_two(@input))
  # aoc_test(17_408_399_184, Puzzles.Day12.part_two())
end
