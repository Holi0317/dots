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


# ==== Stage sync: export and alias ====

setopt auto_cd

# export configurations
export EDITOR="nvim"
export PAGER="less"
export LESS='-SFXR'
export HISTSIZE=500000
export SAVEHIST=500000

# Aliases
alias vi="nvim"
alias vim="nvim"
alias l="eza -alh --icons=always"
alias tree="eza --tree --icons=always"
alias s3="aws s3"
alias s3a="aws s3 --endpoint-url https://s3-accelerate.amazonaws.com"
alias gg="lazygit"
alias tf="terraform"
alias tg="terragrunt"
alias g="git"

load=load


# ==== Stage sync: sane opts ====

zinit $load willghatch/zsh-saneopt

# ==== Load vi mode plugin ====
# It will get unhappy if we load it async. So load it first
zinit $load jeffreytse/zsh-vi-mode

zinit ice lucid subst"bindkey -e ->"
zinit snippet OMZL::key-bindings.zsh

# ==== Prompt and theme =====
PS1="
READY
➜ " # provide a simple prompt till the theme loads

# Load starship theme
zinit ice wait"!" lucid \
          as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit $load starship/starship

zinit ice lucid wait"" atload="zicompinit; zicdreplay"
zinit light zdharma-continuum/fast-syntax-highlighting

# ==== Small plugins ====

zinit wait"" lucid for \
  OMZP::fzf

zinit ice wait"" lucid \
  atload"
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
  "
zinit $load zsh-users/zsh-history-substring-search

zinit wait"1" pack for ls_colors

zinit ice wait"1" lucid autoload'#manydots-magic'
zinit $load knu/zsh-manydots-magic

zinit wait"1" lucid for \
  OMZL::history.zsh \
  atinit"COMPLETION_WAITING_DOTS=true" OMZL::completion.zsh \
  OMZP::gpg-agent \

# ==== Install programs ====

# fnm: Fast node manager
zinit ice lucid wait"!" blockf \
          as"command" from"gh-r" bpick"*macos*" \
          atclone"./fnm env --shell zsh --use-on-cd > init.zsh; fnm completions --shell zsh > _fnm" \
          atpull"%atclone" src"init.zsh"
zinit $load Schniz/fnm

# direnv
zinit ice wait"!" blockf \
    as"program" from"gh-r" \
    atclone'./direnv hook zsh > zhook.zsh' \
    atpull"%atclone" \
    mv"direnv* -> direnv" \
    src'zhook.zsh'
zinit $load direnv/direnv

# ==== Completions ====

zinit ice wait"1" lucid blockf
zinit add-fpath $HOMEBREW_PREFIX/share/zsh/site-functions

zinit ice lucid wait blockf \
                as"none" id-as"local-plugins" \
                nocompile run-atpull \
                atpull"mkdir -p ${HOME}/.zsh/completions && zinit creinstall -q ${HOME}/.zsh/completions"
zinit $load zdharma-continuum/null

zinit ice lucid wait"1" creinstall
zinit $load zsh-users/zsh-completions
