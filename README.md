## Install Homebrew ([Reference](https://brew.sh/))
```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Install packages via Homebrew
```sh
brew bundle
```

## iTerm2 setting
* Open iTerm2.
* Under "Preferences > General > Preferences", check "Load preferences from a custom folder or URL".
* Set "/Users/yamat47/.config/dotfiles" as custom folder.
* Restart iTerm2.

## Start using dotfiles.
```sh
chmod 0777 setup.sh
./setup.sh
```
