### source .bashrc ##########################################

if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

### base ##########################################

export LANG=ja_JP.UTF-8
export EDITOR=nvim

### Zplugin #######################################

source "$HOME/.zplugin/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin

zplugin ice atload'!_zsh_git_prompt_precmd_hook' lucid
zplugin load woefe/git-prompt.zsh
zplugin ice wait '!0'; zplugin load zsh-users/zsh-completions
zplugin ice wait '!0'; zplugin load zsh-users/zsh-syntax-highlighting

### aliases #######################################

if [ -f ~/.zsh_aliases ]; then
  . ~/.zsh_aliases
fi

case "${OSTYPE}" in
darwin*)
  alias ll="ls -lG"
  alias la="ls -laG"
  alias ls="ls -G"
  ;;
linux*)
  alias l.="ls -d .* --color=auto"
  alias ll="ls -l --color=auto"
  alias la="ls -al --color=auto"
  alias ls="ls --color=auto"
  ;;
esac

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

#### path #########################################

export PATH=$PATH:$HOME/.nodenv/shims:/usr/local/lib/nodenv/shims:/usr/local/lib/nodenv/bin
export PATH=$PATH:/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:
export PATH=$PATH:/usr/local/lib/rbenv/shims:

export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/share/pkgconfig
export XDG_CONFIG_HOME=~/.config

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

#### direnv ######################################
eval "$(direnv hook zsh)"
