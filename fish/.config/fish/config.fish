# ~/.config/fish/config.fish
# --------------------------
 
set -U fish_history_limit 10000
set -x EDITOR nvim
 
# Detect environment
if grep -qi microsoft /proc/version 2>/dev/null
    set -gx IS_WSL true
    # Find theme folder path from whichever user has the folder
    set -gx themesPath /mnt/c/Users/*/AppData/Local/Programs/oh-my-posh/themes
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
alias gu 'git pull'
alias gs 'git status'
alias nv 'nvim'

alias t 'tmux'
