defmodule Puzzles.Day09 do
  alias Puzzles.Day09.Coordinate
  alias Puzzles.Day09.RopeState
  defp parse_input(input) when is_nil(input), do: Common.Utils.read_input(9) |> parse_input()

  defp parse_input(input) do
    input
    |> String.split("\n")
    |> Enum.filter(&(&1 != ""))
    |> Enum.map(&String.split(&1))
    |> Enum.map(fn [motion | [amount]] ->
      {parse_motion(motion), String.to_integer(amount)}
    end)
  end

  defp parse_motion("R"), do: :right
  defp parse_motion("L"), do: :left
  defp parse_motion("U"), do: :up
  defp parse_motion("D"), do: :down

  def part_one(input \\ nil) do
    input = input |> parse_input()

    [RopeState.new()]
    |> simulate_motions(input)
    |> Enum.map(fn %RopeState{tail: tail} -> tail end)
    |> Enum.uniq()
    |> length()
  end

  defp simulate_motions(state, []), do: state

  defp simulate_motions(state, [motion | rest]) do
    simulate_motion(state, motion)
    |> simulate_motions(rest)
  end

  def simulate_motion(state, {motion, 0}), do: state

  def simulate_motion(state, {motion, amount}) do
    [%RopeState{head: head, tail: tail} | _past] = state

    new_head = head |> move(motion)

    new_tail = move_tail(tail, new_head, motion)

    new_state = %RopeState{head: new_head, tail: new_tail}

    simulate_motion([new_state] ++ state, {motion, amount - 1})
  end

  def move(%Coordinate{x: x, y: y}, :right), do: %Coordinate{x: x + 1, y: y}
  def move(%Coordinate{x: x, y: y}, :left), do: %Coordinate{x: x - 1, y: y}
  def move(%Coordinate{x: x, y: y}, :up), do: %Coordinate{x: x, y: y + 1}
  def move(%Coordinate{x: x, y: y}, :down), do: %Coordinate{x: x, y: y - 1}

  def move_tail(tail, head, motion) do
    vector = head |> Coordinate.subtract(tail)
    magnitude = calc_magnitude(vector)

    cond do
      magnitude in [2, -2] -> tail |> move(motion)
      magnitude <= 1.5 -> tail
      true -> head |> move_diagonally(motion)
    end
  end

  defp move_diagonally(head, :right), do: head |> move(:left)
  defp move_diagonally(head, :left), do: head |> move(:right)
  defp move_diagonally(head, :up), do: head |> move(:down)
  defp move_diagonally(head, :down), do: head |> move(:up)

  defp calc_magnitude(%Coordinate{x: x, y: y}), do: :math.sqrt(:math.pow(x, 2) + :math.pow(y, 2))
end
