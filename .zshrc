### source .zprofile ##########################################

if [ -f ~/.zprofile ]; then
  . ~/.zprofile
fi

### base ##########################################

export LANG=ja_JP.UTF-8
export EDITOR=nvim

### Zinit #######################################

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit ice atload'!_zsh_git_prompt_precmd_hook' lucid
zinit load woefe/git-prompt.zsh
source "$HOME/.zinit/plugins/woefe---git-prompt.zsh/examples/wprompt.zsh"

zinit ice wait '!0'; zinit load zsh-users/zsh-completions
zinit ice wait '!0'; zinit load zsh-users/zsh-syntax-highlighting

### aliases #######################################

alias ll="ls -lG"
alias la="ls -laG"
alias ls="ls -G"

alias -g L='| less -R'
alias -g H='| head'
alias -g G='| grep'
alias -g GI='| grep -ri'

alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"

alias mkdir="mkdir -p"

alias g="git"

alias ag="ag --pager 'less -R'"

alias be="bundle exec"
alias dce="docker-compose exec"
alias dcr="docker-compose run"

alias gl='cd $(ghq list -p | fzf)'

### colors ########################################

autoload -Uz colors
colors

### auto completion ###############################

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

#### history ######################################

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups

bindkey '^r' history-incremental-pattern-search-backward
bindkey '^s' history-incremental-pattern-search-forward
