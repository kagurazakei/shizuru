source ~/.config/fish/user_variables.fish
source ~/.config/fish/abbreviations.fish
source ~/.config/fish/aliases.fish
set -xg ATUIN_NOBIND true
atuin init fish | source
any-nix-shell fish --info-right | source
bind \cr _atuin_search
bind -M insert \cr _atuin_search
bind \e\[1\;5A _atuin_search
bind up _atuin_search

# theme
set -g theme_color_scheme catppuccin-mocha
set -g fish_prompt_pwd_dir_length 5
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always

# colors
set -g fish_color_normal abb2bf
set -g fish_color_command c678dd
set -g fish_color_quote 98c379
set -g fish_color_redirection 56b6c2
set -g fish_color_end abb2bf
set -g fish_color_error e06c75
set -g fish_color_param e06c75
set -g fish_color_comment 5c6370
set -g fish_color_match 56b6c2 --underline
set -g fish_color_search_match --background=2e6399
set -g fish_color_operator c678dd
set -g fish_color_escape 56b6c2
set -g fish_color_cwd e06c75
set -g fish_color_autosuggestion abb2bf
set -g fish_color_valid_path e06c75 --underline
set -g fish_color_history_current 56b6c2
set -g fish_color_selection --background=5c6370
set -g fish_color_user 61afef
set -g fish_color_host 98c379
set -g fish_color_cancel 5c6370
set -g hydro_color_quote 98c379
# Completion Pager Colors
set -g fish_pager_color_completion abb2bf
set -g fish_pager_color_prefix 98c379
set -g fish_pager_color_description abb2bf
set -g fish_pager_color_progress abb2bf
set -g fish_plugins autojump vi-mode
set -g hydro_symbol_prompt 
set -g hydro_color_prompt $fish_color_error
set -g hydro_fetch true
set -g hydro_color_git $fish_color_host
set -g hydro_multiline true
set -g hydro_color_pwd $fish_color_error
set -g hydro_symbol_git 
set -g hydro_symbol_git_dirty 
set -g hydro_symbol_git_ahead 
if command -q nix-your-shell
    nix-your-shell fish | source
end
set -Ux CARAPACE_BRIDGES 'zsh,fish,bash,inshellisense' # optional
# carapace _carapace | source
