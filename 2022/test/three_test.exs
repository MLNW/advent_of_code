defmodule ThreeTest do
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

  aoc_test(157, Puzzles.Three.part_one(@input))
  aoc_test(8105, Puzzles.Three.part_one())

  aoc_test(70, Puzzles.Three.part_two(@input))
  aoc_test(2363, Puzzles.Three.part_two())
end
