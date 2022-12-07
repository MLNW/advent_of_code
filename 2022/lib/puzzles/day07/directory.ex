defmodule Puzzles.Day07.Directory do
  defstruct name: nil, parent: nil, size: nil, children: []

  alias Puzzles.Day07.Directory
  alias Puzzles.Day07.File
  alias Puzzles.Day07.FileSystem

  @type t :: %Puzzles.Day07.Directory{
          name: String.t(),
          parent: nil | t,
          size: nil | integer(),
          children: [t | Puzzles.Day07.File.t()]
        }

  def new(name, parent \\ nil), do: %Directory{name: name, parent: parent}

  def ls(directory, []), do: directory |> FileSystem.put()

  def ls(directory, [line | output]) do
    child = line |> parse_child(directory)

    %{directory | children: [child] ++ directory.children}
    |> ls(output)
  end

  def find(%Directory{} = parent, child) when parent.name == child, do: parent

  def find(%Directory{} = parent, child) do
    parent.children
    |> Enum.find(&(&1.name == child))
  end

  def root(%Directory{} = dir) when is_nil(dir.parent), do: dir
  def root(%Directory{} = dir), do: root(dir.parent)

  def path(directory, path \\ "")
  def path(%Directory{name: name, parent: parent}, path) when is_nil(parent), do: name <> path

  def path(%Directory{name: name, parent: parent}, ""), do: path(parent, name)

  def path(%Directory{name: name, parent: parent}, path),
    do: path(parent, "#{name}/#{path}")

  def calculate_size(%Directory{size: size}) when not is_nil(size), do: size

  def calculate_size(directory) do
    size =
      directory.children
      |> Enum.map(fn
        %File{size: size} -> size
        %Directory{} = child -> child |> FileSystem.get() |> calculate_size()
      end)
      |> Enum.sum()

    FileSystem.put(%{directory | size: size})
    size
  end

  defp parse_child(child, parent) do
    cond do
      child |> String.starts_with?("dir") ->
        dir =
          child
          |> String.split()
          |> List.last()
          |> new(%{parent | children: []})

        dir |> FileSystem.put()

      child ->
        [size | [name]] = child |> String.split()
        %File{name: name, size: size |> String.to_integer()}
    end
  end
end
