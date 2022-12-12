defmodule Puzzles.Day12 do
  alias Graph.Edge
  alias Puzzles.Day12.Parser

  def part_one(input \\ nil) do
    graph = input |> Parser.parse_input()

    [start | [stop]] =
      graph
      |> Graph.vertices()
      |> Enum.filter(fn {{_row, _col}, elem} -> elem in [10, 37] end)

    {:ok, length, _path} = graph |> filter() |> shortest_path(start, stop)
    length
  end

  defp filter(graph) do
    steep_edges =
      graph
      |> Graph.edges()
      |> Enum.filter(fn %Edge{weight: weight} -> weight > 1 end)

    graph |> Graph.delete_edges(steep_edges)
  end

  def print(graph, width) do
    graph |> Graph.info() |> IO.inspect()

    vertices =
      graph
      |> Graph.vertices()

    header =
      0..(width - 1)
      |> Enum.map(&Integer.to_string/1)
      |> Enum.reduce("    ", fn x, acc ->
        "#{acc}#{if String.length(x) == 1, do: " ", else: ""}#{x} "
      end)

    separator =
      0..(width - 1)
      |> Enum.reduce("--+", fn _, acc -> acc <> "---" end)

    vertices
    |> Enum.sort_by(fn {{_px, py}, _p} -> py end)
    |> Enum.sort_by(fn {{px, _py}, _p} -> px end)
    |> Enum.reduce("#{header}\n#{separator}\n", fn {{row, col}, p}, acc ->
      index =
        if col == 0,
          do: "#{if length(Integer.digits(row)) == 1, do: " ", else: ""}#{row}| ",
          else: ""

      delimter = if col == width - 1, do: "\n#{separator}\n", else: " "
      "#{acc}#{index}#{Integer.to_string(p)}#{delimter}"
    end)
    |> IO.puts()
  end

  defp find(graph, vertex) do
    graph
    |> Graph.vertices()
    |> Enum.filter(fn {v, _} -> v == vertex end)
    |> List.first()
  end

  def shortest_path(graph, {{_px, _py}, _p} = start, {{_qx, _qy}, _q} = stop) do
    path = graph |> Graph.get_shortest_path(start, stop)

    if path, do: {:ok, length(path) - 1, path}, else: {:none}
  end

  def shortest_path(graph, start, stop) do
    shortest_path(graph, find(graph, start), find(graph, stop))
  end
end
