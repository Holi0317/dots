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
alias gg="lazygit"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# Load starship theme
zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship

zstyle ':completion:*' menu select
setopt share_history

zinit light jeffreytse/zsh-vi-mode

# OMZ plugins
zinit snippet OMZP::direnv
zinit snippet OMZP::gpg-agent

# fnm: Fast node manager
if [ -x "$(command -v fnm)" ]; then
  eval "$(fnm env --use-on-cd)"
fi

zinit pack for system-completions
zinit pack for ls_colors

zinit fpath -f /opt/homebrew/share/zsh/site-functions

zinit light willghatch/zsh-saneopt
zinit light zsh-users/zsh-completions
zinit light zdharma-continuum/fast-syntax-highlighting

zinit ice lucid wait
zinit snippet OMZP::fzf

# FIXME: Enable this
# Setup pipx completion
# if [ -x "$(command -v register-python-argcomplete)" ]; then
#   autoload -U bashcompinit
#   bashcompinit
#   eval "$(register-python-argcomplete pipx)"
# fi


# Case-insensitive completion
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

# ==== ... when <tab> ====
expand-or-complete-with-dots() {
  # use $COMPLETION_WAITING_DOTS either as toggle or as the sequence to show
  COMPLETION_WAITING_DOTS="%F{red}…%f"
  # turn off line wrapping and print prompt-expanded "dot" sequence
  printf '\e[?7l%s\e[?7h' "${(%)COMPLETION_WAITING_DOTS}"
  zle expand-or-complete
  zle redisplay
}
zle -N expand-or-complete-with-dots
# Set the function as the default tab completion widget
bindkey -M emacs "^I" expand-or-complete-with-dots
bindkey -M viins "^I" expand-or-complete-with-dots
bindkey -M vicmd "^I" expand-or-complete-with-dots

# ==== <S-Tab> for suggestion ====
bindkey -M emacs '^[[Z' reverse-menu-complete
bindkey -M viins '^[[Z' reverse-menu-complete
bindkey -M vicmd '^[[Z' reverse-menu-complete

# Load completion
autoload -Uz compinit
autoload -U +X bashcompinit
compinit
bashcompinit

zinit cdreplay -q
