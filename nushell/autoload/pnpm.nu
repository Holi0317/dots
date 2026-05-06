export-env {
  use std/util "path add"

  $env.PNPM_HOME = match $nu.os-info.name {
    "macos" => ("~/Library/pnpm" | path expand)
    "windows" => ($env.LOCALAPPDATA | path join "pnpm")
    _ => ("~/.local/share/pnpm" | path expand)
  }

  $env.PNPM_HOME
  | path join "bin"
  | path add $in
}
