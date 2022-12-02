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
end
