defmodule Puzzles.Day10 do
  defp parse_input(input) when is_nil(input), do: Common.Utils.read_input(10) |> parse_input()

  defp parse_input(input) do
    input
    |> String.split("\n")
    |> Enum.filter(&(&1 != ""))
    |> Enum.map(&String.split(&1))
    |> Enum.map(fn
      [command | []] -> {parse_command(command)}
      [command | [amount]] -> {parse_command(command), String.to_integer(amount)}
    end)
  end

  defp parse_command("addx"), do: :addx
  defp parse_command("noop"), do: :noop

  def part_one(input \\ nil) do
    input = input |> parse_input()

    %{
      x: 1,
      cycle: 0,
      current_instruction: nil,
      remaining_cycles: 0,
      signal_strengths: %{}
    }
    |> cycle(input)
    |> Map.get(:signal_strengths)
    |> Enum.map(fn {_key, value} -> value end)
    |> Enum.sum()
  end

  defp cycle(%{remaining_cycles: 0} = state, []) do
    state
    |> Map.update!(:x, fn x -> execute(state.current_instruction, x) end)
  end

  defp cycle(%{remaining_cycles: 0} = state, [instruction | program]) do
    state
    |> Map.update!(:x, fn x -> execute(state.current_instruction, x) end)
    |> Map.update!(:current_instruction, fn _ -> instruction end)
    |> Map.update!(:remaining_cycles, fn _ -> cycle_count(instruction) end)
    |> cycle(program)
  end

  defp cycle(state, program) do
    state
    |> Map.update!(:cycle, &(&1 + 1))
    |> Map.update!(:remaining_cycles, &(&1 - 1))
    |> calc_signal_strength()
    |> cycle(program)
  end

  defp calc_signal_strength(%{cycle: c, x: x} = state) when c in [20, 60, 100, 140, 180, 220] do
    state
    |> Map.update!(:signal_strengths, fn strengths -> Map.put_new(strengths, c, c * x) end)
  end

  defp calc_signal_strength(state), do: state

  defp execute({:noop}, x), do: x
  defp execute({:addx, amount}, x), do: x + amount
  defp execute(nil, x), do: x

  defp cycle_count({:addx, _}), do: 2
  defp cycle_count({:noop}), do: 1
end
