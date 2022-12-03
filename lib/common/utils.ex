defmodule Common.Utils do
  def read_input(number) do
    Path.join(:code.priv_dir(:advent_of_code_2022), "input/input.#{number}.txt")
    |> File.read!()
  end
end
