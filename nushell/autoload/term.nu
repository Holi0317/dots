export-env {
  use os.nu

  # While most terminal emulators (kitty, alacritty, wezterm) supports this protocol,
  # test on wezterm is behaving weirdly when this is on.
  $env.config.use_kitty_protocol = ((os term) == 'kitty')

  # HACK: Fix newline handling in WezTerm under windows or wsl
  # See https://github.com/nushell/nushell/issues/5585
  $env.config.shell_integration.osc133 = not (
    (os win-or-wsl) and ((os term) == 'wezterm')
  )
}
