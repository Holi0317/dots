### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# Load starship theme
zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship

zinit light jeffreytse/zsh-vi-mode

# OMZ plugins
zinit snippet OMZP::direnv
zinit snippet OMZP::gpg-agent

zinit pack for system-completions

zinit light willghatch/zsh-saneopt
zinit light zsh-users/zsh-completions
zinit light zdharma-continuum/fast-syntax-highlighting

zinit ice lucid wait
zinit snippet OMZP::fzf

# export configurations
export EDITOR="lvim"
export PAGER="less"
export CHROME_BIN=/usr/bin/google-chrome-stable
export LESS='-SFXR'

# Aliases
alias vi="lvim"
alias vim="lvim"
alias nvim="lvim"
alias l="exa -alh --icons"
alias xclip="xclip -selection clipboard"
alias tree="exa --tree --icons"
alias s3="aws s3"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# FIXME: Enable this
# Setup pipx completion
# if [ -x "$(command -v register-python-argcomplete)" ]; then
#   autoload -U bashcompinit
#   bashcompinit
#   eval "$(register-python-argcomplete pipx)"
# fi

# fnm: Fast node manager
if [ -x "$(command -v fnm)" ]; then
  eval "$(fnm env --use-on-cd)"
fi

# Alias for lazygit
gg()
{
  lazygit "$@"
}
