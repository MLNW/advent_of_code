defmodule Day13Test do
  use ExUnit.Case
  import TestHelpers

  @input """
  [1,1,3,1,1]
  [1,1,5,1,1]

  [[1],[2,3,4]]
  [[1],4]

  [9]
  [[8,7,6]]

  [[4,4],4,4]
  [[4,4],4,4,4]

  [7,7,7,7]
  [7,7,7]

  []
  [3]

  [[[]]]
  [[]]

  [1,[2,[3,[4,[5,6,7]]]],8,9]
  [1,[2,[3,[4,[5,6,0]]]],8,9]

  """

  @small_input """
  [1,1,3,1,1]
  [1,1,5,1,1]

  [[1],[2,3,4]]
  [[1],4]

  [7,7,7,7]
  [7,7,7]

  """

  aoc_test(
    [{[1, 1, 3, 1, 1], [1, 1, 5, 1, 1]}, {[[1], [2, 3, 4]], [[1], 4]}, {[7, 7, 7, 7], [7, 7, 7]}],
    Puzzles.Day13.Parser.parse_input(@small_input)
  )

  aoc_test(
    true,
    Puzzles.Day13.is_sorted?({[1, 1, 3, 1, 1], [1, 1, 5, 1, 1]})
  )

  aoc_test(
    false,
    Puzzles.Day13.is_sorted?({[1, 1, 5, 1, 1], [1, 1, 3, 1, 1]})
  )

  aoc_test(
    true,
    Puzzles.Day13.is_sorted?({[[1], [2, 3, 4]], [[1], 4]})
  )

  aoc_test(
    false,
    Puzzles.Day13.is_sorted?({[[1], 4], [[1], [2, 3, 4]]})
  )

  aoc_test(13, Puzzles.Day13.part_one(@input))
  aoc_test(5350, Puzzles.Day13.part_one())

  # aoc_test(29, Puzzles.Day13.part_two(@input))
  # aoc_test(375, Puzzles.Day13.part_two())
end
