defmodule FourTest do
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

  aoc_test(2, Puzzles.Four.part_one(@input))
  aoc_test(487, Puzzles.Four.part_one())

  aoc_test(4, Puzzles.Four.part_two(@input))
  aoc_test(849, Puzzles.Four.part_two())
end
