defmodule Puzzles.Day18 do
  alias Graph.Edge
  alias Puzzles.Day18.Cube
  alias Puzzles.Day18.Parser

  def part_one(input \\ nil) do
    # Count the number of sides of each cube that are not immediately connect
    # to another cube.

    cube_graph = input |> Parser.parse_input()

    cube_graph
    |> Graph.vertices()
    |> Enum.reduce(0, fn v, acc -> surface_area(cube_graph, v, acc) end)
  end

  def part_two(input \\ nil) do
    # Do not include air pockets
    cube_graph = input |> Parser.parse_input()

    {simple, complex} =
      cube_graph
      |> Graph.strong_components()
      |> Enum.split_with(fn list -> length(list) < 4 end)

    surface_area_simple =
      simple
      |> List.flatten()
      |> Enum.reduce(0, fn v, acc -> surface_area(cube_graph, v, acc) end)

    surface_area_complex = 0

    complex =
      complex
      |> List.flatten()
      |> IO.inspect()

    {min, max} =
      complex
      |> Enum.reduce({Cube.new(100, 100, 100), Cube.new()}, &reduce_min_max/2)
      |> IO.inspect()

    # Add edges for all connections from min to max
    air_graph =
      for x <- min.x..max.x, y <- min.y..max.y, z <- min.z..max.z do
        Cube.new(x, y, z)
      end
      |> Enum.reduce(Graph.new(), fn cube, graph ->
        edges =
          cube
          |> Cube.neighbors()
          |> Enum.map(fn {neighbor, _} -> Edge.new(cube, neighbor) end)

        graph |> Graph.add_edges(edges)
      end)

    {reachable, not_reachable} =
      complex
      |> Enum.split_with(fn cube ->
        air_graph
        |> Graph.delete_vertices(complex |> Enum.filter(fn x -> x != cube end))
        |> Graph.dijkstra(max, cube)
      end)
      |> IO.inspect()

    surface_area_complex =
      reachable
      |> Enum.reduce(0, fn v, acc -> surface_area(cube_graph, v, acc) end)

    # Remove complex from graph
    # Find a path from min to cube, if one is there it is not enclosed

    surface_area_simple + surface_area_complex
  end

  defp surface_area(graph, v, acc), do: acc + 6 - (graph |> Graph.out_degree(v))

  defp reduce_min_max(%Cube{x: x, y: y, z: z}, {%Cube{} = min, %Cube{} = max}) do
    with x_min <- min(x, min.x),
         x_max <- max(x, max.x),
         y_min <- min(y, min.y),
         y_max <- max(y, max.y),
         z_min <- min(z, min.z),
         z_max <- max(z, max.z) do
      {Cube.new(x_min, y_min, z_min), Cube.new(x_max, y_max, z_max)}
    end
  end
end
