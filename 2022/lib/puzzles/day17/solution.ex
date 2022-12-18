defmodule Puzzles.Day17 do
  alias Puzzles.Day17.Cave
  alias Common.Coordinate
  alias Puzzles.Day17.Parser

  def part_one(input \\ nil) do
    # rock appears
    #   left edge 2 units away from left wall
    #   bottom edge 3 units away from last rock or on floor if there is none
    # alternate between
    #   pushed
    #   fall one unit
    #     *if already landed, start falling of a new rock
    # how tall is tower after 2022 rocks have stopped
    directions = input |> Parser.parse_input()

    {coordinate, _sign} =
      Cave.new()
      |> Cave.spawn(:minus)
      |> simulate(2022, directions)
      |> Cave.get_landed_rock()
      |> Enum.max_by(fn {%Coordinate{y: y}, _} -> y end)

    coordinate.y
  end

  defp simulate(cave, runs, directions, rock_type \\ :plus)

  defp simulate(cave, 0, _directions, _rock_type), do: cave

  defp simulate(cave, runs, [direction | directions], rock_type) do
    cave =
      cave
      |> push(direction)
      |> fall()

    rock_has_landed? = 0 == cave |> Cave.get_falling_rock() |> Map.values() |> length()

    cave =
      if rock_has_landed? do
        cave |> Cave.spawn(rock_type)
      else
        cave
      end

    new_rock_type = if rock_has_landed?, do: Cave.next_rock_type(rock_type), else: rock_type

    new_runs = if rock_has_landed?, do: runs - 1, else: runs

    cave
    |> simulate(new_runs, directions ++ [direction], new_rock_type)
  end

  defp push(cave, direction) do
    falling_rock = cave |> Cave.get_falling_rock()
    landed_rock = cave |> Cave.get_landed_rock()

    rock_touching_anything =
      falling_rock
      |> Enum.filter(fn {%Coordinate{x: x, y: y}, _value} ->
        cond do
          :left == direction and x == 1 -> true
          :right == direction and x == cave.width -> true
          :left == direction and landed_rock |> Map.get(Coordinate.new(x - 1, y)) -> true
          :right == direction and landed_rock |> Map.get(Coordinate.new(x + 1, y)) -> true
          true -> false
        end
      end)
      |> Enum.map(fn {%Coordinate{y: y}, _value} -> y end)

    # Filter falling rock
    falling_rock = if [] == rock_touching_anything, do: falling_rock, else: []

    # Second puzzle?
    # falling_rock =
    #  falling_rock
    #  |> Enum.filter(fn {%Coordinate{y: y}, _value} -> y not in rock_touching_anything end)

    # Remove falling rock
    cave =
      falling_rock
      |> Enum.reduce(cave, fn {key, _value}, acc -> %{acc | state: Map.delete(acc.state, key)} end)

    # Push the falling rock
    falling_rock
    |> Enum.map(fn {%Coordinate{x: x} = rock, value} ->
      case direction do
        :left -> {%{rock | x: x - 1}, value}
        :right -> {%{rock | x: x + 1}, value}
      end
    end)
    |> Enum.reduce(cave, fn {rock, sign}, acc ->
      %{acc | state: acc.state |> Map.put(rock, sign)}
    end)
  end

  defp fall(cave) do
    falling_rock = cave |> Cave.get_falling_rock()
    landed_rock = cave |> Cave.get_landed_rock()

    # Check if rock has landed
    rock_touching_anything =
      falling_rock
      |> Enum.filter(fn {%Coordinate{x: x, y: y}, _value} ->
        cond do
          y == 1 -> true
          landed_rock |> Map.get(Coordinate.new(x, y - 1)) -> true
          true -> false
        end
      end)

    # Ensure that the entire rock lands
    rock_touching_anything = if [] == rock_touching_anything, do: [], else: falling_rock

    # Update sign for landed rock
    cave =
      rock_touching_anything
      |> Enum.reduce(cave, fn {rock, _sign}, acc ->
        %{acc | state: acc.state |> Map.update!(rock, fn _ -> "#" end)}
      end)

    # Do not fall rock that has landed
    falling_rock = if [] == rock_touching_anything, do: falling_rock, else: []

    # Simulate falling
    cave =
      falling_rock
      |> Enum.reduce(cave, fn {key, _value}, acc -> %{acc | state: Map.delete(acc.state, key)} end)

    falling_rock
    |> Enum.map(fn {%Coordinate{y: y} = rock, value} -> {%{rock | y: y - 1}, value} end)
    |> Enum.reduce(cave, fn {rock, sign}, acc ->
      %{acc | state: acc.state |> Map.put(rock, sign)}
    end)
  end
end
