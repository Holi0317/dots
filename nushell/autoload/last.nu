# max_last_result_size (filesize): Max memory for `$ans.last`, the interactive last-result cache.
# Positive values store pipeline results; `0b` disables it by default and omits the field.
# `$ans.exit_code`, `$ans.duration`, and `$ans.command` always update with the last REPL command.
# Results larger than the limit are truncated; bare `$ans` / `$ans.*` refresh metadata without overwriting `.last`.
# Empty Enter and auto-cd do not update `$ans`; bare externals keep the TTY for interactive tools.
# The name `ans` is reserved and cannot be rebound with `let`.
# Default: 0b
$env.config.max_last_result_size = 10mb
