# XDG Directories
set -xg XDG_CONFIG_HOME $HOME/.config
set -xg XDG_CACHE_HOME $HOME/.cache
set -xg XDG_DATA_HOME $HOME/.local/share
set -xg XDG_STATE_HOME $HOME/.local/state
set -xg XDG_BIN_HOME $HOME/.local/bin
set -xg XDG_SCRIPT_HOME $HOME/.local/script

# Respect XDG Specification
set -xg NH_FLAKE $HOME/nixos
set -xg NH_OS_FLAKE $HOME/nixos
set -xg CONAN_USER_HOME $XDG_CONFIG_HOME
set -xg GOPATH $XDG_DATA_HOME/go
set -xg GOMODCACHE $XDG_CACHE_HOME/go/mod
set -xg RUSTUP_HOME $XDG_DATA_HOME/rustup
set -xg CARGO_HOME $XDG_DATA_HOME/cargo
set -xg LEIN_HOME $XDG_DATA_HOME/lein
set -xg NUGET_PACKAGES $XDG_CACHE_HOME/NuGetPackages
set -xg ANDROID_HOME $XDG_DATA_HOME/android
set -xg NODE_REPL_HISTORY $XDG_DATA_HOME/node_repl_history
set -xg DOCKER_CONFIG $XDG_CONFIG_HOME/docker
set -xg SQLITE_HISTORY $XDG_DATA_HOME/sqlite_history
set -xg GRADLE_USER_HOME $XDG_DATA_HOME/gradle
set -xg RIPGREP_CONFIG_PATH $HOME/.config/rg/.ripgreprc
set -xg STARSHIP_CONFIG $HOME/.config/starship/starship.toml
set -xg ANSIBLE_HOME $XDG_CONFIG_HOME/ansible
set -xg FFMPEG_DATADIR $XDG_CONFIG_HOME/ffmpeg
set -xg MYSQL_HISTFILE $XDG_DATA_HOME/mysql_history
set -xg OMNISHARPHOME $XDG_CONFIG_HOME/omnisharp
set -xg PYENV_ROOT $XDG_DATA_HOME/pyenv
set -xg WORKON_HOME $XDG_DATA_HOME/virtualenvs
set -xg XINITRC $XDG_CONFIG_HOME/X11/xinitrcexport
set -xg XSERVERRC $XDG_CONFIG_HOME/X11/xserverrc
set -xg HISTFILE $XDG_STATE_HOME/bash/history
set -xg ZSH $XDG_DATA_HOME/oh-my-zsh
set -xg WINEPREFIX $XDG_DATA_HOME/wine
set -xg NPM_CONFIG_USERCONFIG $XDG_CONFIG_HOME/npm/npmrc
set -xg GTK2_RC_FILES $XDG_CONFIG_HOME/gtk-2.0/gtkrc
set -xg W3M_DIR $XDG_DATA_HOME/w3m
set -xg DOTNET_CLI_HOME $XDG_DATA_HOME/dotnet
set -xg MANGA_TUI_DATA_DIR /home/antonio/Documents/mangas
# Editor
set -xg EDITOR nvim
set -xg VISUAL codium
set -xg SUDO_EDITOR $EDITOR
# GPG/LANG
set -xg GPG_TTY (tty)
# Other
if type -q vivid
    set -xg LS_COLORS (vivid generate catppuccin-macchiato)
end
set -xg STARSHIP_LOG error
fish_add_path $XDG_BIN_HOME
