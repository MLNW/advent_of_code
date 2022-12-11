defmodule Puzzles.Day11.Monkey do
  alias Puzzles.Day11.Monkey
  defstruct id: 0, items: [], operation: nil, test: 0, right: 0, wrong: 0, inspections: 0

  @type id :: pos_integer()
  @type t :: %Monkey{
          id: id(),
          items: list(id()),
          operation: {fun(), atom()},
          right: id(),
          wrong: id(),
          inspections: pos_integer()
        }

  def take_turn(monkey, monkeys) do
    {items, updated_monkey} =
      monkey
      |> Map.update!(:inspections, &(&1 + length(monkey.items)))
      |> Map.get_and_update!(:items, fn current -> {current, []} end)

    inspect(items, updated_monkey, monkeys)
  end

  defp inspect([], monkey, monkeys), do: monkeys |> Map.update!(monkey.id, fn _ -> monkey end)

  defp inspect([item | items], monkey, monkeys) do
    {function, parameter} = monkey.operation

    worry =
      case parameter do
        :old -> function.(item, item)
        x -> function.(item, x)
      end

    worry = div(worry, 3)

    updated_monkeys =
      case rem(worry, monkey.test) == 0 do
        true -> throw_item(worry, monkey.right, monkeys)
        false -> throw_item(worry, monkey.wrong, monkeys)
      end

    inspect(items, monkey, updated_monkeys)
  end

  defp throw_item(item, target, monkeys) do
    monkeys
    |> Map.update!(target, fn monkey ->
      monkey |> Map.update!(:items, fn items -> items ++ [item] end)
    end)
  end
end
