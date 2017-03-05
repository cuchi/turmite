defmodule Grid do
  
  def create(size) do
    {size, MapSet.new}
  end

  def show(grid) do
    {size, _} = grid
    last_index = size - 1
    for x <- 0..last_index do
      for y <- 0..last_index do
        get(grid, x, y) && 1 || 0
      end
      |> Enum.join(" ")
      |> IO.puts
    end
    :ok
  end

  def center({size, _}) do
    center = div(size, 2)
    {center, center}
  end

  def get({_, cells}, x, y) do
    MapSet.member?(cells, {x, y})
  end

  def toggle({size, cells}, x, y) do
    new_cells = MapSet.member?(cells, {x, y})
      && MapSet.delete(cells, {x, y})
      || MapSet.put(cells, {x, y})
    {size, new_cells}
  end
  
end