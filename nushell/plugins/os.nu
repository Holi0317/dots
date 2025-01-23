# Check if we are running on wsl
export def is-wsl []: nothing -> bool {
  let v = '/proc/version'

  ($nu.os-info.name == 'linux') and ($v | path exists) and (open $v | str contains 'microsoft')
}

export def win-or-wsl []: nothing -> bool {
  $nu.os-info.name == 'windows' or (is-wsl)
}

# Guess the current terminal emulator
# If unknown or there isn't one, the return value would be `null`
export def term [] : nothing -> string {
  if ('KITTY_INSTALLATION_DIR' in $env) {
    return 'kitty'
  }

  if ('WT_SESSION' in $env) {
    return 'windows_terminal'
  }


  match ($env.TERM_PROGRAM?) {
    'WezTerm' => 'wezterm'
    'iTerm.app' => 'iterm2'
    'Apple_Terminal' => 'terminal.app'
    'vscode' => 'vscode'
  }
}
