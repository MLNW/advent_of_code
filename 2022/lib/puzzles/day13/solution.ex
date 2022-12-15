defmodule Puzzles.Day13 do
  alias Puzzles.Day13.Parser

  def part_one(input \\ nil) do
    input
    |> Parser.parse_input()
    |> Enum.chunk_every(2)
    |> Enum.map(fn [a | [b]] -> {a, b} end)
    |> Enum.map(&is_sorted?/1)
    |> Enum.with_index(1)
    |> Enum.filter(fn {pair_is_sorted, _index} -> pair_is_sorted end)
    |> Enum.map(fn {_pair, index} -> index end)
    |> Enum.sum()
  end

  def part_two(input \\ nil) do
    divider_packets = [[[2]], [[6]]]

    [a | [b]] =
      input
      |> Parser.parse_input()
      |> Kernel.++(divider_packets)
      |> Enum.sort(&is_sorted?({&1, &2}))
      |> Enum.with_index(1)
      |> Enum.filter(fn {x, _index} -> x in divider_packets end)
      |> Enum.map(fn {_x, index} -> index end)

    a * b
  end

  def is_sorted?({a, b}) when is_integer(a) and is_integer(b) do
    cond do
      a < b -> true
      a > b -> false
      a == b -> :continue
    end
  end

  def is_sorted?({a, b}) when is_list(a) and is_integer(b), do: is_sorted?({a, [b]})
  def is_sorted?({a, b}) when is_list(b) and is_integer(a), do: is_sorted?({[a], b})
  def is_sorted?({[], []}), do: :continue
  def is_sorted?({[], b}) when is_list(b), do: true
  def is_sorted?({a, []}) when is_list(a), do: false

  def is_sorted?({[head_a | tail_a], [head_b | tail_b]}) do
    case is_sorted?({head_a, head_b}) do
      :continue -> is_sorted?({tail_a, tail_b})
      true -> true
      false -> false
    end
  end
end
