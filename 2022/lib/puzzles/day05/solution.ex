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

  defp parse_stacks(stacks, numbering) do
    numbering =
      numbering
      |> Enum.map(&String.split/1)
      |> List.first()
      |> Enum.map(&String.to_integer/1)

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
    |> Enum.map(fn line -> String.split(line, ~r/\D+\s/, trim: true) end)
    |> Enum.map(fn line -> line |> Enum.map(&String.to_integer/1) end)
  end

  def part_one(input \\ nil) do
    result =
      input
      |> parse_input()
      |> execute()

    for {_, v} <- result, into: [] do
      List.first(v, "")
    end
    |> Enum.reduce("", fn x, acc -> acc <> x end)
  end

  defp execute({stacks, []}), do: stacks

  defp execute({stacks, [instruction | instructions]}) do
    execute({execute_instruction(instruction, stacks), instructions})
  end

  defp execute_instruction([0 | _], stacks), do: stacks

  defp execute_instruction([move | [from | [to]]], stacks) do
    {value, stacks} = Map.get_and_update(stacks, from, fn [v | rest] -> {v, rest} end)
    stacks = Map.update!(stacks, to, fn current -> [value] ++ current end)
    execute_instruction([move - 1, from, to], stacks)
  end
end
