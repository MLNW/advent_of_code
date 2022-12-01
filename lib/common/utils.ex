defmodule Common.Utils do
  def read_input(number, name \\ "input.txt") do
    Path.join(:code.priv_dir(:advent_of_code_2022), "input/#{number}/#{name}")
    |> File.read!()
  end
end
