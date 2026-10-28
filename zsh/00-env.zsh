# Re-sourcing below and brew shellenv both prepend without checking.
typeset -U path fpath

for _brew in /opt/homebrew/bin/brew /usr/local/bin/brew; do
  [[ -x $_brew ]] && { eval "$($_brew shellenv zsh)"; break; }
done
unset _brew

# Homebrew curl is keg-only; prefer it over /usr/bin/curl, whose SecureTransport
# backend trusts keychain roots regardless of the CA file.
if [[ -d ${HOMEBREW_PREFIX:-/opt/homebrew}/opt/curl/bin ]]; then
  path=(${HOMEBREW_PREFIX:-/opt/homebrew}/opt/curl/bin $path)
fi

path=("$HOME/.bin" $path)

# Sourced last so machine-specific PATH wins over brew shellenv; also covers
# non-login shells (exec zsh, some editor terminals), which skip ~/.zprofile.
[[ -f "$HOME/.zprofile" ]] && source "$HOME/.zprofile"

export LANG=ja_JP.UTF-8
export EDITOR=nvim

command -v mise >/dev/null && eval "$(mise activate zsh)"

# Kept next to the rest of the shell config so it travels with it.
export STARSHIP_CONFIG="$HOME/.zsh/starship.toml"

# Must precede compinit (20-completion.zsh) to be picked up.
fpath=("$HOME/.zsh/completion" $fpath)
