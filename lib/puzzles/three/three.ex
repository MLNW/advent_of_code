defmodule Puzzles.Three do
  defp parse_input(input) when is_nil(input) do
    Common.Utils.read_input("three")
    |> parse_input()
  end

  defp parse_input(input) do
    input
    |> String.split("\n")
    |> Enum.filter(&(&1 != ""))
  end

  def part_one(input \\ nil) do
    part(input, fn x ->
      x
      |> Enum.map(&String.split_at(&1, String.length(&1) |> div(2)))
      |> Enum.map(fn {a, b} -> find_common_chars([a, b]) end)
    end)
  end

  def part_two(input \\ nil) do
    part(input, fn x ->
      x
      |> Enum.chunk_every(3)
      |> Enum.map(&find_common_chars/1)
    end)
  end

  defp part(input, mapper) do
    input
    |> parse_input()
    |> mapper.()
    |> Enum.map(&List.first/1)
    |> Enum.map(&priority/1)
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

  defp find_common_chars(input) when is_list(input) do
    is_in_all = 1..length(input) |> Enum.sum()

    input
    |> Enum.map(&count_chars/1)
    |> Enum.with_index()
    |> Enum.into([], fn {map, index} -> Map.new(map, fn {k, _v} -> {k, index + 1} end) end)
    |> Enum.reduce(%{}, fn map, acc -> Map.merge(map, acc, fn _, a, b -> a + b end) end)
    |> Map.filter(fn {_k, v} -> v == is_in_all end)
    |> Map.keys()
  end

  defp count_chars(input) when is_bitstring(input) do
    input
    |> String.codepoints()
    |> Enum.reduce(%{}, fn char, acc -> Map.update(acc, char, 1, fn x -> x + 1 end) end)
  end
end
