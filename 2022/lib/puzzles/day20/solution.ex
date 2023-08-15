defmodule Puzzles.Day20 do
  alias Puzzles.Day20.Element
  alias Puzzles.Day20.Parser

  def part_one(input \\ nil) do
    # Shift each number by its amount, but only once, in the order they originally
    # appeared. Then sum the numbers at places 1000, 2000, 3000 after the number 0.
    # The input consists of non-unique positive and negative integers

    original_numbers = input |> Parser.parse_input()

    length = original_numbers |> Map.values() |> length()

    mixed_numbers =
      mix(
        original_numbers,
        original_numbers |> Map.values(),
        length - 1
      )

    {a, b, c} = calculate_coordinates(mixed_numbers, length) |> IO.inspect()
    a.number + b.number + c.number
  end

  def mix(result, [], _length), do: result

  def mix(result, [%Element{number: number} = element | elements], length) do
    {current_index, element} = result |> Enum.find(fn {_index, e} -> e == element end)

    new_index = new_index(current_index, number, length)

    # TODO: How to handle moves longer than the list
    current_index..new_index
    |> Stream.chunk_every(2, 1, :discard)
    |> Enum.reduce(result, &swap/2)
    |> Map.put(new_index, element)
    |> mix(elements, length)
  end

  defp new_index(current_index, number, length) do
    result = Integer.mod(current_index + number, length)

    if number < 0 and result == 0, do: length, else: result
  end

  defp swap([a | [b]], map) do
    temp_a = map |> Map.get(a)
    temp_b = map |> Map.get(b)

    map
    |> Map.put(b, temp_a)
    |> Map.put(a, temp_b)
  end

  defp calculate_coordinates(mixed_numbers, length) do
    {zero_index, _zero} = mixed_numbers |> Enum.find(fn {_index, e} -> e.number == 0 end)

    {
      mixed_numbers |> Map.get(rem(1000 + zero_index, length)),
      mixed_numbers |> Map.get(rem(2000 + zero_index, length)),
      mixed_numbers |> Map.get(rem(3000 + zero_index, length))
    }
  end
end
