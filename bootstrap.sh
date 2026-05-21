#!/bin/bash
set -e

DOTFILES_REPO="https://github.com/aryam1/dotfiles"
DOTFILES_DIR="$HOME/.dotfiles"

# ── Detect OS ──────────────────────────────────────────────────────────────────
install_packages() {
    if command -v pacman &>/dev/null; then
        echo "→ Arch detected"
        sudo pacman -S --noconfirm --needed \
            fish fzf zoxide eza neovim git stow \
            tmux uv gcc gdb valgrind unzip \
            fastfetch ttf-jetbrains-mono ttf-meslo-nerd \
            bat ripgrep fd btop git-delta
    elif command -v apt &>/dev/null; then
        echo "→ Debian/Ubuntu detected"
        sudo apt update
        sudo apt install -y \
            fish fzf zoxide eza neovim git stow \
            tmux unzip gcc gdb valgrind build-essential \
            fastfetch bat ripgrep fd-find btop git-delta
        # uv — not in apt, install via official script
        curl -LsSf https://astral.sh/uv/install.sh | sh
    else
        echo "Unsupported package manager. Install packages manually." >&2
        exit 1
    fi
    # Quick Install Dust
    curl -sSfL https://raw.githubusercontent.com/bootandy/dust/refs/heads/master/install.sh | sh
    # Install Tmux Plugin Manager
    if [ ! -d ~/.tmux/plugins/tpm ]; then
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    fi

}

# ── Oh-my-posh (non-WSL only) ──────────────────────────────────────────────────
install_omp() {
    if grep -qi microsoft /proc/version 2>/dev/null; then
        echo "→ WSL detected — skipping oh-my-posh install (using Windows install)"
        return
    fi
    if command -v oh-my-posh &>/dev/null; then
        echo "→ oh-my-posh already installed"
        return
    fi
    echo "→ Installing oh-my-posh"
    curl -s https://ohmyposh.dev/install.sh | bash -s
    mkdir -p "$HOME/.config/oh-my-posh/themes"
    # Download a default theme if no current.txt exists
    if [ ! -f "$HOME/.config/oh-my-posh/themes/current.txt" ]; then
        curl -fsSL "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/catppuccin_mocha.omp.json" \
            -o "$HOME/.config/oh-my-posh/themes/catppuccin_mocha.omp.json"
        echo "catppuccin_mocha.omp.json" > "$HOME/.config/oh-my-posh/themes/current.txt"
    fi
}

# ── Clone dotfiles ─────────────────────────────────────────────────────────────
clone_dotfiles() {
    if [ -d "$DOTFILES_DIR" ]; then
        echo "→ Dotfiles already cloned, pulling latest"
        git -C "$DOTFILES_DIR" pull
    else
        echo "→ Cloning dotfiles"
        git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
    fi
}

# ── Stow ───────────────────────────────────────────────────────────────────────
apply_stow() {
    echo "→ Applying symlinks via stow"
    cd "$DOTFILES_DIR"
    for pkg in fish git nvim tmux; do
        stow --restow --target="$HOME" "$pkg"
        echo "  ✓ $pkg"
    done
}

# ── Git config ─────────────────────────────────────────────────────────────────
configure_git() {
    local gitconfig="$HOME/.gitconfig"
    if grep -q "GIT_NAME" "$gitconfig" 2>/dev/null; then
        echo "→ Configuring git identity"
        read -rp "  Git name: " git_name
        read -rp "  Git email: " git_email
        sed -i "s/GIT_NAME/$git_name/" "$gitconfig"
        sed -i "s/GIT_EMAIL/$git_email/" "$gitconfig"
    fi
}

# ── Default shell ──────────────────────────────────────────────────────────────
set_fish_default() {
    if [ "$(realpath $SHELL)" != "$(realpath $(which fish))" ]; then
        echo "→ Setting fish as default shell"
        command -v fish | sudo tee -a /etc/shells
        chsh -s "$(which fish)"
    else
        echo "→ fish already default shell"
    fi
}

# ── Run ────────────────────────────────────────────────────────────────────────
echo "=== Dotfiles bootstrap ==="
install_packages
install_omp
clone_dotfiles
apply_stow
configure_git
set_fish_default
echo ""
echo "=== Done. Restart your shell ==="
