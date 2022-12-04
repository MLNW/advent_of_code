defmodule Day04Test do
  use ExUnit.Case
  import TestHelpers

  @input """
  2-4,6-8
  2-3,4-5
  5-7,7-9
  2-8,3-7
  6-6,4-6
  2-6,4-8

  """

  aoc_test(2, Puzzles.Day04.part_one(@input))
  aoc_test(487, Puzzles.Day04.part_one())

  aoc_test(4, Puzzles.Day04.part_two(@input))
  aoc_test(849, Puzzles.Day04.part_two())
end
