defmodule Day18Test do
  use ExUnit.Case
  import TestHelpers

  @small_input """
  1,1,1
  2,1,1

  """

  @input """
  2,2,2
  1,2,2
  3,2,2
  2,1,2
  2,3,2
  2,2,1
  2,2,3
  2,2,4
  2,2,6
  1,2,5
  3,2,5
  2,1,5
  2,3,5

  """

  aoc_test(10, Puzzles.Day18.part_one(@small_input))
  aoc_test(64, Puzzles.Day18.part_one(@input))
  aoc_test(3530, Puzzles.Day18.part_one())

  # aoc_test(1514285714288, Puzzles.Day18.part_two(@input))
  # aoc_test(1514285714288, Puzzles.Day18.part_two())
end
