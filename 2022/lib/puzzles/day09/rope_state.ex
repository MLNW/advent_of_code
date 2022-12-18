defmodule Puzzles.Day09.RopeState do
  alias Common.Coordinate
  alias Puzzles.Day09.RopeState
  defstruct head: Coordinate.new(0, 0), tail: Coordinate.new(0, 0)

  @type t :: %RopeState{head: Coordinate.t(), tail: Coordinate.t()}

  def new(), do: %RopeState{}
end
