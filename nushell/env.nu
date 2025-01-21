# env.nu
#
# Installed by:
# version = "0.101.0"
#
# Previously, environment variables were typically configured in `env.nu`.
# In general, most configuration can and should be performed in `config.nu`
# or one of the autoload directories.
#
# This file is generated for backwards compatibility for now.
# It is loaded before config.nu and login.nu
#
# See https://www.nushell.sh/book/configuration.html
#
# Also see `help config env` for more options.
#
# You can remove these comments if you want or leave
# them for future reference.

let col_paths = {
  from_string: { |s| $s | split row ':' }
  to_string: { |v| $v | str join ':' }
}

$env.ENV_CONVERSIONS.MANPATH = $col_paths
$env.ENV_CONVERSIONS.INFOPATH = $col_paths
$env.ENV_CONVERSIONS.AQUA_GLOBAL_CONFIG = $col_paths


$env.NU_LIB_DIRS = [
  ($nu.config-path | path dirname | path join 'plugins')
]

$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
mkdir ~/.cache/carapace
carapace _carapace nushell | save --force ~/.cache/carapace/init.nu
