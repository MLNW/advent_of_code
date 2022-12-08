defmodule Puzzles.Day08 do
  defp parse_input(input) when is_nil(input), do: Common.Utils.read_input(8) |> parse_input()

  defp parse_input(input) do
    input
    |> String.split("\n")
    |> Enum.filter(&(&1 != ""))
    |> Enum.map(&String.graphemes/1)
    |> Enum.map(fn chars -> chars |> Enum.map(&String.to_integer/1) end)
    |> Matrex.new()
  end

  def part_one(input \\ nil) do
    matrix = input |> parse_input()

    dimension = matrix |> dimension()

    check_range = 2..(dimension - 1)

    visible_trees =
      for col <- check_range, row <- check_range do
        matrix |> is_visible?(col, row, dimension)
      end
      |> Enum.reduce(0, &if(&1, do: &2 + 1, else: &2))

    visible_trees + edges(dimension)
  end

  defp is_visible?(matrix, col, row, dimension) do
    selection =
      dimension
      |> selection_matrix(col, row)
      |> Matrex.multiply(matrix)

    element = selection[row][col]

    selection = selection |> Matrex.apply(&(&1 - element))

    row_selection = selection |> Matrex.row(row) |> Matrex.to_list()
    col_selection = selection |> Matrex.column(col) |> Matrex.to_list()

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

  defp selection_matrix(dimension, col, row) do
    zeros = dimension |> Matrex.zeros()
    column = Matrex.ones(dimension, 1)

    zeros
    |> Matrex.set_column(row, column)
    |> Matrex.transpose()
    |> Matrex.set_column(col, column)
  end

  defp edges(dimension), do: 4 * dimension - 4

  defp dimension(matrix), do: matrix |> Matrex.size() |> elem(0)
end
