export-env {
  def --env "_conf aqua" [] {
    use std/util "path add"

    if (which aqua | is-empty) {
      return
    }

    $env.AQUA_GLOBAL_CONFIG = ($env.AQUA_GLOBAL_CONFIG? | default []) ++ [("~/.config/aquaproj-aqua/aqua.yaml" | path expand)]
    path add $"(aqua root-dir)/bin"
  }

  _conf aqua
}
