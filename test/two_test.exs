defmodule TwoTest do
  use ExUnit.Case

  @input """
  A Y
  B X
  C Z

  """

  test "part one test" do
    result = Puzzles.Two.part_one(@input)

    assert result == 15
  end

  test "part one real" do
    result = Puzzles.Two.part_one()

    assert result == 14163
  end

  test "part two test" do
    result = Puzzles.Two.part_two(@input)

    assert result == 12
  end

  test "part two real" do
    result = Puzzles.Two.part_two()

    assert result == 12091
  end
end
