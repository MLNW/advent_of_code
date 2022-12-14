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

  def part_two(input \\ nil) do
    graph = input |> Parser.parse_input() |> filter()

    [end_point] =
      graph
      |> Graph.vertices()
      |> Enum.filter(fn {{_row, _col}, elem} -> elem == 37 end)

    closest = graph |> bfs([end_point])
    {:ok, length, _path} = graph |> shortest_path(closest, end_point)
    length
  end

  defp bfs(graph, to_visit, visited \\ [], match \\ nil)
  defp bfs(_graph, _to_visit, _visited, match) when not is_nil(match), do: match

  defp bfs(graph, [{{_row, _col}, elem} = next | to_visit], visited, nil) do
    new_visited = [next] ++ visited

    new_visits =
      graph
      |> Graph.in_edges(next)
      |> Enum.map(fn %Edge{v1: vertex} -> vertex end)
      |> Enum.filter(&(&1 not in new_visited))

    new_matches = if elem in [10, 11], do: next, else: nil

    new_visits = (to_visit ++ new_visits) |> Enum.uniq()

    bfs(graph, new_visits, new_visited, new_matches)
  end

  defp filter(graph) do
    steep_edges =
      graph
      |> Graph.edges()
      |> Enum.filter(fn %Edge{weight: weight} -> weight > 1 end)

    graph |> Graph.delete_edges(steep_edges)
  end

  defp find(graph, vertex) do
    graph
    |> Graph.vertices()
    |> Enum.filter(fn {v, _} -> v == vertex end)
    |> List.first()
  end

  defp shortest_path(graph, {{_px, _py}, _p} = start, {{_qx, _qy}, _q} = stop) do
    path = graph |> Graph.get_shortest_path(start, stop)

    if path, do: {:ok, length(path) - 1, path}, else: {:none}
  end

  defp shortest_path(graph, start, stop) do
    shortest_path(graph, find(graph, start), find(graph, stop))
  end
end
