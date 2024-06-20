defmodule Mix.Tasks.ExportBdf do
  def run([rom_path]) do
    bdf_path = Path.absname("./output/kumdor_latin.bdf")
    bdf_data = Path.absname(rom_path)
    |> File.read!()
    |> FontExtractor.get_character_table()
    |> BdfExporter.from_char_table()
    IO.puts("Writing BDF file to #{bdf_path}")
    File.write!(bdf_path, bdf_data)
  end
end
