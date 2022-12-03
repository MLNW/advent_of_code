defmodule ThreeTest do
  use ExUnit.Case

  @input """
  vJrwpWtwJgWrhcsFMMfFFhFp
  jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
  PmmdzqPrVvPwwTWBwg
  wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
  ttgJtRGJQctTZtZT
  CrZsJsPPZsGzwwsLwLmpwMDw
  """

  test "part one test" do
    result = Puzzles.Three.part_one(@input)

    assert result == 157
  end

  test "part one real" do
    result = Puzzles.Three.part_one()

    assert result == 8105
  end
end
