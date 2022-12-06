defmodule Day06Test do
  use ExUnit.Case
  import TestHelpers

  @input [
    {"mjqjpqmgbljsphdztnvjfqwrcgsmlb", 7, 19},
    {"bvwbjplbgvbhsrlpgdmjqwftvncz", 5, 23},
    {"nppdvjthqldpwncqszvftbrmjlhg", 6, 23},
    {"nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", 10, 29},
    {"zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw", 11, 26}
  ]

  for {input, one, two} <- @input do
    describe "#{input}" do
      aoc_test(unquote(one), Puzzles.Day06.part_one(unquote(input)))
      aoc_test(unquote(two), Puzzles.Day06.part_two(unquote(input)))
    end
  end

  aoc_test(1779, Puzzles.Day06.part_one())
  aoc_test(2635, Puzzles.Day06.part_two())
end
