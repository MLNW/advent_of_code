defmodule Puzzles.Day14.Cave do
  alias Common.Coordinate
  alias Common.Coordinate
  defstruct rock: [], sand: [], ingest: %Coordinate{x: 500, y: 0}, lowest_point: 0

  def fill(%__MODULE__{} = cave) do
    case cave |> add_pebble() do
      {:stop, cave} -> cave
      {:ok, cave} -> cave |> fill()
    end
  end

  def add_pebble(%__MODULE__{} = cave) do
    pebble = cave |> flow(cave.ingest)

    case pebble do
      :stop -> {:stop, cave}
      pebble -> {:ok, %{cave | sand: [pebble] ++ cave.sand}}
    end
  end

  defp flow(%__MODULE__{} = cave, %Coordinate{y: y}) when y > cave.lowest_point, do: :stop

  defp flow(cave, %Coordinate{x: x, y: y} = pebble) do
    below = Coordinate.new(x, y + 1)
    below_left = Coordinate.new(x - 1, y + 1)
    below_right = Coordinate.new(x + 1, y + 1)

    cond do
      is_free?(cave, below) -> flow(cave, below)
      is_free?(cave, below_left) -> flow(cave, below_left)
      is_free?(cave, below_right) -> flow(cave, below_right)
      true -> pebble
    end
  end

  defp is_free?(%__MODULE__{} = cave, coordinate) do
    cond do
      coordinate in cave.rock -> false
      coordinate in cave.sand -> false
      true -> true
    end
  end
end
