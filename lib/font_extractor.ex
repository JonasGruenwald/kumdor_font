defmodule FontExtractor do
  alias Evision.Mat

  @moduledoc """
  Font parsing notes:
  - The font section starts at 0x12000 in the ROM and ends at 0x12800
  - Each character is 0x10 = 16 bytes, where each byte is a row of the character.
  - The characters are in the order of the ASCII table, all 128 characters are represented.
  """
  @char_length 0x10
  @font_section_start 0x12000
  @font_section_length 0x800

  @doc """
  Parses the font section of the ROM and returns a list of characters with their index.
  Characters are binaries of 16 bytes each, each byte is a row, so the character is 8x16 pixels.
  The index can be used to identify the character in the ASCII table.
  """
  def get_character_table(rom_data) do
    <<_start::binary-size(@font_section_start), font_section::binary-size(@font_section_length),
      _end::binary>> = rom_data

    get_character_chunks(font_section, [], 0)
  end

  defp get_character_chunks(input, chunks, index) do
    case input do
      <<char::binary-size(@char_length), rest::binary>> ->
        get_character_chunks(rest, [{index, char} | chunks], index + 1)

      <<>> ->
        Enum.reverse(chunks)
    end
  end

  @doc """
  Takes a character binary segment and converts it to an OpenCV matrix.
  The OpenCV matrix can easily be written to an image file.
  """
  def character_to_mat(character) do
    for <<r::8 <- character>> do
      <<r>>
    end
    |> Enum.map(&normalize_row/1)
    |> List.flatten()
    |> Enum.reduce(fn i, acc ->
      acc <> i
    end)
    |> Mat.from_binary({:u, 8}, 16, 8, 1)
  end

  defp normalize_row(row) do
    for <<b::1 <- row>> do
      case b do
        0 -> <<255>>
        1 -> <<0>>
      end
    end
  end
end
