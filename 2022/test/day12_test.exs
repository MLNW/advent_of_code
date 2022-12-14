defmodule Day12Test do
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

  aoc_test(29, Puzzles.Day12.part_two(@input))
  aoc_test(375, Puzzles.Day12.part_two())
end
