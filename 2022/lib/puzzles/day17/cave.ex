defmodule Puzzles.Day17.Cave do
  alias Common.Coordinate
  defstruct state: %{}, width: 7

  def new(width \\ 7) do
    state =
      for x <- 0..(width + 1), into: %{} do
        sign =
          cond do
            x == 0 or x == width + 1 -> "+"
            true -> "-"
          end

        {Coordinate.new(x, 0), sign}
      end

    %__MODULE__{state: state, width: width}
  end

  def print(cave) do
    IO.puts("\n")

    for y <- height(cave)..0, x <- 0..(cave.width + 1) do
      sign = cave.state |> Map.get(Coordinate.new(x, y))

      cond do
        sign -> sign
        x == 0 -> "|"
        x == cave.width + 1 -> "|\n"
        true -> "."
      end
    end
    |> Enum.reduce("", &(&2 <> &1))
    |> IO.puts()

    cave
  end

  def get_falling_rock(cave) do
    cave.state |> Map.filter(fn {_key, value} -> value == "@" end)
  end

  def get_landed_rock(cave) do
    cave.state |> Map.filter(fn {_key, value} -> value == "#" end)
  end

  def next_rock_type(:minus), do: :plus
  def next_rock_type(:plus), do: :corner
  def next_rock_type(:corner), do: :pipe
  def next_rock_type(:pipe), do: :cube
  def next_rock_type(:cube), do: :minus

  def spawn(cave, rock_type) do
    left_edge = 3
    bottom_edge = height(cave) + 4

    new_state =
      case rock_type do
        :minus ->
          for x <- 0..3, do: {x + left_edge, bottom_edge}

        :pipe ->
          for y <- 0..3, do: {left_edge, y + bottom_edge}

        :cube ->
          for x <- 0..1, y <- 0..1, do: {x + left_edge, y + bottom_edge}

        :plus ->
          for x <- 0..2, y <- 0..2 do
            cond do
              x == 1 or y == 1 -> {x + left_edge, y + bottom_edge}
              true -> nil
            end
          end

        :corner ->
          for x <- 0..2, y <- 0..2 do
            cond do
              x == 2 or y == 0 -> {x + left_edge, y + bottom_edge}
              true -> nil
            end
          end
      end
      |> Enum.filter(& &1)
      |> Enum.into(%{}, fn {x, y} -> {Coordinate.new(x, y), "@"} end)
      |> Map.merge(cave.state)

    %{cave | state: new_state}
  end

  defp height(cave) do
    %Coordinate{y: y} = cave.state |> Map.keys() |> Enum.max_by(& &1.y)
    y
  end
end
