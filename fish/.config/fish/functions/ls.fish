function ls --wraps eza --description 'eza with sane defaults'
    eza --color=always --group-directories-first -T -L 1 $argv
end
