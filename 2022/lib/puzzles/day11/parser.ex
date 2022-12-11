defmodule Puzzles.Day11.Parser do
  alias Puzzles.Day11.Monkey

  def parse_input(input) when is_nil(input), do: Common.Utils.read_input(11) |> parse_input()

  def parse_input(input) do
    input
    |> String.split("\n\n")
    |> Enum.filter(&(&1 != ""))
    |> Enum.map(&parse_monkey/1)
    |> Enum.into(%{}, fn %Monkey{id: id} = monkey -> {id, monkey} end)
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
