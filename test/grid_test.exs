defmodule GridTest do
  use ExUnit.Case
  doctest Grid

  test "create and get all" do
    grid = Grid.create 20
    values = for x <- 0..19, y <- 0..19 do
      Grid.get grid, x, y
    end
    assert Enum.count(values) == 20 * 20
    assert Enum.all?(values, fn x -> x == false end)
  end

  test "get center" do
    grid20 = Grid.create 20
    assert Grid.center(grid20) == {10, 10}

    grid15 = Grid.create 15
    assert Grid.center(grid15) == {7, 7}
  end

  test "toggle" do
    grid = Grid.create 30
    newGrid = grid
      |> Grid.toggle(5, 5)
      |> Grid.toggle(6, 6)
      |> Grid.toggle(10, 15)
      |> Grid.toggle(16, 17)

    values = for x <- 0..29, y <- 0..29 do
      Grid.get newGrid, x, y
    end
    
    assert (
      values 
      |> Enum.filter(fn x -> x == true end)
      |> Enum.count) == 4
  end

end
