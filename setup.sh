#!/bin/zsh
# Link this repository's files into $HOME. Safe to re-run: files that would be
# replaced are moved aside as *.bak.<timestamp>; links that already point here
# and copies that are already identical are left alone.
set -eu

DOTFILES="${0:A:h}"
STAMP="$(date +%Y%m%d%H%M%S)"

backup() {
  local target="$1"
  if [ -e "$target" ] || [ -L "$target" ]; then
    echo "backup: $target -> $target.bak.$STAMP"
    mv "$target" "$target.bak.$STAMP"
  fi
}

link() {
  local src="$1" dst="$2"
  if [ -L "$dst" ] && [ "$dst" -ef "$src" ]; then
    echo "ok:     $dst"
    return
  fi
  backup "$dst"
  mkdir -p "${dst:h}"
  ln -s "$src" "$dst"
  echo "link:   $dst -> $src"
}

# For apps that rewrite their own config file (a symlink would be replaced).
copy() {
  local src="$1" dst="$2"
  if cmp -s "$src" "$dst"; then
    echo "ok:     $dst"
    return
  fi
  backup "$dst"
  mkdir -p "${dst:h}"
  cp "$src" "$dst"
  echo "copy:   $dst"
}

copy_if_missing() {
  local src="$1" dst="$2"
  if [ -e "$dst" ]; then
    echo "keep:   $dst (already exists)"
  else
    mkdir -p "${dst:h}"
    cp "$src" "$dst"
    echo "copy:   $dst (edit this file)"
  fi
}

### zsh ###
link "$DOTFILES/.zshrc" "$HOME/.zshrc"
link "$DOTFILES/zsh"    "$HOME/.zsh"
copy_if_missing "$DOTFILES/.zprofile.sample" "$HOME/.zprofile"

### Neovim ###
link "$DOTFILES/nvim" "$HOME/.config/nvim"

### Git ###
link "$DOTFILES/.gitconfig" "$HOME/.gitconfig"
copy_if_missing "$DOTFILES/.gitconfig.local.sample" "$HOME/.gitconfig.local"
# allowed_signers is machine-specific (one key per machine); paths come from .gitconfig.
signers="$(git config --type=path gpg.ssh.allowedSignersFile)"
pubkey="$(git config --type=path user.signingkey)"
if [ -f "$pubkey" ] && [ ! -f "$signers" ]; then
  email="$(git config user.email || true)"
  case "$email" in
    ""|FIXME)
      echo "skip:   $signers (set user.email in ~/.gitconfig.local, then re-run)" ;;
    *)
      mkdir -p "${signers:h}"
      printf '%s %s\n' "$email" "$(<"$pubkey")" > "$signers"
      echo "write:  $signers" ;;
  esac
fi

### Karabiner-Elements ###
copy "$DOTFILES/karabiner/karabiner.json"        "$HOME/.config/karabiner/karabiner.json"
link "$DOTFILES/karabiner/complex_modifications" "$HOME/.config/karabiner/assets/complex_modifications"

### mise / gh / lazydocker ###
link "$DOTFILES/mise/config.toml"      "$HOME/.config/mise/config.toml"
link "$DOTFILES/gh/config.yml"         "$HOME/.config/gh/config.yml"
link "$DOTFILES/lazydocker/config.yml" "$HOME/Library/Application Support/lazydocker/config.yml"

### iTerm2: load preferences from this repository ###
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$DOTFILES/iterm2"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true
echo "iterm2: preferences folder set to $DOTFILES/iterm2 (restart iTerm2)"

echo "done."
