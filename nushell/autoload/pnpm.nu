export-env {
  use std/util "path add"

  $env.PNPM_HOME = match $nu.os-info.name {
    "macos" => ("~/Library/pnpm" | path expand)
    "windows" => ($env.LOCALAPPDATA | path join "pnpm")
    _ => ("~/.local/share/pnpm" | path expand)
  }

  path add $env.PNPM_HOME
}
