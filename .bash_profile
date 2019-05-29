# .bash_profile

if [ -f ~/.bashrc ] ; then
. ~/.bashrc
fi

if [ -f ~/.bash_aliases ] ; then
. ~/.bash_aliases
fi

export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/share/pkgconfig

# User specific environment and startup programs

export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/opt/gettext/bin:$PATH"
export PATH=$PATH:$HOME/.local/bin:$HOME/bin

XDG_CONFIG_HOME=~/.config

source $HOME/.config/dotfiles/git-prompt.sh
source $HOME/.config/dotfiles/git-completion.bash

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUPSTREAM=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWSTASHSTATE=1

export PS1='\[\033[1;32m\]\u\[\033[00m\]:\[\033[1;34m\]\w\[\033[1;31m\]$(__git_ps1)\[\033[00m\] \$ '

# disable history expansion
# https://qiita.com/anqooqie/items/785f46a8cc5f10ba7abb
set +H

# for tig.
# https://riosu.hateblo.jp/entry/2018/09/12/223448
export LC_ALL=en_US.UTF-8
