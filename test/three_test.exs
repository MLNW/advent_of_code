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

  test "part two test" do
    result = Puzzles.Three.part_two(@input)

    assert result == 70
  end

  test "part two real" do
    result = Puzzles.Three.part_two()

    assert result == 2363
  end
end
