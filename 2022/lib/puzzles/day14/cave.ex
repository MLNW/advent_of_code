defmodule Puzzles.Day14.Cave do
  alias Common.Coordinate

  defstruct rock: %{},
            sand: %{},
            ingest: %Coordinate{x: 500, y: 0},
            lowest_point: 0,
            has_floor: false

  def fill(%__MODULE__{} = cave) do
    case cave |> add_pebble() do
      {:stop, cave} -> cave
      {:ok, cave} -> cave |> fill()
    end
  end

  defp add_pebble(%__MODULE__{} = cave) do
    case cave |> flow(cave.ingest) do
      :stop -> {:stop, cave}
      pebble -> {:ok, %{cave | sand: cave.sand |> Map.put(pebble, true)}}
    end
  end

  defp flow(%__MODULE__{} = cave, %Coordinate{y: y})
       when not cave.has_floor and y > cave.lowest_point,
       do: :stop

  defp flow(cave, %Coordinate{x: x, y: y} = pebble) do
    below = Coordinate.new(x, y + 1)
    below_left = Coordinate.new(x - 1, y + 1)
    below_right = Coordinate.new(x + 1, y + 1)

    cond do
      cave.sand |> Map.get(pebble) -> :stop
      is_free?(cave, below) -> flow(cave, below)
      is_free?(cave, below_left) -> flow(cave, below_left)
      is_free?(cave, below_right) -> flow(cave, below_right)
      true -> pebble
    end
  end

  defp is_free?(%__MODULE__{} = cave, %Coordinate{} = coordinate) do
    cond do
      coordinate.y >= cave.lowest_point + 2 -> false
      cave.rock |> Map.get(coordinate) -> false
      cave.sand |> Map.get(coordinate) -> false
      true -> true
    end
  end
end
