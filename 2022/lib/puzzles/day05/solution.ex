defmodule Puzzles.Day05 do
  defp parse_input(input) when is_nil(input) do
    Common.Utils.read_input(5) |> parse_input()
  end

  defp parse_input(input) do
    [stacks | [numbering | [instructions]]] =
      input
      |> String.split("\n")
      |> Enum.chunk_by(fn line -> String.trim_leading(line) |> String.starts_with?("1") end)

    {parse_stacks(stacks, numbering), parse_instructions(instructions)}
  end

  defp parse_stacks(stacks, [numbering]) do
    numbering = numbering |> String.split() |> Enum.map(&String.to_integer/1)

    lines =
      stacks
      |> Enum.map(&parse_stack_line([], &1, length(numbering)))

    for index <- numbering, line <- lines do
      {element, _rest} = line |> List.pop_at(index - 1)
      {index, element}
    end
    |> Enum.filter(fn {_index, x} -> x != nil end)
    |> Enum.reduce(%{}, fn {index, x}, acc ->
      Map.update(acc, index, [x], fn current -> current ++ [x] end)
    end)
  end

  defp parse_stack_line(stack, "", n) do
    case length(stack) == n do
      true -> stack
      # Ensure all lines have the same amount of elements
      false -> parse_stack_line(stack ++ [nil], "", n)
    end
  end

  defp parse_stack_line(stack, line, n) do
    {element, rest} = String.split_at(line, 4)

    element = element |> String.trim() |> String.at(1)

    parse_stack_line(stack ++ [element], rest, n)
  end

  defp parse_instructions(instructions) do
    instructions
    |> Enum.filter(fn x -> x != "" end)
    |> Enum.map(&String.split(&1, ~r/\D+\s/, trim: true))
    |> Enum.map(fn line -> line |> Enum.map(&String.to_integer/1) end)
    |> Enum.map(&List.to_tuple/1)
  end

  defp part(input, mode) do
    result =
      input
      |> parse_input()
      |> execute(mode)

    for {_, v} <- result, into: [] do
      List.first(v, "")
    end
    |> Enum.join("")
  end

  def part_one(input \\ nil) do
    part(input, :one_by_one)
  end

  def part_two(input \\ nil) do
    part(input, :at_once)
  end

  defp execute({stacks, []}, _), do: stacks

  defp execute({stacks, [instruction | instructions]}, mode) do
    {execute_instruction(instruction, stacks, mode), instructions}
    |> execute(mode)
  end

  defp execute_instruction({0, _, _}, stacks, :one_by_one), do: stacks

  defp execute_instruction({move, from, to}, stacks, :one_by_one) do
    {value, stacks} = Map.get_and_update(stacks, from, fn [v | rest] -> {[v], rest} end)
    stacks = Map.update!(stacks, to, fn current -> value ++ current end)
    execute_instruction({move - 1, from, to}, stacks, :one_by_one)
  end

  defp execute_instruction({move, from, to}, stacks, :at_once) do
    {value, stacks} = Map.get_and_update(stacks, from, fn stack -> Enum.split(stack, move) end)
    Map.update!(stacks, to, fn current -> value ++ current end)
  end
end
