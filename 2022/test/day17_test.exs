defmodule Day17Test do
  use ExUnit.Case
  import TestHelpers

  @input """
  >>><<><>><<<>><>>><<<>>><<<><<<>><>><<>>

  """

  #aoc_test(3068, Puzzles.Day17.part_one(@input))
  aoc_test(3117, Puzzles.Day17.part_one())

  # aoc_test(1514285714288, Puzzles.Day17.part_two(@input))
  # aoc_test(1514285714288, Puzzles.Day17.part_two())
end
