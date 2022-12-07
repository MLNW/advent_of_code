defmodule Puzzles.Day07 do
  alias Puzzles.Day07.Directory
  alias Puzzles.Day07.FileSystem

  defp parse_input(input) when is_nil(input), do: Common.Utils.read_input(7) |> parse_input()

  defp parse_input(input) do
    input
    |> String.split("$")
    |> Enum.map(&String.split(&1, "\n"))
    |> Enum.map(&(&1 |> Enum.map(fn x -> String.trim(x) end) |> Enum.filter(fn x -> x != "" end)))
    |> Enum.filter(&(&1 != []))
    |> List.delete_at(0)
  end

  defp part(input) do
    Cachex.start_link(name: :seven)
    FileSystem.new()
    input |> parse_input() |> execute(Directory.new("/"))

    FileSystem.get()
    |> Enum.map(fn {_path, dir} -> dir |> Directory.calculate_size() end)
  end

  def part_one(input \\ nil) do
    part(input)
    |> Enum.filter(&(&1 <= 100_000))
    |> Enum.sum()
  end

  def part_two(input \\ nil) do
    sorted_sizes = part(input) |> Enum.sort()

    required = 30_000_000
    total = 70_000_000
    current = FileSystem.root() |> Directory.calculate_size()

    needed = required - (total - current)

    sorted_sizes |> Enum.find(&(&1 >= needed))
  end

  defp execute([], directory), do: directory

  defp execute([[command | output] | commands], directory) do
    directory =
      cond do
        String.starts_with?(command, "cd") -> cd(command, directory)
        command == "ls" -> directory |> Directory.ls(output)
      end

    execute(commands, directory)
  end

  defp cd(command, directory) do
    name = command |> String.split() |> List.last()

    case name do
      ".." ->
        %{directory.parent | children: [directory | directory.parent.children]}

      dir ->
        path =
          "#{Directory.path(directory)}/#{name}"
          |> String.replace("//", "/")

        FileSystem.get(path) |> Directory.find(dir)
    end
  end
end
