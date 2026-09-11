export-env {
  use std/util "path add"

  path add "~/.local/bin"

  # MacOS Docker desktop
  path add "~/.docker/bin"
  path add "/Applications/Docker.app/Contents/Resources/bin"

  # MacOS orbstack
  path add "~/.orbstack/bin"

  path add "~/go/bin"
  path add "~/.carbo/bin"
  path add "~/.dotnet/tools"
}
