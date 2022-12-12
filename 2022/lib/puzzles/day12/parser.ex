defmodule Puzzles.Day12.Parser do
  alias Graph.Edge
  def parse_input(input) when is_nil(input), do: Common.Utils.read_input(12) |> parse_input()

  def parse_input(input) do
    input
    |> String.split("\n")
    |> Enum.filter(&(&1 != ""))
    |> Enum.map(&String.graphemes/1)
    |> Enum.map(fn row -> row |> Enum.map(&parse_char/1) end)
    |> Enum.with_index()
    |> Enum.into(%{}, fn {row, index} -> {index, row} end)
    |> parse_graph()
  end

  defp parse_char("S"), do: 10
  defp parse_char("E"), do: 37
  # ASCII lower cases 97..122, convert a to 11, to have nicer output
  defp parse_char(x), do: :binary.first(x) - 86

  defp parse_graph(input) do
    edges =
      for {row, vertices} <- input do
        vertices
        |> Enum.with_index()
        |> Enum.map(fn {_elem, col} -> edges(input, row, col) end)
      end
      |> List.flatten()

    Graph.new() |> Graph.add_edges(edges)
  end

  defp edges(input, row, col) do
    current = vertex(input, row, col)
    left = vertex(input, row, col - 1)
    right = vertex(input, row, col + 1)
    top = vertex(input, row - 1, col)
    bottom = vertex(input, row + 1, col)

    [{current, left}, {current, right}, {current, top}, {current, bottom}]
    |> Enum.filter(fn {_, {_, y}} -> y end)
    |> Enum.map(fn {{_, x} = a, {_, y} = b} ->
      Edge.new(a, b, weight: calc_weight(x, y))
    end)
  end

  # if(b - a <= 0, do: 1, else: b - a)
  defp calc_weight(a, b), do: b - a

  defp vertex(input, row, col), do: {{row, col}, vertex_elem(input, row, col)}

  defp vertex_elem(input, row, col) do
    try do
      input |> Map.get(row) |> Enum.at(col)
    rescue
      Protocol.UndefinedError -> nil
    end
  end
end
