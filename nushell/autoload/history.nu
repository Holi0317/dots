$env.config.history = {
  file_format: "sqlite"
  # Actual history is managed by atuin. No need to keep too much history in nushell
  max_size: 100 
  isolation: false
}
