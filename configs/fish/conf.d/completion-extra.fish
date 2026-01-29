# ~/.config/fish/conf.d/completion-extra.fish

# Load from completions-extra if it exists
if test -d ~/.config/fish/completions-extra
    for f in ~/.config/fish/completions-extra/*.fish
        if test -r $f
            source $f
        end
    end
end
