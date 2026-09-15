# Must precede compinit to be picked up.
if [[ -d ${HOMEBREW_PREFIX:-/opt/homebrew}/share/zsh-completions ]]; then
  fpath=(${HOMEBREW_PREFIX:-/opt/homebrew}/share/zsh-completions $fpath)
fi

# A full compinit costs 100-200ms per shell. Rebuilding the dump at most once
# a day keeps startup fast; new completions still appear within a day.
autoload -Uz compinit
_zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
if [[ ! -f "$_zcompdump" || -n "$_zcompdump"(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi
unset _zcompdump

zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$HOME/.zsh/cache"
