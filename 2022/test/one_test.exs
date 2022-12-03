defmodule OneTest do
  use ExUnit.Case

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

  test "part one test" do
    result = Puzzles.One.part_one(@input)

    assert result == 24000
  end

  test "part one real" do
    result = Puzzles.One.part_one()

    assert result == 72478
  end

  test "part two test" do
    result = Puzzles.One.part_two(@input)

    assert result == 45000
  end

  test "part two real" do
    result = Puzzles.One.part_two()

    assert result == 210_367
  end
end
