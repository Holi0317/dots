# Install ENV_CONVERSIONS
export-env {
  let col_paths = {
    from_string: { |s| $s | split row ':' }
    to_string: { |v| $v | str join ':' }
  }

  $env.ENV_CONVERSIONS.MANPATH = $col_paths
  $env.ENV_CONVERSIONS.INFOPATH = $col_paths
  $env.ENV_CONVERSIONS.AQUA_GLOBAL_CONFIG = $col_paths
}

# Add our plugins to search path
$env.NU_LIB_DIRS = [
  ($nu.config-path | path dirname | path join 'plugins')
]

# Setup brew, replicating what `brew shellenv` will do
# Need to set this up first so the `carapace` command is available in next
# block, at least if it's managed by brew.
export-env {
  use std/util "path add"

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

# Prepare completion script from carapace. This will get sourced in
# autoload/completions.nu
export-env {
  $env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
  mkdir ~/.cache/carapace
  carapace _carapace nushell | save --force ~/.cache/carapace/init.nu
}
