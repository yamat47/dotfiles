# User specific aliases and functions
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

alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"
alias sudo="sudo env PATH=\"$PATH\""
alias g='git'
alias ag='ag --pager="less -R"'
