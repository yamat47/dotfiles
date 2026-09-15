alias ls='eza --icons --group-directories-first'
alias ll='eza -l --icons --git --group-directories-first'
alias la='eza -la --icons --git --group-directories-first'
alias tree='eza --tree --icons'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias g='git'
alias lzd='lazydocker'

gl() {
  local dir
  dir=$(ghq list --full-path | fzf --preview 'bat --color=always {}/README.md 2>/dev/null || ls -la {}') || return
  cd "$dir"
}
