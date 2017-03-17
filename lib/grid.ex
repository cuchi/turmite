defmodule Grid do
  
  defstruct(
    default: nil,
    cells: %{})

  def get(grid, x, y) do
    case Map.get(grid.cells, {x, y}) do
      nil -> grid.default
      value -> value
    end
  end

  def set(grid, x, y, value) do
    %{default: default, cells: cells} = grid

    new_cells = case value do
      ^default -> Map.delete(cells, {x, y})
      _ -> Map.put(cells, {x, y}, value)
    end
    
    %Grid{default: default, cells: new_cells}
  end

  def boundaries(grid) do
    boundaries = %{
      north: 0,
      east: 0,
      south: 0,
      west: 0
    }

    grid.cells
    |> Map.keys
    |> Enum.reduce(boundaries, 
      fn({x, y}, boundaries) ->
        %{
          north: max(boundaries.north, y),
          east: max(boundaries.east, x),
          south: min(boundaries.south, y),
          west: min(boundaries.west, x)
        }
      end)
  end

  def size(grid) do
    Enum.count(grid.cells)
  end

  def to_matrix(grid) do
    %{
      south: min_y, 
      north: max_y, 
      west: min_x, 
      east: max_x
    } = boundaries(grid)
    for y <- max_y..min_y do
      for x <- min_x..max_x do
        Grid.get(grid, x, y)
      end
    end
  end
  
end