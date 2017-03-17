defmodule Turmite do

  defstruct(
    position: {0, 0},
    orientation: :north,
    grid: %Grid{default: 0},
    state: 0,
    transitions: %{
      # {state, color} => {new_state, new_color, rotation}
      {0, 0} => {0, 1, :right},
      {0, 1} => {1, 1, :right},
      {1, 0} => {0, 0, :nil},
      {1, 1} => {1, 0, :nil}
    })

  def step(turmite) do
    {new_state, new_color, rotation} = transition(turmite)
    turmite
    |> paint(new_color)
    |> set_state(new_state)
    |> rotate(rotation)
    |> foward
  end

  def step(turmite, iterations) do
    case iterations do
      1 -> step(turmite)
      x -> step(step(turmite), x - 1)
    end
  end

  def transition(turmite) do
    %{
      position: {x, y},
      state: state,
      grid: grid,
      transitions: transitions
    } = turmite

    color = Grid.get(grid, x, y)
    Map.get(transitions, {state, color})
  end

  def paint(turmite, color) do
    %{position: {x, y}, grid: grid} = turmite
    %{turmite | grid: Grid.set(grid, x, y, color)}
  end

  def set_state(turmite, new_state) do
    %{turmite | state: new_state}
  end

  def rotate(turmite, rotation) do
    %{orientation: orientation} = turmite
    %{turmite | orientation: new_orientation(orientation, rotation)}
  end

  def foward(turmite) do
    %{position: {x, y}, orientation: orientation} = turmite
    new_position = case orientation do
      :north -> {x, y + 1}
      :east -> {x + 1, y}
      :south -> {x, y - 1}
      :west -> {x - 1, y}
    end

    %{turmite | position: new_position}
  end

  def new_orientation(orientation, rotation) do
    case {orientation, rotation} do
      {current, :nil} -> current

      {:north, :right} -> :east
      {:east, :right} -> :south
      {:south, :right} -> :west
      {:west, :right} -> :north

      {:north, :left} -> :west
      {:east, :left} -> :north
      {:south, :left} -> :east
      {:west, :left} -> :south
      
      {:north, :u_turn} -> :south
      {:east, :u_turn} -> :west
      {:south, :u_turn} -> :north
      {:west, :u_turn} -> :east
    end
  end

  def extract_grid(turmite) do
    turmite.grid
  end

end
