defmodule Puzzles.Day07.File do
  defstruct name: nil, size: 0

  @type t :: %Puzzles.Day07.File{name: String.t(), size: integer()}
end
