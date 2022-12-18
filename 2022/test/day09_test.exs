defmodule Day09Test do
  alias Common.Coordinate
  alias Puzzles.Day09.RopeState
  use ExUnit.Case
  import TestHelpers

  @input """
  R 4
  U 4
  L 3
  D 1
  R 4
  D 1
  L 5
  R 2

  """

  test "motion right" do
    assert [
             %RopeState{head: %Coordinate{x: 2, y: 0}, tail: %Coordinate{x: 1, y: 0}},
             %RopeState{head: %Coordinate{x: 1, y: 0}, tail: %Coordinate{x: 0, y: 0}},
             RopeState.new()
           ] ==
             Puzzles.Day09.simulate_motion([RopeState.new()], {:right, 2})
  end

  test "motion left" do
    assert [
             %RopeState{head: %Coordinate{x: -2, y: 0}, tail: %Coordinate{x: -1, y: 0}},
             %RopeState{head: %Coordinate{x: -1, y: 0}, tail: %Coordinate{x: 0, y: 0}},
             RopeState.new()
           ] ==
             Puzzles.Day09.simulate_motion([RopeState.new()], {:left, 2})
  end

  test "motion diagonal" do
    assert [
             %RopeState{head: %Coordinate{x: 2, y: 2}, tail: %Coordinate{x: 2, y: 1}},
             %RopeState{head: %Coordinate{x: 2, y: 1}, tail: %Coordinate{x: 1, y: 0}},
             %RopeState{head: %Coordinate{x: 2, y: 0}, tail: %Coordinate{x: 1, y: 0}},
             %RopeState{head: %Coordinate{x: 1, y: 0}, tail: %Coordinate{x: 0, y: 0}},
             RopeState.new()
           ] ==
             Puzzles.Day09.simulate_motion([RopeState.new()], {:right, 2})
             |> Puzzles.Day09.simulate_motion({:up, 2})
  end

  aoc_test(13, Puzzles.Day09.part_one(@input))
  aoc_test(6011, Puzzles.Day09.part_one())

  # aoc_test(8, Puzzles.Day09.part_two(@input))
  # aoc_test(172_224, Puzzles.Day09.part_two())
end
