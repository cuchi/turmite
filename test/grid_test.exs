defmodule GridTest do
  use ExUnit.Case
  doctest Grid

  test "Get a value" do
    grid = %Grid{}
    assert Grid.get(grid, 5, 6) == nil
  end
  
  test "Get a value with a custom default" do
    grid = %Grid{default: :nothing}
    assert Grid.get(grid, 5, 6) == :nothing
  end

end
