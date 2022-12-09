defmodule Puzzles.Day09.RopeState do
  alias Puzzles.Day09.RopeState
  alias Puzzles.Day09.Coordinate
  defstruct head: Coordinate.new(0, 0), tail: Coordinate.new(0, 0)

  @type t :: %RopeState{head: Coordinate.t(), tail: Coordinate.t()}

  def new(), do: %RopeState{}
end
