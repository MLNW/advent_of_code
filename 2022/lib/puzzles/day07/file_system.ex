defmodule Puzzles.Day07.FileSystem do
  alias Puzzles.Day07.Directory

  def new(), do: update(%{})

  def get(), do: Cachex.get!(:seven, :fs)

  def get(path) when is_bitstring(path), do: get() |> Map.get(path)
  def get(%Directory{} = dir), do: get(Directory.path(dir))
  def root(), do: get("/")

  def put(%Directory{} = directory) do
    get() |> Map.put(Directory.path(directory), directory) |> update()
    directory
  end

  defp update(fs), do: Cachex.put!(:seven, :fs, fs)
end
