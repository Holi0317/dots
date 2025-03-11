# Setup ssh agent socket to 1password
# https://developer.1password.com/docs/ssh/get-started/#step-4-configure-your-ssh-or-git-client
export-env {
  use std log
  use os.nu

  # Setup 1password tunnel on wsl
  #
  # Not using the official wsl guide from https://developer.1password.com/docs/ssh/integrations/wsl/,
  # that is basically doing `alias ssh = ssh.exe` which feels... wrong.
  #
  # Following https://gist.github.com/WillianTomaz/a972f544cc201d3fbc8cd1f6aeccef51
  # This function is port of .agent-bridge.sh
  #
  # Return value is the agent socket if setup is successful, null otherwise
  def setup-wsl [] {
    if (which socat npiperelay.exe | length | $in != 2) {
      return null
    }

    let sock = "~/.1password/agent.sock" | path expand

    let already_runing = ps -l
      | where name == socat and command =~ 'npiperelay.exe -ei -s //./pipe/openssh-ssh-agent'
      | is-not-empty

    if ($already_runing) {
      return $sock
    }

    log debug 'Starting 1password SSH-Agent relay'

    rm --force $sock

    # nushell don't have background job mechanism. Shelling out to tmux instead
    tmux new-session -d -s coffee $'setsid socat UNIX-LISTEN:($sock),fork EXEC:"npiperelay.exe -ei -s //./pipe/openssh-ssh-agent",nofork'

    $sock
  }

  let sock = match $nu.os-info.name {
    macos => ('~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock' | path expand)
    windows => null
    linux if (os is-wsl) => setup-wsl
    _ => ('~/.1password/agent.sock' | path expand)
  }

  if (($sock != null) and ($sock | path exists)) {
    $env.SSH_AUTH_SOCK = $sock
  }
}
