defmodule FourTest do
  use ExUnit.Case

  @input """
  2-4,6-8
  2-3,4-5
  5-7,7-9
  2-8,3-7
  6-6,4-6
  2-6,4-8

  """

  test "part one test" do
    result = Puzzles.Four.part_one(@input)

    assert result == 2
  end

  test "part one real" do
    result = Puzzles.Four.part_one()

    assert result == 487
  end

  test "part two test" do
    result = Puzzles.Four.part_two(@input)

    assert result == 4
  end

  test "part two real" do
    result = Puzzles.Four.part_two()

    assert result == 849
  end
end
