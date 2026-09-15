# dotfiles

## 1. Homebrew
```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv zsh)"
```

## 2. Clone and install packages
```sh
brew install ghq
ghq get yamat47/dotfiles
cd "$(ghq root)/github.com/yamat47/dotfiles"
brew bundle
```

## 3. Link dotfiles
```sh
./setup.sh
```
Follow the script's output: files it reports as `backup:` were moved aside, and
files it reports as `copy: ... (edit this file)` are machine-local and yours to
fill in (`~/.zprofile`, `~/.gitconfig.local`).

Everything is symlinked, so editing `~/.zshrc`, `~/.config/nvim`, etc. edits
this repository directly: just commit. The one exception is Karabiner, which
rewrites its own config: copy `~/.config/karabiner/karabiner.json` back here
after changing settings in its UI.

## 4. Git commit signing (SSH)
```sh
ssh-keygen -t ed25519 -C "you@example.com"
```
* Register `~/.ssh/id_ed25519.pub` on GitHub twice: as an **Authentication Key** and as a **Signing Key** ([Reference](https://github.com/settings/keys)).
* Set your email in `~/.gitconfig.local`, then re-run `./setup.sh` to generate `~/.config/git/allowed_signers`.
* Run `gh auth login`. Answer **No** when it offers to configure Git: the credential helper is already in `.gitconfig`.

## 5. Runtimes
```sh
mise install
```

## 6. Apps
* **iTerm2**: restart. Preferences are loaded from `iterm2/` in this repo.
* **Karabiner-Elements**: launch and grant permissions. Extra rules from
  `karabiner/complex_modifications/` appear under Complex Modifications > Add rule.
* **Neovim**: launch once; lazy.nvim installs plugins pinned in `lazy-lock.json`.
