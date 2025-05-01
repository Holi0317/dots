alias tf = terraform
alias tg = terragrunt

# `terragrunt apply` alias
def tga [
  --yes (-y)  # Applies `-auto-approve` flag
  dir?: path  # Path to terragrunt unit, default to $env.PWD
] {
  cd ($dir | default --empty $env.PWD)

  let flags = if ($yes) { ["-auto-approve"] } else { [] }

  terragrunt apply ...($flags)
}
