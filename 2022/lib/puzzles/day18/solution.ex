defmodule Puzzles.Day18 do
  alias Puzzles.Day18.Parser

  def part_one(input \\ nil) do
    # Count the number of sides of each cube that are not immediately connect
    # to another cube.

    # Parse it as a graph
    # Reduce graph: for each node 6-outgoing connections
    cube_graph = input |> Parser.parse_input()

    cube_graph
    |> Graph.vertices()
    |> Enum.reduce(0, fn v, acc -> acc + 6 - (cube_graph |> Graph.out_degree(v)) end)
  end
end
