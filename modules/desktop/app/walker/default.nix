{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./walker.nix
  ];
  rum.programs.walker = {
    enable = false;
    systemd.enable = true;
    runAsService = true;
    config = ''

       app_launch_prefix = "uwsm-app -- "
       close_when_open = true
       as_window = false
       disable_click_to_close = true
       force_keyboard_focus = true
       hotreload_theme = true
       locale = ""
       monitor = ""
       terminal_title_flag = ""
       theme = "grid"
       timeout = 0

       [activation_mode]
       labels = "jkl;as"

       [builtins.ai]
       icon = "help-browser"
       name = "ai"
       placeholder = "AI"
       switcher_only = true
       weight = 5

       [[builtins.ai.anthropic.prompts]]
       label = "Artificial Intelligence"
       max_tokens = 1_000
       model = "claude-3-5-sonnet-20241022"
       prompt = "You are a helpful general assistant. Keep your answers short and precise."
       temperature = 1

       [builtins.applications]
       context_aware = true
       hide_actions_with_empty_query = true
       history = true
       name = "applications"
       placeholder = "Search.."
       prioritize_new = true
       refresh = true
       show_generic = true
       show_icon_when_single = true
       show_sub_when_single = true
       weight = 5
       theme = "base16_apps"

         [builtins.applications.actions]
         enabled = true
         hide_category = false
         hide_without_query = true

       [builtins.bookmarks]
       icon = "bookmark"
       name = "bookmarks"
       placeholder = "Bookmarks"
       switcher_only = true
       weight = 5

         [[builtins.bookmarks.entries]]
         keywords = [ "walker", "github" ]
         label = "Walker"
         url = "https://github.com/abenz1267/walker"

       [builtins.calc]
       icon = "accessories-calculator"
       min_chars = 4
       name = "calc"
       placeholder = "Calculator"
       require_number = true
       weight = 5

       [builtins.clipboard]
       avoid_line_breaks = true
       exec = "wl-copy"
       image_height = 300
       max_entries = 100
       name = "clipboard"
       placeholder = "Clipboard"
       switcher_only = true
       weight = 5
       theme = "base16"

       [builtins.commands]
       icon = "utilities-terminal"
       name = "commands"
       placeholder = "Commands"
       switcher_only = true
       weight = 5

       [builtins.custom_commands]
       icon = "utilities-terminal"
       name = "custom_commands"
       placeholder = "Custom Commands"
       weight = 5

       [builtins.dmenu]
       hidden = true
       name = "dmenu"
       placeholder = "Dmenu"
       switcher_only = true
       weight = 5

       [builtins.emojis]
       exec = "wl-copy"
       history = true
       name = "emojis"
       placeholder = "Emojis"
       show_unqualified = false
       switcher_only = true
       typeahead = true
       weight = 5
       theme = "base16"

       [builtins.finder]
       concurrency = 8
       icon = "file"
       ignore_gitignore = true
       name = "finder"
       placeholder = "Finder"
       refresh = true
       show_icon_when_single = true
       switcher_only = true
       use_fd = true
       weight = 5

       [builtins.runner]
       generic_entry = false
       history = true
       icon = "utilities-terminal"
       name = "runner"
       placeholder = "Runner"
       refresh = true
       typeahead = true
       weight = 5

       [builtins.ssh]
       history = true
       icon = "preferences-system-network"
       name = "ssh"
       placeholder = "SSH"
       refresh = true
       switcher_only = true
       weight = 5

       [builtins.switcher]
       name = "switcher"
       placeholder = "Switcher"
       prefix = "/"
       weight = 5

       [builtins.symbols]
       after_copy = ""
       history = true
       name = "symbols"
       placeholder = "Symbols"
       switcher_only = true
       typeahead = true
       weight = 5

       [builtins.websearch]
       icon = "applications-internet"
       name = "websearch"
       placeholder = "Websearch"
       weight = 5

         [[builtins.websearch.entries]]
         name = "Google"
         url = "https://www.google.com/search?q=%TERM%"

         [[builtins.websearch.entries]]
         name = "Elden Ring Wiki"
         switcher_only = true
         url = "https://eldenring.wiki.fextralife.com/Elden+Ring+Wiki#gsc.tab=0&gsc.q=%TERM%&gsc.sort="

       [builtins.windows]
       icon = "view-restore"
       name = "windows"
       placeholder = "Windows"
       show_icon_when_single = true
       weight = 5

       [builtins.xdph_picker]
       hidden = true
       name = "xdphpicker"
       placeholder = "Screen/Window Picker"
       theme = "base16"
       show_sub_when_single = true
       switcher_only = true
       weight = 5

       [events]
       on_activate = ""
       on_exit = ""
       on_launch = ""
       on_query_change = ""
       on_selection = ""

       [keys]
       accept_typeahead = [ "tab" ]
       close = [ "esc" ]
       next = [ "down tab" ]
       prev = [ "up" ]
       remove_from_history = [ "shift backspace" ]
       resume_query = [ "ctrl r" ]
       toggle_exact_search = [ "ctrl m" ]
       trigger_labels = "lalt"

         [keys.activation_modifiers]
         alternate = "alt"
         keep_open = "shift"

         [keys.ai]
         clear_session = [ "ctrl x" ]
         copy_last_response = [ "ctrl c" ]
         resume_session = [ "ctrl r" ]
         run_last_response = [ "ctrl e" ]

       [list]
       dynamic_sub = true
       keyboard_scroll_style = "neovim"
       max_entries = 1_000
       placeholder = "No Results"
       show_initial_entries = true
       single_click = true
       visibility_threshold = 20

       [[plugins]]
       name = "wallpaper"
       placeholder = "Wallpapers"
       theme = "base16_wall"
       switcher_only = false
       refresh = true
       src = "bash -c ~/.config/walker/scripts/wallpaper.sh"
       parser = "kv"

       [[plugins]]
       name = "edit"
       placeholder = "Edit"
       theme = "base16"
       switcher_only = false
       refresh = true
       src = "bash -c ~/.config/walker/scripts/edit.sh"
       parser = "kv"

       [[plugins]]
       name = "niri"
       placeholder = "Edit Niri"
       theme = "base16"
       switcher_only = false
       refresh = true
       src = "bash -c ~/.config/walker/scripts/niri.sh"
       parser = "kv"

       [[plugins]]
       name = "themes"
       placeholder = "Color Scheme"
       theme = "base16"
       switcher_only = false
       refresh = true
       src = "bash -c ~/.config/walker/scripts/themes.sh"
       parser = "kv"

       [[plugins]]
       name = "power"
       placeholder = "System"
       theme = "base16_power"
       switcher_only = true
       keep_sort = true
       recalculate_score = true
       show_icon_when_single = true

      [[plugins.entries]]
         label = "Change Wallpaper"
         icon = "preferences-desktop-wallpaper"
         exec = "walker -n -m wallpaper"

         [[plugins.entries]]
         label = "Logout System"
         icon = "system-suspend"
         exec = "uwsm stop"

         [[plugins.entries]]
         label = "Lock Screen"
         icon = "system-lock-screen"
         exec = "hyprlock"

         [[plugins.entries]]
         label = "Reboot"
         icon = "system-reboot"
         exec = "reboot"

         [[plugins.entries]]
         label = "Shutdown"
         icon = "system-shutdown"
         exec = "shutdown now"

       [[plugins]]
       name = "screenshot"
       placeholder = "Screenshot"
       theme = "base16_popup"
       switcher_only = false
       recalculate_score = true
       show_icon_when_single = true

         [[plugins.entries]]
         label = "Region"
         icon = "region"
         exec = 'hyprshot -m region -z -o ~/Pictures/Screenshots -f "screenshot_$(date +%d%m%Y_%H%M%S).png"'

         [[plugins.entries]]
         label = "Window"
         icon = "window"
         exec = 'hyprshot -m window -z -o ~/Pictures/Screenshots -f "screenshot_$(date +%d%m%Y_%H%M%S).png"'

         [[plugins.entries]]
         label = "Screen"
         icon = "preferences-system-windows"
         exec = 'hyprshot -m output -z -o ~/Pictures/Screenshots -f "screenshot_$(date +%d%m%Y_%H%M%S).png"'

       [search]
       delay = 0
       placeholder = "Search..."
       resume_last_query = false
    '';
  };
  hj.files = {
    # Themes
    ".config/walker/themes/base16.toml".source = ./themes/base16.toml;
    ".config/walker/themes/base16_apps.toml".source = ./themes/base16_apps.toml;
    ".config/walker/themes/base16_popup.toml".source = ./themes/base16_popup.toml;
    ".config/walker/themes/base16_power.toml".source = ./themes/base16_power.toml;
    ".config/walker/themes/base16_wall.toml".source = ./themes/base16_wall.toml;
    ".config/walker/themes/base16_start.json".source = ./themes/base16_start.json;
    ".config/walker/themes/base16_power.json".source = ./themes/base16_power.json;
    ".config/walker/themes/base16.css".source = ./themes/base16.css;
    ".config/walker/themes/base16_apps.css".source = ./themes/base16_apps.css;
    ".config/walker/themes/base16_popup.css".source = ./themes/base16_popup.css;
    ".config/walker/themes/base16_power.css".source = ./themes/base16_power.css;
    ".config/walker/themes/base16_start.css".source = ./themes/base16_start.css;
    ".config/walker/themes/base16_wall.css".source = ./themes/base16_wall.css;
    ".config/walker/themes/default.toml".source = ./themes/default.toml;
    ".config/walker/themes/default_window.toml".source = ./themes/default_window.toml;
    ".config/walker/themes/default.css".source = ./themes/default.css;
    ".config/walker/themes/grid.toml".source = ./themes/grid.toml;
    ".config/walker/themes/grid.css".source = ./themes/grid.css;

    # Scripts
    ".config/walker/scripts/edit.sh".source = ./scripts/edit.sh;
    ".config/walker/scripts/niri.sh".source = ./scripts/niri.sh;
    ".config/walker/scripts/themes.sh".source = ./scripts/themes.sh;
    ".config/walker/scripts/wallpaper.sh".source = ./scripts/wallpaper.sh;
    ".config/walker/scripts/xdph.sh".source = ./scripts/xdph.sh;

    # Plugins
    ".config/walker/plugins/images/script.cjs".source = ./plugins/images/script.cjs;
  };
}
