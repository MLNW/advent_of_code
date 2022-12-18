defmodule Common.Coordinate do
  defstruct x: 0, y: 0

  @type t :: %__MODULE__{x: integer(), y: integer()}

  @spec new(integer(), integer()) :: Coordinate.t()
  def new(x, y), do: %__MODULE__{x: x, y: y}

  def add(a, b), do: %__MODULE__{x: a.x + b.x, y: a.y + b.y}
  def subtract(a, b), do: %__MODULE__{x: a.x - b.x, y: a.y - b.y}
end
