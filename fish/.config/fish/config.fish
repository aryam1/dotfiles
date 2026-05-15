# ~/.config/fish/config.fish
# --------------------------
 
set -U fish_history_limit 10000
set -x EDITOR nvim
 
# Detect environment
if grep -qi microsoft /proc/version 2>/dev/null
    set -gx IS_WSL true
    # Dynamically resolve Windows username
    set -gx WIN_USER (cmd.exe /c "echo %USERNAME%" 2>/dev/null | string trim)
    set -gx themesPath /mnt/c/Users/$WIN_USER/AppData/Local/Programs/oh-my-posh/themes
else
    set -gx IS_WSL false
    set -gx themesPath $HOME/.config/oh-my-posh/themes
end
 
# Oh-my-posh
if command -q oh-my-posh; and test -f "$themesPath/current.txt"
    set currentTheme (cat $themesPath/current.txt | string trim)
    set themePath $themesPath/$currentTheme
    oh-my-posh init fish --config $themePath | source
end

if command -q tmux; and not set -q TMUX
    tmux attach-session -t main 2>/dev/null; or tmux new-session -s main
end

# Zoxide
if command -q zoxide
    zoxide init --cmd cd fish | source
end
 
# Aliases
if command -q batcat; and not command -q bat # For Ubuntu
    alias cat 'batcat --pager=never'
    alias bat 'batcat'
else
    alias cat 'bat --pager=never'
end
alias ga 'git add'
alias gc 'git commit -m'
alias gp 'git push'
alias gst 'git status'
