defmodule Puzzles.Day18.Cube do
  defstruct x: 0, y: 0, z: 0

  def new(x, y, z), do: %__MODULE__{x: x, y: y, z: z}

  def neighbors(%__MODULE__{x: x, y: y, z: z} = cube) do
    %{
      %{cube | x: x - 1} => true,
      %{cube | x: x + 1} => true,
      %{cube | y: y - 1} => true,
      %{cube | y: y + 1} => true,
      %{cube | z: z - 1} => true,
      %{cube | z: z + 1} => true
    }
  end
end
