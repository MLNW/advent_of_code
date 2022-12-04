defmodule Day02Test do
  use ExUnit.Case
  import TestHelpers

  @input """
  A Y
  B X
  C Z

  """

  aoc_test(15, Puzzles.Day02.part_one(@input))
  aoc_test(14163, Puzzles.Day02.part_one())

  aoc_test(12, Puzzles.Day02.part_two(@input))
  aoc_test(12091, Puzzles.Day02.part_two())
end
