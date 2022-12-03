defmodule Puzzles.Three do
  defp parse_input(input) when is_nil(input) do
    Common.Utils.read_input("three")
    |> parse_input()
  end

  defp parse_input(input) do
    input
    |> String.split("\n")
    |> Enum.filter(&(&1 != ""))
    |> Enum.map(&String.split_at(&1, String.length(&1) |> div(2)))
  end

  def part_one(input \\ nil) do
    input
    |> parse_input()
    |> Enum.map(fn {a, b} -> String.myers_difference(a, b) end)
    |> Enum.map(&Keyword.get(&1, :eq))
    |> Enum.map(&priority(&1))
    |> Enum.sum()
  end

  defp priority(type) do
    subtraction =
      cond do
        Unicode.uppercase?(type) -> 38
        true -> 96
      end

    type |> String.to_charlist() |> hd |> Kernel.-(subtraction)
  end
end
