defmodule Puzzles.Two do
  defp parse_input(input) when is_nil(input) do
    Common.Utils.read_input(2) |> parse_input()
  end

  defp parse_input(input) do
    input
    |> String.split("\n")
    |> Enum.filter(&(&1 != ""))
    |> Enum.map(&String.split(&1))
  end

  def part_one(input \\ nil) do
    part(input, &convert_one/1)
  end

  def part_two(input \\ nil) do
    part(input, &convert_two/1)
  end

  defp part(input, converter) do
    input
    |> parse_input()
    |> Enum.map(fn [a, b] -> [converter.(a), converter.(b)] end)
    |> Enum.map(fn [a, b] -> score(a, b) end)
    |> Enum.sum()
  end

  defp convert_one(symbol) when symbol in ["A", "X"], do: :rock
  defp convert_one(symbol) when symbol in ["B", "Y"], do: :paper
  defp convert_one(symbol) when symbol in ["C", "Z"], do: :scissors

  defp convert_two(symbol) when symbol in ["A", "B", "C"], do: convert_one(symbol)
  defp convert_two("X"), do: :loss
  defp convert_two("Y"), do: :draw
  defp convert_two("Z"), do: :win

  defp score(opponent, me), do: score(outcome(opponent, me)) + score(me)

  defp score(:rock), do: 1
  defp score(:paper), do: 2
  defp score(:scissors), do: 3

  defp score(:loss), do: 0
  defp score(:draw), do: 3
  defp score(:win), do: 6

  defp outcome(x, x), do: :draw
  defp outcome(:rock, :paper), do: :win
  defp outcome(:rock, :scissors), do: :loss
  defp outcome(:paper, :rock), do: :loss
  defp outcome(:paper, :scissors), do: :win
  defp outcome(:scissors, :rock), do: :win
  defp outcome(:scissors, :paper), do: :loss

  defp outcome(x, :draw), do: x
  defp outcome(:rock, :win), do: :paper
  defp outcome(:rock, :loss), do: :scissors
  defp outcome(:paper, :win), do: :scissors
  defp outcome(:paper, :loss), do: :rock
  defp outcome(:scissors, :win), do: :rock
  defp outcome(:scissors, :loss), do: :paper
end
