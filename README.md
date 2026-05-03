# dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Structure

```
dotfiles/
├── fish/           → ~/.config/fish/
├── git/            → ~/.gitconfig
├── nvim/           → ~/.config/nvim/
└── bootstrap.sh
```

## Setup

```bash
git clone https://github.com/yourusername/dotfiles ~/.dotfiles
cd ~/.dotfiles
bash bootstrap.sh
```

Or on a fresh machine:

```bash
curl -fsSL https://raw.githubusercontent.com/yourusername/dotfiles/main/bootstrap.sh | bash
```

## Environments

The config handles two environments automatically:

- **WSL** — oh-my-posh reads themes from the Windows install at `/mnt/c/Users/<winuser>/AppData/...`
- **Native Linux (Hetzner etc.)** — oh-my-posh installed natively, themes at `~/.config/oh-my-posh/themes/`

## Adding a new package

```bash
mkdir -p ~/.dotfiles/newpkg/.config/newpkg
# add your config files
cd ~/.dotfiles
stow newpkg
```
