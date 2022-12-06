defmodule Day06Test do
  use ExUnit.Case
  import TestHelpers

  @input [
    "mjqjpqmgbljsphdztnvjfqwrcgsmlb",
    "bvwbjplbgvbhsrlpgdmjqwftvncz",
    "nppdvjthqldpwncqszvftbrmjlhg",
    "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg",
    "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw"
  ]

  aoc_test(7, Puzzles.Day06.part_one(elem(List.pop_at(@input, 0), 0)))
  aoc_test(5, Puzzles.Day06.part_one(elem(List.pop_at(@input, 1), 0)))
  aoc_test(6, Puzzles.Day06.part_one(elem(List.pop_at(@input, 2), 0)))
  aoc_test(10, Puzzles.Day06.part_one(elem(List.pop_at(@input, 3), 0)))
  aoc_test(11, Puzzles.Day06.part_one(elem(List.pop_at(@input, 4), 0)))
  aoc_test(1779, Puzzles.Day06.part_one())

  aoc_test(19, Puzzles.Day06.part_two(elem(List.pop_at(@input, 0), 0)))
  aoc_test(23, Puzzles.Day06.part_two(elem(List.pop_at(@input, 1), 0)))
  aoc_test(23, Puzzles.Day06.part_two(elem(List.pop_at(@input, 2), 0)))
  aoc_test(29, Puzzles.Day06.part_two(elem(List.pop_at(@input, 3), 0)))
  aoc_test(26, Puzzles.Day06.part_two(elem(List.pop_at(@input, 4), 0)))
  aoc_test(2635, Puzzles.Day06.part_two())
end
