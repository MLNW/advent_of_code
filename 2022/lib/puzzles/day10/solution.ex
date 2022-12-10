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

  defp part(input) do
    input = input |> parse_input()

    %{
      x: 1,
      cycle: 0,
      current_instruction: nil,
      remaining_cycles: 0,
      signal_strengths: %{},
      pixels: %{}
    }
    |> cycle(input)
  end

  def part_one(input \\ nil) do
    input
    |> part()
    |> Map.get(:signal_strengths)
    |> Enum.map(fn {_key, value} -> value end)
    |> Enum.sum()
  end

  def part_two(input \\ nil) do
    input
    |> part()
    |> Map.get(:pixels)
    |> Enum.map(fn {_index, row} -> row |> Enum.reverse() |> Enum.join() end)
    |> Enum.reduce("", fn
      row, "" -> row <> "\n"
      row, acc -> "#{acc}#{row}\n"
    end)
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
    |> draw_pixel()
    |> cycle(program)
  end

  defp calc_signal_strength(%{cycle: c, x: x} = state) when c in [20, 60, 100, 140, 180, 220] do
    state
    |> Map.update!(:signal_strengths, fn strengths -> Map.put_new(strengths, c, c * x) end)
  end

  defp calc_signal_strength(state), do: state

  defp draw_pixel(%{x: x, cycle: c} = state) do
    row =
      cond do
        c <= 40 -> 0
        c <= 80 -> 1
        c <= 120 -> 2
        c <= 160 -> 3
        c <= 200 -> 4
        c <= 240 -> 5
      end

    index = rem(c - 1, 40)

    pixel = if index in (x - 1)..(x + 1), do: "#", else: "."

    state
    |> Map.update!(:pixels, fn pixels ->
      Map.update(pixels, row, [pixel], fn pixel_row -> [pixel] ++ pixel_row end)
    end)
  end

  defp execute({:noop}, x), do: x
  defp execute({:addx, amount}, x), do: x + amount
  defp execute(nil, x), do: x

  defp cycle_count({:addx, _}), do: 2
  defp cycle_count({:noop}), do: 1
end
