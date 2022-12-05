defmodule Day05Test do
  use ExUnit.Case
  import TestHelpers

  @input """
      [D]
  [N] [C]
  [Z] [M] [P]
   1   2   3

  move 1 from 2 to 1
  move 3 from 1 to 3
  move 2 from 2 to 1
  move 1 from 1 to 2

  """

  aoc_test("CMZ", Puzzles.Day05.part_one(@input))
  aoc_test("VJSFHWGFT", Puzzles.Day05.part_one())

  # aoc_test(0, Puzzles.Day05.part_two(@input))
  # aoc_test(0, Puzzles.Day05.part_two())
end
