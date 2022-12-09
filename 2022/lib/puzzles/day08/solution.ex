defmodule Puzzles.Day08 do
  alias Common.MatrixUtils
  def parse_input(input) when is_nil(input), do: Common.Utils.read_input(8) |> parse_input()

  def parse_input(input) do
    input
    |> String.split("\n")
    |> Enum.filter(&(&1 != ""))
    |> Enum.map(&String.graphemes/1)
    |> Enum.map(fn chars -> chars |> Enum.map(&String.to_integer/1) end)
    |> Matrex.new()
  end

  def part_one(input \\ nil) do
    matrix = input |> parse_input()

    dimension = matrix |> MatrixUtils.dimension()

    check_range = 2..(dimension - 1)

    visible_trees =
      for col <- check_range, row <- check_range do
        matrix |> is_visible?(col, row)
      end
      |> Enum.reduce(0, &if(&1, do: &2 + 1, else: &2))

    visible_trees + edges(dimension)
  end

  def part_two(input \\ nil) do
    matrix = input |> parse_input()

    dimension = matrix |> MatrixUtils.dimension()

    for col <- 1..dimension, row <- 1..dimension do
      matrix |> scenic_score(col, row)
    end
    |> Enum.max()
  end

  def scenic_score(matrix, col, row) do
    element = matrix[row][col]

    matrix =
      matrix
      |> Matrex.apply(&(&1 - element))

    row_selection = matrix |> Matrex.row(row) |> Matrex.to_list()
    col_selection = matrix |> Matrex.column(col) |> Matrex.to_list()

    scenic_score(row_selection, col - 1) * scenic_score(col_selection, row - 1)
  end

  defp scenic_score(list, index) do
    {left, right} =
      list
      |> List.delete_at(index)
      |> Enum.split(index)

    view_distance(Enum.reverse(left)) * view_distance(right)
  end

  defp view_distance(list) do
    result =
      list
      |> Enum.take_while(&(&1 < 0.0))
      |> Enum.map(fn _ -> 1 end)
      |> Enum.sum()

    if result < length(list), do: result + 1, else: result
  end

  defp is_visible?(matrix, col, row) do
    element = matrix[row][col]

    matrix = matrix |> Matrex.apply(&(&1 - element))

    row_selection = matrix |> Matrex.row(row) |> Matrex.to_list()
    col_selection = matrix |> Matrex.column(col) |> Matrex.to_list()

    is_visible?(row_selection, col - 1) or is_visible?(col_selection, row - 1)
  end

  defp is_visible?(list, index) do
    {left, right} =
      list
      |> List.delete_at(index)
      |> Enum.split(index)

    is_visible?(left) or is_visible?(right)
  end

  defp is_visible?(list), do: list |> Enum.all?(&(&1 < 0.0))

  defp edges(dimension), do: 4 * dimension - 4
end
