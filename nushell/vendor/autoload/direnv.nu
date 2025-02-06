export-env {
  def --env "_conf direnv" [] {
    if (which direnv | is-empty) {
      return
    }

    let hook = { ||
      direnv export json | from json | default {} | load-env
      if 'ENV_CONVERSIONS' in $env and 'PATH' in $env.ENV_CONVERSIONS {
        $env.PATH = do $env.ENV_CONVERSIONS.PATH.from_string $env.PATH
      }
    }

    $env.config.hooks.env_change.PWD = $env.config.hooks.env_change.PWD? | default [] | append $hook
  }

  _conf direnv
}
