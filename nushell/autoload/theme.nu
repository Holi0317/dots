export-env {
  $env.config.highlight_resolved_externals = true

  # Palette and colors copied from ellisonleao/gruvbox.nvim
  let palette = {
    dark0_hard: '#1d2021'
    dark0: '#282828'
    dark0_soft: '#32302f'
    dark1: '#3c3836'
    dark2: '#504945'
    dark3: '#665c54'
    dark4: '#7c6f64'
    light0_hard: '#f9f5d7'
    light0: '#fbf1c7'
    light0_soft: '#f2e5bc'
    light1: '#ebdbb2'
    light2: '#d5c4a1'
    light3: '#bdae93'
    light4: '#a89984'
    bright_red: '#fb4934'
    bright_green: '#b8bb26'
    bright_yellow: '#fabd2f'
    bright_blue: '#83a598'
    bright_purple: '#d3869b'
    bright_aqua: '#8ec07c'
    bright_orange: '#fe8019'
    neutral_red: '#cc241d'
    neutral_green: '#98971a'
    neutral_yellow: '#d79921'
    neutral_blue: '#458588'
    neutral_purple: '#b16286'
    neutral_aqua: '#689d6a'
    neutral_orange: '#d65d0e'
    faded_red: '#9d0006'
    faded_green: '#79740e'
    faded_yellow: '#b57614'
    faded_blue: '#076678'
    faded_purple: '#8f3f71'
    faded_aqua: '#427b58'
    faded_orange: '#af3a03'
    dark_red_hard: '#792329'
    dark_red: '#722529'
    dark_red_soft: '#7b2c2f'
    light_red_hard: '#fc9690'
    light_red: '#fc9487'
    light_red_soft: '#f78b7f'
    dark_green_hard: '#5a633a'
    dark_green: '#62693e'
    dark_green_soft: '#686d43'
    light_green_hard: '#d3d6a5'
    light_green: '#d5d39b'
    light_green_soft: '#cecb94'
    dark_aqua_hard: '#3e4934'
    dark_aqua: '#49503b'
    dark_aqua_soft: '#525742'
    light_aqua_hard: '#e6e9c1'
    light_aqua: '#e8e5b5'
    light_aqua_soft: '#e1dbac'
    gray: '#928374'
  }

  let colors = {
    bg0: $palette.dark0
    bg1: $palette.dark1
    bg2: $palette.dark2
    bg3: $palette.dark3
    bg4: $palette.dark4
    fg0: $palette.light0
    fg1: $palette.light1
    fg2: $palette.light2
    fg3: $palette.light3
    fg4: $palette.light4
    red: $palette.bright_red
    green: $palette.bright_green
    yellow: $palette.bright_yellow
    blue: $palette.bright_blue
    purple: $palette.bright_purple
    aqua: $palette.bright_aqua
    orange: $palette.bright_orange
    neutral_red: $palette.neutral_red
    neutral_green: $palette.neutral_green
    neutral_yellow: $palette.neutral_yellow
    neutral_blue: $palette.neutral_blue
    neutral_purple: $palette.neutral_purple
    neutral_aqua: $palette.neutral_aqua
    dark_red: $palette.dark_red
    dark_green: $palette.dark_green
    dark_aqua: $palette.dark_aqua
    gray: $palette.gray
  }

  $env.config.color_config.shape_string = $colors.green
  $env.config.color_config.shape_string_interpolation = $colors.green
  $env.config.color_config.shape_raw_string = $colors.green
  $env.config.color_config.shape_record = $colors.orange
  $env.config.color_config.shape_list = $colors.orange
  $env.config.color_config.shape_table = $colors.orange
  $env.config.color_config.shape_bool = $colors.purple
  $env.config.color_config.shape_int = $colors.purple
  $env.config.color_config.shape_float = $colors.purple
  $env.config.color_config.shape_range = $colors.orange
  $env.config.color_config.shape_binary = $colors.purple
  $env.config.color_config.shape_datetime = $colors.purple
  $env.config.color_config.shape_nothing = $colors.orange
  $env.config.color_config.shape_operator = $colors.orange
  $env.config.color_config.shape_filepath = { fg: $colors.purple, attr: u }
  $env.config.color_config.shape_directory = { fg: $colors.purple, attr: u }
  $env.config.color_config.shape_globpattern = { fg: $colors.aqua, attr: b }
  $env.config.color_config.shape_garbage = { fg: $colors.red, bg: $colors.bg2, attr: b }
  $env.config.color_config.shape_variable = $colors.neutral_green
  $env.config.color_config.shape_vardecl = $colors.purple
  $env.config.color_config.shape_matching_brackets = { attr: u }
  $env.config.color_config.shape_pipe = { fg: $colors.orange, attr: b }
  $env.config.color_config.shape_internalcall = $colors.aqua
  $env.config.color_config.shape_external = { fg: $colors.red, attr: b }
  $env.config.color_config.shape_external_resolved = $colors.neutral_green
  $env.config.color_config.shape_externalarg = $colors.aqua
  $env.config.color_config.shape_match_pattern = $colors.green
  $env.config.color_config.shape_block = $colors.orange
  $env.config.color_config.shape_signature = $colors.blue
  $env.config.color_config.shape_closure = $colors.orange
  $env.config.color_config.shape_redirection = { fg: $colors.purple, attr: b }
  $env.config.color_config.shape_flag = $colors.aqua

  $env.config.color_config.bool = $env.config.color_config.shape_bool
  $env.config.color_config.int = $env.config.color_config.shape_int
  $env.config.color_config.string = 'white'
  $env.config.color_config.float = $env.config.color_config.shape_float
  $env.config.color_config.glob = $env.config.color_config.shape_globpattern
  $env.config.color_config.binary = 'white'
  $env.config.color_config.date = $env.config.color_config.shape_datetime
  $env.config.color_config.filesize = $colors.aqua
  $env.config.color_config.list = 'white'
  $env.config.color_config.record = 'white'
  $env.config.color_config.duration = 'white'
  $env.config.color_config.range = 'white'
  $env.config.color_config.cell-path = 'white'
  $env.config.color_config.closure = 'white'
  $env.config.color_config.block = 'white'

  # Additional UI elements
  # hints: The (usually dimmed) style in which completion hints are displayed
  $env.config.color_config.hints = $colors.fg3

  # search_result: The style applied to `find` search results
  $env.config.color_config.search_result = { bg: $colors.red, fg: 'white' }

  # header: The column names in a table header
  $env.config.color_config.header = $colors.yellow

  # separator: Used for table/list/record borders
  $env.config.color_config.separator = 'white'

  # row_index: The `#` or `index` column of a table or list
  $env.config.color_config.row_index = $colors.yellow

  # empty: This style is applied to empty/missing values in a table. However, since the ❎
  # emoji is used for this purpose, there is limited styling that can be applied.
  $env.config.color_config.empty = $colors.blue

  # leading_trailing_space_bg: When a string value inside structured data has leading or trailing
  # whitespace, that whitespace will be displayed using this style.
  # Use { attr: n } to disable.
  $env.config.color_config.leading_trailing_space_bg = { bg: $colors.red }
}
