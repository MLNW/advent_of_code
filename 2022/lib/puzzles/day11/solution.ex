defmodule Puzzles.Day11 do
  alias Puzzles.Day11.Parser
  alias Puzzles.Day11.Monkey

  def part_one(input \\ nil), do: input |> Parser.parse_input(false) |> part(20)
  def part_two(input \\ nil), do: input |> Parser.parse_input(true) |> part(10000)

  defp part(input, rounds) do
    [first | [second]] =
      input
      |> rounds(rounds)
      # |> IO.inspect(charlists: :as_lists)
      |> Enum.map(fn {_id, monkey} -> monkey.inspections end)
      |> Enum.sort(:desc)
      |> Enum.take(2)

    first * second
  end

  defp rounds(monkeys, 0), do: monkeys

  defp rounds(monkeys, remaining) do
    Enum.reduce(monkeys, monkeys, fn {id, _monkey}, acc ->
      acc |> Map.get(id) |> Monkey.take_turn(acc)
    end)
    |> rounds(remaining - 1)
  end
end
