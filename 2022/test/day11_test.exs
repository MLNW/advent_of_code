defmodule Day11Test do
  use ExUnit.Case
  import TestHelpers

  @input """
  Monkey 0:
    Starting items: 79, 98
    Operation: new = old * 19
    Test: divisible by 23
      If true: throw to monkey 2
      If false: throw to monkey 3

  Monkey 1:
    Starting items: 54, 65, 75, 74
    Operation: new = old + 6
    Test: divisible by 19
      If true: throw to monkey 2
      If false: throw to monkey 0

  Monkey 2:
    Starting items: 79, 60, 97
    Operation: new = old * old
    Test: divisible by 13
      If true: throw to monkey 1
      If false: throw to monkey 3

  Monkey 3:
    Starting items: 74
    Operation: new = old + 3
    Test: divisible by 17
      If true: throw to monkey 0
      If false: throw to monkey 1

  """

  aoc_test(10605, Puzzles.Day11.part_one(@input))
  aoc_test(62491, Puzzles.Day11.part_one())

  aoc_test(2_713_310_158, Puzzles.Day11.part_two(@input))
  aoc_test(17_408_399_184, Puzzles.Day11.part_two())
end
