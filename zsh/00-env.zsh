# Non-login shells (exec zsh, some editor terminals) skip ~/.zprofile, which
# would leave Homebrew off PATH and break everything below. Re-sourcing it in a
# login shell is harmless: brew shellenv goes through path_helper, which dedups.
[[ -f "$HOME/.zprofile" ]] && source "$HOME/.zprofile"

export LANG=ja_JP.UTF-8
export EDITOR=nvim

command -v mise >/dev/null && eval "$(mise activate zsh)"

# Kept next to the rest of the shell config so it travels with it.
export STARSHIP_CONFIG="$HOME/.zsh/starship.toml"

# Must precede compinit (20-completion.zsh) to be picked up.
fpath=("$HOME/.zsh/completion" $fpath)
