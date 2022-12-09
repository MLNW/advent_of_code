defmodule Puzzles.Day09.Coordinate do
  alias Puzzles.Day09.Coordinate
  defstruct x: 0, y: 0

  @type t :: %Coordinate{x: integer(), y: integer()}

  @spec new(integer(), integer()) :: Coordinate.t()
  def new(x, y), do: %Coordinate{x: x, y: y}

  def add(a, b), do: %Coordinate{x: a.x + b.x, y: a.y + b.y}
  def subtract(a, b), do: %Coordinate{x: a.x - b.x, y: a.y - b.y}
end
