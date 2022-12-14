defmodule Day07Test do
  use ExUnit.Case
  import TestHelpers

  @input """
  $ cd /
  $ ls
  dir a
  14848514 b.txt
  8504156 c.dat
  dir d
  $ cd a
  $ ls
  dir e
  29116 f
  2557 g
  62596 h.lst
  $ cd e
  $ ls
  584 i
  $ cd ..
  $ cd ..
  $ cd d
  $ ls
  4060174 j
  8033020 d.log
  5626152 d.ext
  7214296 k

  """

  aoc_test(95437, Puzzles.Day07.part_one(@input))
  aoc_test(1_770_595, Puzzles.Day07.part_one())

  aoc_test(24_933_642, Puzzles.Day07.part_two(@input))
  aoc_test(2_195_372, Puzzles.Day07.part_two())
end
