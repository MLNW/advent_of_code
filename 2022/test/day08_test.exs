defmodule Day08Test do
  use ExUnit.Case
  import TestHelpers

  @input """
  30373
  25512
  65332
  33549
  35390

  """

  aoc_test(21, Puzzles.Day08.part_one(@input))
  aoc_test(1779, Puzzles.Day08.part_one())

  aoc_test(8, Puzzles.Day08.part_two(@input))
  aoc_test(172_224, Puzzles.Day08.part_two())
end
