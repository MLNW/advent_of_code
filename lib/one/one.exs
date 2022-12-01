defmodule Elf do
  defstruct calories: 0
end

input =
  File.read!("input.txt")
  |> String.split("\n")
  |> Enum.chunk_by(fn x -> x == "" end)
  |> Enum.filter(fn [head | _] -> head != "" end)
  |> Enum.map(fn x -> Enum.reduce(x, 0, fn e, acc -> String.to_integer(e) + acc end) end)

most_calories = input |> Enum.max()
IO.puts("Most calories: #{most_calories}")

top_three_calories =
  input
  |> Enum.sort(:desc)
  |> Enum.take(3)
  |> Enum.reduce(&(&1 + &2))

IO.puts("Calories carried by top three: #{top_three_calories}")
