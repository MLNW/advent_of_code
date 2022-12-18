defmodule Puzzles.Day18.Parser do
  alias Graph.Edge
  alias Puzzles.Day18.Cube
  def parse_input(input) when is_nil(input), do: Common.Utils.read_input(18) |> parse_input()

  def parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_cube/1)
    |> Enum.into(%{}, fn cube -> {cube, true} end)
    |> parse_graph()
  end

  defp parse_cube(line) do
    [x | [y | [z]]] =
      line
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)

    Cube.new(x, y, z)
  end

  defp parse_graph(cubes) do
    cubes
    |> Enum.reduce(Graph.new(), fn {cube, _}, graph ->
      possible_neighbors = cube |> Cube.neighbors()

      edges =
        cubes
        |> Enum.filter(fn {x, _} -> possible_neighbors |> Map.get(x) end)
        |> Enum.map(fn {neighbor, _} -> Edge.new(cube, neighbor) end)

      graph |> Graph.add_vertex(cube) |> Graph.add_edges(edges)
    end)
  end
end
