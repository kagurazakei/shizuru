{...}: {
  hm.programs.btop = {
    enable = true;
    settings = {
      color_theme = "btop";
      theme_background = false;
    };
    themes = {
      mocha-refine = ''

        theme[main_bg]="#0a0a13"
        theme[main_fg]="#f8f8f2"
        theme[title]="#f8f8f2"
        theme[hi_fg]="#8be9fd"
        theme[selected_bg]="#45475a"
        theme[selected_fg]="#8be9fd"
        theme[inactive_fg]="#7f849c"
        theme[graph_text]="#f5e0dc"
        theme[meter_bg]="#45475a"
        theme[proc_misc]="#f5e0dc"
        theme[cpu_box]="#cba6f7" #Mauve
        theme[mem_box]="#50fa7b" #Green
        theme[net_box]="#ff5555" #Maroon
        theme[proc_box]="#8be9fd" #Blue
        theme[div_line]="#6c7086"
        theme[temp_start]="#50fa7b"
        theme[temp_mid]="#f9e2af"
        theme[temp_end]="#ff6e6e"
        theme[cpu_start]="#94e2d5"
        theme[cpu_mid]="#74c7ec"
        theme[cpu_end]="#b4befe"
        theme[free_start]="#cba6f7"
        theme[free_mid]="#b4befe"
        theme[free_end]="#8be9fd"
        theme[cached_start]="#74c7ec"
        theme[cached_mid]="#8be9fd"
        theme[cached_end]="#b4befe"
        theme[available_start]="#fab387"
        theme[available_mid]="#ff5555"
        theme[available_end]="#ff6e6e"
        theme[used_start]="#50fa7b"
        theme[used_mid]="#94e2d5"
        theme[used_end]="#89dceb"
        theme[download_start]="#fab387"
        theme[download_mid]="#ff5555"
        theme[download_end]="#ff6e6e"
        theme[upload_start]="#50fa7b"
        theme[upload_mid]="#94e2d5"
        theme[upload_end]="#89dceb"
        theme[process_start]="#74c7ec"
        theme[process_mid]="#b4befe"
        theme[process_end]="#cba6f7"
      '';
    };
  };
}
