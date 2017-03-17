defmodule PngImage do
    def save(filename, bytes, size) do
        {:ok, file} = :file.open(filename, [:write])
        config = %{
            size: size,
            mode: {:grayscale, 8},
            file: file
        }
        :ok = :png.create(config)
        |> :png.append({:data, bytes})
        |> :png.close
    end
end
