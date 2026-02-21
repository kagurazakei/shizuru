$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
mkdir $"($nu.cache-dir)"
carapace _carapace nushell | save --force $"($nu.cache-dir)/carapace.nu"
atuin init nu | save --force $"($nu.cache-dir)/atuin.nu"
starship init nu | save -f ~/.cache/starship/init.nu
atuin init nu | save -f ~/.config/nushell/atuin.nu
