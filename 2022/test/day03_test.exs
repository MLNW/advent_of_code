defmodule Day03Test do
  use ExUnit.Case
  import TestHelpers

  @input """
  vJrwpWtwJgWrhcsFMMfFFhFp
  jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
  PmmdzqPrVvPwwTWBwg
  wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
  ttgJtRGJQctTZtZT
  CrZsJsPPZsGzwwsLwLmpwMDw

  """

  aoc_test(157, Puzzles.Day03.part_one(@input))
  aoc_test(8105, Puzzles.Day03.part_one())

  aoc_test(70, Puzzles.Day03.part_two(@input))
  aoc_test(2363, Puzzles.Day03.part_two())
end
