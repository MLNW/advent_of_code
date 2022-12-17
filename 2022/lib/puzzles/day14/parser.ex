defmodule Puzzles.Day14.Parser do
  alias Puzzles.Day14.Cave
  alias Common.Coordinate
  def parse_input(input) when is_nil(input), do: Common.Utils.read_input(14) |> parse_input()

  def parse_input(input) do
    input
    |> String.split("\n")
    |> Enum.filter(&(&1 != ""))
    |> Enum.map(&parse_line/1)
    |> parse_cave()
  end

  defp parse_line(line) do
    line
    |> String.split(" -> ")
    |> Enum.map(&String.split(&1, ","))
    |> Enum.map(fn pair -> pair |> Enum.map(&String.to_integer/1) end)
    |> Enum.map(fn [x | [y]] -> %Coordinate{x: x, y: y} end)
  end

  defp parse_cave(rocks) do
    rock =
      rocks
      |> Enum.map(&parse_rock/1)
      |> List.flatten()
      |> Enum.reduce(%{}, fn %Coordinate{} = coordinate, acc ->
        acc |> Map.put(coordinate, true)
      end)

    %Coordinate{y: lowest_point} = rock |> Map.keys() |> Enum.max_by(&(&1.y))

    %Cave{rock: rock, lowest_point: lowest_point}
  end

  @spec parse_rock(list(Coordinate.t())) :: list(Coordinate.t())
  defp parse_rock(rock) do
    rock
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.map(fn [a | [b]] -> in_between(a, b) end)
    |> List.flatten()
    |> Enum.uniq()
  end

  defp in_between(%Coordinate{x: x, y: y_a} = a, %Coordinate{x: x, y: y_b}) do
    y_a..y_b |> Enum.map(fn y_new -> %{a | y: y_new} end)
  end

  defp in_between(%Coordinate{x: x_a, y: y} = a, %Coordinate{x: x_b, y: y}) do
    x_a..x_b |> Enum.map(fn x_new -> %{a | x: x_new} end)
  end
end
