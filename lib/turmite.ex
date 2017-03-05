defmodule Turmite do

  def create(size) when is_integer(size) do
    grid = Grid.create(size)
    create(grid)
  end

  def create(initial_grid) do
    %{
      grid: initial_grid,
      ant: %{
        position: Grid.center(initial_grid),
        orientation: :north,
        state: 0
      }
    }
  end

  def toggle_state(turmite) do
    Map.update!(turmite, :ant, fn ant ->
      Map.update!(ant, :state, fn state ->
        state == 0 && 1 || 0 end) end)
  end

  def toggle_color(turmite) do
    %{ant: %{position: {x, y}}} = turmite
    Map.update!(turmite, :grid, &(Grid.toggle(&1, x, y)))
  end

  def foward(turmite) do
    %{ant: %{position: {x, y}, orientation: orientation}} = turmite
    new_position = case orientation do
      :north -> {x, y + 1}
      :east -> {x + 1, y}
      :south -> {x, y - 1}
      :west -> {x - 1, y}
    end

    Map.update!(turmite, :ant, fn ant ->
      Map.put(ant, :position, new_position) end)
  end

  def new_orientation(orientation, rotation) do
    case {orientation, rotation} do
      {:north, :right} -> :east
      {:east, :right} -> :south
      {:south, :right} -> :west
      {:west, :right} -> :north
    end
  end
  
  def rotate(turmite, where) do
    Map.update!(turmite, :ant, fn ant ->
      Map.update!(ant, :orientation, fn orientation ->
        new_orientation(orientation, where) end) end)
  end

  def step(turmite) do
    %{
      grid: grid,
      ant: %{
        position: {x, y},
        state: state
      }
    } = turmite
    current_color = Grid.get(grid, x, y) && 1 || 0
    
    case {state, current_color} do
      {0, 0} -> turmite 
        |> rotate(:right)
        |> toggle_color
        |> foward
      {0, 1} -> turmite
        |> rotate(:right)
        |> toggle_state
        |> foward
      {1, 0} -> turmite
        |> toggle_state
        |> foward
      {1, 1} -> turmite
        |> toggle_color
        |> foward
    end
  end

  def step_n(turmite, iterations) do
    case iterations do
      1 -> step(turmite)
      x -> step_n(step(turmite), x - 1)
    end
  end

end
