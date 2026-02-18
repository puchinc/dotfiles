alias vim='nvim'
[[ -f ~/.zsh_aliases ]] && . ~/.zsh_aliases

export PATH=$HOME/.local/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH
export LANG=en_US.UTF-8
export EDITOR=nvim
export KEYTIMEOUT=15

# Private keys and secrets (not tracked in git)
[[ -f ~/.zsh_local ]] && source ~/.zsh_local

HISTSIZE=500000
SAVEHIST=500000
HISTFILE=~/.zsh_history
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS

bindkey -v
function zle-keymap-select {
    if [[ "$KEYMAP" == "vicmd" ]]; then
        printf "\033[2 q" # Block
    else
        printf "\033[6 q" # Beam
    fi
}
zle -N zle-keymap-select
function zle-line-init { zle-keymap-select }
zle -N zle-line-init

bindkey '^R' history-incremental-search-backward
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward
bindkey '^O' beginning-of-line

PROMPT='
%F{#b4befe}#%f %F{#94e2d5}%n%f @ %F{#a6e3a1}%m%f in %F{#f9e2af}%~%f %F{#a6adc8}[%*]%f %(?.%F{#a6adc8}.%F{#f38ba8})C:%?%f
%F{#cba6f7}$%f '

if [[ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
bindkey '^f' autosuggest-accept
