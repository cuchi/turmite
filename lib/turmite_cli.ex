defmodule Turmite.CLI do
  def main(args \\ []) do
    args
    |> parse_args
    |> run
    |> show_result
  end

  defp parse_args(args) do
    {opts, _, _} =
      args
      |> OptionParser.parse(switches: [iterations: :integer])
    opts
  end

  defp run(opts) do
    case opts[:iterations] do
      nil -> {:error, "Iteration number is not defined!"}
      x -> generate_turmite(x)
    end
  end

  defp generate_turmite(iterations)
    when iterations <= 0 do
      {:error, "Iteration number must be greater than 0!"}
    end

  defp generate_turmite(iterations) do
    matrix = %Turmite{}
    |> Turmite.step(iterations)
    |> Turmite.extract_grid
    |> Grid.to_matrix

    {:ok, matrix}
  end

  defp show_result({:ok, message}) do
    IO.puts('SUCCESS: #{message}')
  end

  defp show_result({:error, reason}) do
    IO.puts('ERROR: #{reason}')
    System.halt(1)
  end
end