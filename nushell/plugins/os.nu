# Check if we are running on wsl
export def is-wsl []: nothing -> bool {
  let v = '/proc/version'

  ($nu.os-info.name == 'linux') and ($v | path exists) and (open $v | str contains 'microsoft')
}
