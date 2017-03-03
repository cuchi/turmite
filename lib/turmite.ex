defmodule Turmite do

  def create_grid(size) do
    for _ <- 1..size do
      List.duplicate 0, size
    end
  end

  defp pretty_line(line) do
    Enum.join(line, " ")
  end

  def show_grid(grid) do
    for line <- grid do
      IO.puts (pretty_line line)
    end
    :ok
  end

  def center(grid) do
    case is_list(grid) && div(Enum.count(grid), 2) do
      x when x == false -> :invalid_grid
      x when x > 0 -> {x, x}
      _ -> :invalid_grid
    end
  end

  def get(grid, x, y) do
    grid
      |> Enum.at(x)
      |> Enum.at(y)
  end

  def set(grid, x, y, val) do
    List.update_at(grid, x, fn line ->
      List.replace_at(line, y, val) 
    end)
  end

end
