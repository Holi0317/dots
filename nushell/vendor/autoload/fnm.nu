export-env {
  if (which fnm | is-empty) {
    return
  }

  use std/util "path add"

  # Setup fnm environment variables and path
  # Ref: https://github.com/Schniz/fnm/issues/463#issuecomment-2009086161
  fnm env --version-file-strategy recursive --json | from json | load-env

  let node_path = match $nu.os-info.name {
    "windows" => $env.FNM_MULTISHELL_PATH,
    _ => $"($env.FNM_MULTISHELL_PATH)/bin",
  }
  path add $node_path

  # Setup fnm on cd
  # Ref: https://github.com/Schniz/fnm/issues/463#issuecomment-2009811131
  let hook = {
    code: { |before, after|
      fnm use --silent-if-unchanged
    }
  }

  $env.config.hooks.env_change.PWD = $env.config.hooks.env_change.PWD? | default [] | append $hook
}
