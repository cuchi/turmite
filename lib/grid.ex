defmodule Grid do
  
  defstruct(
    default: nil,
    cells: %{})

  def get(grid, x, y) do
    %{default: default, cells: cells} = grid

    case Map.get(cells, {x, y}) do
      nil -> default
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
   %{cells: cells} = grid
    boundaries = %{
      north: 0,
      east: 0,
      south: 0,
      west: 0
    }

    cells
    |> Map.keys
    |> Enum.reduce(boundaries, 
      fn({x, y}, %{north: n, east: e, south: s, west: w}) ->
        %{
          north: max(n, y),
          east: max(e, x),
          south: min(s, y),
          west: min(w, x)
        }
      end)
  end

  def show(_grid) do
    :not_implemented
  end
  
end