# File generated in env.nu
const p = "~/.cache/nushell/carapace.nu"
source (if ($p | path exists) { $p })

$env.config.completions.algorithm = 'fuzzy'
