# --- Aliases & Functions ---
[[ -f ~/.zsh_aliases ]] && . ~/.zsh_aliases
[[ -f ~/.zsh_functions ]] && . ~/.zsh_functions

# --- PATH ---
export PATH=/usr/local/google/home/puchin/.local/bin:$PATH
export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export PATH=/usr/bin:$PATH

# --- General Settings ---
export LANG=en_US.UTF-8
export EDITOR=nvim
export KEYTIMEOUT=1

# --- History ---
HISTSIZE=500000
SAVEHIST=500000
HISTFILE=~/.zsh_history
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS

# --- Completion ---
fpath=(~/.zsh/completions $fpath)
autoload -Uz compinit; compinit
zstyle ':completion:*' users root $USER

# --- Vi Mode ---
bindkey -v

# --- Key Bindings ---
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward
bindkey '^O' beginning-of-line
bindkey '^F' forward-word
bindkey '^B' backward-word
bindkey '^K' kill-whole-line
bindkey '^U' backward-kill-line
bindkey '^T' kill-line

# --- Vi Cursor Shape ---
function zle-line-init zle-keymap-select {
    if [[ "$KEYMAP" == "vicmd" ]]; then
        printf "\033[2 q"
    else
        printf "\033[3 q"
    fi
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# --- Prompt (Catppuccin Mocha) ---
# lavender=#b4befe teal=#94e2d5 green=#a6e3a1 yellow=#f9e2af
# subtext0=#a6adc8 red=#f38ba8 mauve=#cba6f7
PROMPT='
%F{#b4befe}#%f %F{#94e2d5}%n%f @ %F{#a6e3a1}%m%f in %F{#f9e2af}%~%f %F{#a6adc8}[%*]%f %(?.%F{#a6adc8}.%F{#f38ba8})C:%?%f
%F{#cba6f7}$%f '

# --- Autosuggestions ---
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null || \
  source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240'

# --- Virtual Env Indicator ---
export VIRTUAL_ENV_DISABLE_PROMPT=yes
autoload -U add-zsh-hook
function virtenv_indicator {
    if [[ -z $VIRTUAL_ENV ]]; then
        psvar[1]=''
    else
        psvar[1]=${VIRTUAL_ENV##*/}
    fi
}
add-zsh-hook precmd virtenv_indicator
RPS1="%(1V.(%1v).)"
