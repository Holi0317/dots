export-env {
  use std/util "path add"

  # Setup brew, replicating what `brew shellenv` will do

  # Default prefix for homebrew, see https://docs.brew.sh/Installation
  let brew_prefix = match $nu.os-info {
    { name: macos, arch: aarch64 } => "/opt/homebrew"
    { name: macos, arch: x86_64 } => "/usr/local"
    { name: linux } => "/home/linuxbrew/.linuxbrew"
    _ => null
  }

  if ($brew_prefix == null) {
    return
  }

  if (not ($brew_prefix | path exists)) {
    return
  }

  $env.HOMEBREW_PREFIX = $brew_prefix
  $env.HOMEBREW_CELLAR = $brew_prefix | path join "Cellar"
  $env.HOMEBREW_REPOSITORY = $brew_prefix
  path add ($brew_prefix | path join 'bin')
  path add ($brew_prefix | path join 'sbin')

  $env.MANPATH = ($env.MANPATH | prepend '')
  $env.INFOPATH = ($env.MANPATH | prepend ($brew_prefix | path join 'share' 'info') )
}

export-env {
  use std/util "path add"

  path add "~/.local/bin"
  path add "~/go/bin"
  path add "~/.carbo/bin"
  path add "~/.dotnet/tools"
}
