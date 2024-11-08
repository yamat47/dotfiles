### load user's preferences ###
if [ -f ~/.zprofile ]; then
  . ~/.zprofile
fi

### base ###
export LANG=ja_JP.UTF-8
export EDITOR=nvim

### zinit ###
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit"
source "${ZINIT_HOME}/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/z-a-rust \
    zdharma-continuum/z-a-as-monitor \
    zdharma-continuum/z-a-patch-dl \
    zdharma-continuum/z-a-bin-gem-node

zinit ice atload'!_zsh_git_prompt_precmd_hook' lucid
zinit load woefe/git-prompt.zsh
source "${ZINIT_HOME}/plugins/woefe---git-prompt.zsh/examples/wprompt.zsh"

zinit ice wait '!0'; zinit load zsh-users/zsh-completions
zinit ice wait '!0'; zinit load zsh-users/zsh-syntax-highlighting

### aliases ###
alias ll="ls -lG"
alias la="ls -laG"
alias ls="ls -G"

alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"

alias g="git"

alias gl='cd $(ghq list -p | fzf)'

alias lzd="lazydocker"

### colors ###
autoload -Uz colors
colors

### auto completion ###
fpath=(~/.zsh/completion $fpath)

autoload -Uz compinit
compinit

setopt histignorealldups

zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

autoload -Uz select-word-style
select-word-style default

zstyle ':zle:*' word-chars "_-./;@"
zstyle ':zle:*' word-style unspecified

autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^b" history-beginning-search-forward-end

#### history ###
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups

bindkey '^r' history-incremental-pattern-search-backward
bindkey '^s' history-incremental-pattern-search-forward

function docker_bash() {
    local container_id=$(docker ps --format '{{.ID}}\t{{.Names}}' | fzf --height 40% --layout=reverse | awk '{print $1}')
    if [ -n "$container_id" ]; then
        docker exec -it "$container_id" bash || echo "Failed to start bash in container: $container_id"
    else
        echo "No container selected."
    fi
}

alias db="docker_bash"

alias c="code ."
