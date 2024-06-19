# Sword of Kumdor Latin Font

This is an extracted version of the 8x16 pixel latin font included in the 1991 touch-typing RPG “The Sword of Kumdor” (クムドールの剣).

More information about the game, including screenshots of the font [can be found here](https://lynn.github.io/kumdor/).

Thanks to [Lynn](https://github.com/lynn) for publishing this excellent page which brought my attention to the game and the font, and also for answering my questions about the ROM's format.

## Run Font Extraction

```sh
# Elixir 1.16.3
mix deps.get
mix extract_font <path_to_rom>
```

Each character is written to a PNG in `/output` named after its (decimal) index in the ASCII table.

