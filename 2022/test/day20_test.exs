defmodule Day20Test do
  alias Puzzles.Day20.Parser
  use ExUnit.Case
  import TestHelpers

  @input """
  1
  2
  -3
  3
  -2
  0
  4

  """

  @small_test """
  0
  -1
  -1
  1
  """

  test "Mix test" do
    Parser.parse_input(@small_test)
  end

  aoc_test(3, Puzzles.Day20.part_one(@input))
  aoc_test(3530, Puzzles.Day20.part_one())

  # aoc_test(58, Puzzles.Day20.part_two(@input))
  # aoc_test(1514285714288, Puzzles.Day20.part_two())
end
