defmodule Elf do
  defstruct calories: 0
end

File.read!("input.txt")
|> String.split("\n")
|> Enum.chunk_by(fn x -> x == "" end)
|> Enum.filter(fn [head | _] -> head != "" end)
|> Enum.map(fn x -> Enum.reduce(x, 0, fn e, acc -> String.to_integer(e) + acc end) end)
|> Enum.max()
|> IO.inspect()
