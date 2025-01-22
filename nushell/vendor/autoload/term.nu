export-env {
  use os.nu

  # Most terminal emulators (kitty, alacritty, wezterm) supports this protocol
  $env.config.use_kitty_protocol = true

  # HACK: Fix newline handling in WezTerm under windows or wsl
  # See https://github.com/nushell/nushell/issues/5585
  $env.config.shell_integration.osc133 = not (
    (os win-or-wsl) and $env.TERM_PROGRAM? == 'WezTerm'
  )
}
