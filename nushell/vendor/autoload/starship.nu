# Created via `starship init nu`
# Modified to make this noop if starship is not installed

export-env {
  if (which starship | is-empty) {
    return
  }

  $env.STARSHIP_SHELL = "nu"
  $env.STARSHIP_SESSION_KEY = random chars -l 16

  $env.PROMPT_MULTILINE_INDICATOR = ^starship prompt --continuation

  # Does not play well with default character module.
  # TODO: Also Use starship vi mode indicators?
  $env.PROMPT_INDICATOR = ""

  $env.PROMPT_COMMAND = {||
      # jobs are not supported
      (
          ^starship prompt
              --cmd-duration $env.CMD_DURATION_MS
              $"--status=($env.LAST_EXIT_CODE)"
              --terminal-width (term size).columns
      )
  }

  $env.config.render_right_prompt_on_last_line = true

  $env.PROMPT_COMMAND_RIGHT = {||
      (
          ^starship prompt
              --right
              --cmd-duration $env.CMD_DURATION_MS
              $"--status=($env.LAST_EXIT_CODE)"
              --terminal-width (term size).columns
      )
  }
}
