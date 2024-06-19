defmodule Mix.Tasks.ExtractFont do
  def run([rom_path]) do
    Path.absname(rom_path)
    |> File.read!()
    |> KumdorFont.get_character_table()
    |> Enum.each(fn {index, character} ->
      character_path =
        Path.join("output","char_#{index}.png")
        |> Path.absname()

      character_mat = KumdorFont.character_to_mat(character)

      IO.puts("Writing character #{index} to #{character_path}")

      Evision.imwrite(character_path, character_mat)
    end)
  end
end
