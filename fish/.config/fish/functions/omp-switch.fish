function omp-switch --description 'Switch oh-my-posh theme by partial name'
    if test (count $argv) -ne 1
        echo "Usage: omp-switch <partial-theme-name>"
        return 1
    end

    set needle $argv[1]
    set current_txt "$themesPath/current.txt"

    if not test -d "$themesPath"
        echo "Themes path not found: $themesPath"
        return 1
    end

    # Find matching themes
    set matches (ls $themesPath | string match -ri ".*$needle.*\.omp\.json\$")

    if test (count $matches) -eq 0
        echo "No matching themes found for: $needle"
        return 1
    end

    if test (count $matches) -gt 1
        echo "Multiple matches – choose one:"
        set choice (printf "%s\n" $matches | fzf)
        if test -z "$choice"
            echo "Cancelled."
            return 1
        end
        set matches $choice
    end

    set theme_file $matches[1]
    echo $theme_file > $current_txt
    oh-my-posh init fish --config "$themesPath/$theme_file" | source
    echo "Switched theme to: $theme_file"
end
