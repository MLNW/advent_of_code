defmodule TwoTest do
  use ExUnit.Case
  import TestHelpers

  @input """
  A Y
  B X
  C Z

  """

  aoc_test(15, Puzzles.Two.part_one(@input))
  aoc_test(14163, Puzzles.Two.part_one())

  aoc_test(12, Puzzles.Two.part_two(@input))
  aoc_test(12091, Puzzles.Two.part_two())
end
