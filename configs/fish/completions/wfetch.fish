
complete -c focal -l wallpaper -d 'Show section of wallpaper' -r
complete -c focal -l crop -d 'Specify square area of the wallpaper to display in the format WxH+X+Y' -r
complete -c focal -l wallpaper-ascii -l ascii-wallpaper -l ascii -d 'Show section of wallpaper in ascii' -r
complete -c focal -l challenge-timestamp -d 'Start of the challenge as a UNIX timestamp in seconds' -r
complete -c focal -l challenge-years -d 'Duration of challenge in years' -r
complete -c focal -l challenge-months -d 'Duration of challenge in months' -r
complete -c focal -l challenge-type -d 'Type of the challenge, e.g. emacs' -r
complete -c focal -l image-size -d 'Image size in pixels' -r
complete -c focal -l ascii-size -d 'Ascii size in characters' -r
complete -c focal -l scale -d 'Scale factor for high DPI displays' -r
complete -c focal -l generate -d 'Type of shell completion to generate' -r -f -a "bash\t''
zsh\t''
fish\t''"
complete -c focal -l hollow -d 'Show hollow NixOS logo'
complete -c focal -l smooth -d 'Show NixOS logo with smooth edges'
complete -c focal -l waifu -d 'Show waifu NixOS logo with dynamic colors'
complete -c focal -l waifu2 -d 'Show waifu NixOS logo 2 with dynamic colors'
complete -c focal -l challenge -d 'Show challenge progress'
complete -c focal -l listen -l socket -d 'Listen for SIGUSR2 to refresh output'
complete -c focal -l no-color-keys -d 'Do not show colored keys'
complete -c focal -s h -l help -d 'Print help (see more with \'--help\')'
complete -c focal -s V -l version -d 'Print version'
