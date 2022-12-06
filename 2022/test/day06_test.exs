defmodule Day06Test do
  use ExUnit.Case
  import TestHelpers

  @input """
  mjqjpqmgbljsphdztnvjfqwrcgsmlb

  """

  aoc_test(7, Puzzles.Day06.part_one(@input))
  aoc_test(1779, Puzzles.Day06.part_one())

  # aoc_test("MCD", Puzzles.Day06.part_two(@input))
  # aoc_test("LCTQFBVZV", Puzzles.Day06.part_two())
end
