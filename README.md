# Turmite

Purposes of this project for me:
* Implement the turmite Turing machine _(yeah, really!)_
* Learn Elixir
* Learn to program better in the functional paradigm
* Showcase some of the Elixir features

Currently, it does only the core stuff, you can call `iex -S mix` in the project folder and use it within the shell:
```elixir
iex> t = %Turmite{}
%Turmite{grid: %Grid{cells: %{}, default: 0}, orientation: :north,
 position: {0, 0}, state: 0,
 transitions: %{{0, 0} => {0, 1, :right}, {0, 1} => {1, 1, :right},
   {1, 0} => {0, 0, nil}, {1, 1} => {1, 0, nil}}}

iex> Turmite.step(t, 100)
%Turmite{grid: %Grid{cells: %{{-4, -4} => 1, {-4, -1} => 1, {-3, -4} => 1,
    {-3, -3} => 1, {-3, 0} => 1, {-3, 1} => 1, {-3, 2} => 1, {-2, -3} => 1,
    {-2, -1} => 1, {-2, 0} => 1, {-2, 2} => 1, {-1, -4} => 1, {-1, -3} => 1,
    {-1, 1} => 1, {-1, 2} => 1, {0, -3} => 1, {0, -2} => 1, {0, -1} => 1,
    {0, 1} => 1, {0, 2} => 1, {1, -3} => 1, {1, -1} => 1, {1, 1} => 1,
    {2, -1} => 1, {2, 0} => 1, {2, 1} => 1, {2, 2} => 1, {3, -3} => 1,
    {3, -2} => 1, {3, 2} => 1}, default: 0}, orientation: :east,
 position: {-3, -1}, state: 0,
 transitions: %{{0, 0} => {0, 1, :right}, {0, 1} => {1, 1, :right},
   {1, 0} => {0, 0, nil}, {1, 1} => {1, 0, nil}}}
```

## Next steps
* CLI
* Export to a png file
* Docs
* Tests