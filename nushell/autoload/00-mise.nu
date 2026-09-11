# File generated in env.nu
# Mise snapshots $env.PATH in env.nu. This must run before any other PATH modification.
const p = "~/.cache/nushell/mise.nu"
use (if ($p | path exists) { $p })
