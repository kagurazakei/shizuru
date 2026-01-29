function fish_postexec --on-event fish_postexec
    set -l status $status

    if test $status -eq 0
        kitten notify --icon kitty "✅ Success"
    else
        kitten notify --icon kitty "❌ Failed"
    end
end
