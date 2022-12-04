defmodule OneTest do
  use ExUnit.Case
  import TestHelpers

  @input """
  1000
  2000
  3000

  4000

  5000
  6000

  7000
  8000
  9000

  10000
  """

  aoc_test(24000, Puzzles.One.part_one(@input))
  aoc_test(72478, Puzzles.One.part_one())

  aoc_test(45000, Puzzles.One.part_two(@input))
  aoc_test(210_367, Puzzles.One.part_two())
end
