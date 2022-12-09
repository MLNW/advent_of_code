defmodule Common.MatrixUtils do
  def selection_matrix(matrix, col, row) do
    dimension = matrix |> dimension()

    zeros = dimension |> Matrex.zeros()
    column = Matrex.ones(dimension, 1)

    zeros
    |> Matrex.set_column(row, column)
    |> Matrex.transpose()
    |> Matrex.set_column(col, column)
  end

  def dimension(matrix), do: matrix |> Matrex.size() |> elem(0)
end
