defmodule Puzzles.Day11.Parser do
  alias Puzzles.Day11.Monkey

  def parse_input(input, super_modulo?) when is_nil(input),
    do: Common.Utils.read_input(11) |> parse_input(super_modulo?)

  def parse_input(input, super_modulo?) do
    result =
      input
      |> String.split("\n\n")
      |> Enum.filter(&(&1 != ""))
      |> Enum.map(&parse_monkey(&1))
      |> Enum.into(%{}, fn %Monkey{id: id} = monkey -> {id, monkey} end)

    if super_modulo? do
      super_modulo =
        result
        |> Enum.reduce(1, fn {_id, monkey}, acc -> acc * monkey.test end)

      result
      |> Enum.into(%{}, fn {id, monkey} ->
        {id, monkey |> Map.update!(:super_modulo, fn _ -> super_modulo end)}
      end)
    else
      result
    end
  end

  defp parse_monkey(input) do
    [index | [items | [operation | [test | [right | [wrong]]]]]] =
      input
      |> String.split("\n")
      |> Enum.map(&String.trim/1)

    %Monkey{
      id: index |> String.at(7) |> String.to_integer(),
      items:
        items
        |> String.replace("Starting items: ", "")
        |> String.split(", ")
        |> Enum.map(&String.to_integer/1),
      operation:
        operation
        |> String.replace("Operation: new = old ", "")
        |> String.split()
        |> parse_operation(),
      test: test |> String.replace("Test: divisible by ", "") |> String.to_integer(),
      right: right |> String.replace("If true: throw to monkey ", "") |> String.to_integer(),
      wrong: wrong |> String.replace("If false: throw to monkey ", "") |> String.to_integer()
    }
  end

  defp parse_operation([operator | [parameter]]) do
    {parse_operator(operator), parse_parameter(parameter)}
  end

  defp parse_operator("+"), do: &Kernel.+/2
  defp parse_operator("*"), do: &Kernel.*/2

  defp parse_parameter("old"), do: :old
  defp parse_parameter(int), do: int |> String.to_integer()
end
