# Use ~/scripts if there's a mod.nu in there.
use (if ($nu.home-dir | path join "scripts" "mod.nu" | path exists) {
  $nu.home-dir | path join "scripts"
} else {
  null
}) *
