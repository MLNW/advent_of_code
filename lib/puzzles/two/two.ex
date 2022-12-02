defmodule Puzzles.Two do
  def parse_input(input) when is_nil(input) do
    Common.Utils.read_input("two")
    |> parse_input()
  end

  def parse_input(input) do
    input
    |> String.split("\n")
    |> Enum.filter(&(&1 != ""))
    |> Enum.map(&String.split(&1))
  end

  def part_one(input \\ nil) do
    part(input, &convert_one/1, &score_one/2)
  end

  def part_two(input \\ nil) do
    part(input, &convert_two/1, &score_two/2)
  end

  defp part(input, converter, scorer) do
    input
    |> parse_input()
    |> Enum.map(fn [a, b] -> [converter.(a), converter.(b)] end)
    |> Enum.map(fn [a, b] -> scorer.(a, b) end)
    |> Enum.sum()
  end

  def convert_one(symbol) when symbol in ["A", "X"], do: :rock
  def convert_one(symbol) when symbol in ["B", "Y"], do: :paper
  def convert_one(symbol) when symbol in ["C", "Z"], do: :scissors

  def convert_two(symbol) when symbol in ["A", "B", "C"], do: convert_one(symbol)
  def convert_two("X"), do: :lost
  def convert_two("Y"), do: :draw
  def convert_two("Z"), do: :won

  def score(:rock), do: 1
  def score(:paper), do: 2
  def score(:scissors), do: 3

  def score(:lost), do: 0
  def score(:draw), do: 3
  def score(:won), do: 6

  def score_one(opponent, me), do: score(outcome(opponent, me)) + score(me)
  def score_two(oppenent, plan), do: score(plan) + score(outcome(oppenent, plan))

  def outcome(x, y) when x == y, do: :draw
  def outcome(:rock, :paper), do: :won
  def outcome(:rock, :scissors), do: :lost
  def outcome(:paper, :rock), do: :lost
  def outcome(:paper, :scissors), do: :won
  def outcome(:scissors, :rock), do: :won
  def outcome(:scissors, :paper), do: :lost

  def outcome(x, :draw), do: x
  def outcome(:rock, :won), do: :paper
  def outcome(:rock, :lost), do: :scissors
  def outcome(:paper, :won), do: :scissors
  def outcome(:paper, :lost), do: :rock
  def outcome(:scissors, :won), do: :rock
  def outcome(:scissors, :lost), do: :paper
end
