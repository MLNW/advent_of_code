defmodule Puzzles.Day20.Element do
  defstruct number: nil, index: nil

  def new(number, index), do: %__MODULE__{number: number, index: index}
end
