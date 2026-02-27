{
  azalea.modules.atuin = {pkgs, ...}: {
    hj = {
      packages = with pkgs; [atuin];
      xdg.config.files = {
        "atuin/config.toml".text = ''
          dialect = "us"
          timezone = "local"
          auto_sync = true
          update_check = true
          sync_frequency = "30m"
          search_mode = "fuzzy"
          filter_mode = "global"
          workspaces = false
          filter_mode_shell_up_key_binding = "global"
          search_mode_shell_up_key_binding = "fuzzy"
          style = "full"
          show_preview = true
          enter_accept = true
          local_timeout = 20
          [stats]
          [keys]
          [sync]
          records = true
          [preview]
          [daemon]
          [theme]
          name = "catppuccin-macchiato-lavender"
        '';
      };
    };
  };
}
