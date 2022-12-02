defmodule Puzzles.Two do
  def parse_input(input) when is_nil(input) do
    Common.Utils.read_input("two")
    |> parse_input()
  end

  def parse_input(input) do
    input
    |> String.split("\n")
    |> Enum.filter(&(&1 != ""))
    |> Enum.map(&(String.split(&1)))
    |> Enum.map(fn [a, b] -> [convert(a), convert(b)] end)
  end

  def part_one(input \\ nil) do
    input
    |> parse_input()
    |> Enum.map(fn [a, b] -> score(a, b) end)
    |> Enum.sum()
  end

  def convert(symbol) when symbol in ["A", "X"], do: :rock
  def convert(symbol) when symbol in ["B", "Y"], do: :paper
  def convert(symbol) when symbol in ["C", "Z"], do: :scissors

  def score(:rock), do: 1
  def score(:paper), do: 2
  def score(:scissors), do: 3

  def score(:lost), do: 0
  def score(:draw), do: 3
  def score(:won), do: 6

  def score(opponent, me), do: score(outcome(opponent, me)) + score(me)

  def outcome(x, y) when x == y, do: :draw
  def outcome(:rock, :paper), do: :won
  def outcome(:rock, :scissors), do: :lost
  def outcome(:paper, :rock), do: :lost
  def outcome(:paper, :scissors), do: :won
  def outcome(:scissors, :rock), do: :won
  def outcome(:scissors, :paper), do: :lost
end
