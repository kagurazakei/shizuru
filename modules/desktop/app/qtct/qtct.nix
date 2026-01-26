{ ... }:
{
  hj.files = {
    ".config/qt5ct/qt5ct.conf".text = ''
      [Appearance]
      color_scheme_path=/home/antonio/.config/qt5ct/colors/Catppuccin-Mocha.conf
      custom_palette=true
      icon_theme=Papirus-Dark
      standard_dialogs=xdgdesktopportal
      style=kvantum-dark

      [Fonts]
      fixed="JetBrainsMono Nerd Font,12,-1,5,57,0,0,0,0,0,Medium"
      general="JetBrainsMono Nerd Font,13,-1,5,57,0,0,0,0,0,Medium"

      [Interface]
      activate_item_on_single_click=1
      buttonbox_layout=0
      cursor_flash_time=1000
      dialog_buttons_have_icons=1
      double_click_interval=400
      gui_effects=@Invalid()
      keyboard_scheme=2
      menus_have_icons=true
      show_shortcuts_in_context_menus=true
      stylesheets=/nix/store/cz5w7scnlb0ygvjn53syqjfv5zizrj6k-qt5ct-1.9/share/qt5ct/qss/fusion-fixes.qss, /nix/store/cz5w7scnlb0ygvjn53syqjfv5zizrj6k-qt5ct-1.9/share/qt5ct/qss/scrollbar-simple.qss, /nix/store/cz5w7scnlb0ygvjn53syqjfv5zizrj6k-qt5ct-1.9/share/qt5ct/qss/sliders-simple.qss, /nix/store/cz5w7scnlb0ygvjn53syqjfv5zizrj6k-qt5ct-1.9/share/qt5ct/qss/tooltip-simple.qss, /nix/store/cz5w7scnlb0ygvjn53syqjfv5zizrj6k-qt5ct-1.9/share/qt5ct/qss/traynotification-simple.qss
      toolbutton_style=4
      underline_shortcut=1
      wheel_scroll_lines=3

      [SettingsWindow]
      geometry=@ByteArray(\x1\xd9\xd0\xcb\0\x3\0\0\0\0\0\0\0\0\0\0\0\0\x4\x1a\0\0\x5s\0\0\0\0\0\0\0\0\0\0\x4\x1a\0\0\x5s\0\0\0\0\0\0\0\0\bp\0\0\0\0\0\0\0\0\0\0\x4\x1a\0\0\x5s)

      [Troubleshooting]
      force_raster_widgets=1
      ignored_applications=@Invalid()
    '';
    ".config/qt6ct/qt6ct.conf".text = ''
      [Appearance]
      color_scheme_path=/home/antonio/.config/qt6ct/colors/Catppuccin-Mocha.conf
      custom_palette=true
      icon_theme=Papirus-Dark
      standard_dialogs=default
      style=kvantum-dark

      [Fonts]
      fixed="JetBrainsMono Nerd Font,12,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular"
      general="JetBrainsMono Nerd Font,13,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular"

      [Interface]
      activate_item_on_single_click=1
      buttonbox_layout=0
      cursor_flash_time=1000
      dialog_buttons_have_icons=1
      double_click_interval=400
      gui_effects=@Invalid()
      keyboard_scheme=2
      menus_have_icons=true
      show_shortcuts_in_context_menus=true
      stylesheets=@Invalid()
      toolbutton_style=4
      underline_shortcut=1
      wheel_scroll_lines=3

      [SettingsWindow]
      geometry=@ByteArray(\x1\xd9\xd0\xcb\0\x3\0\0\0\0\0\0\0\0\0\0\0\0\x5\xf\0\0\x3\xef\0\0\0\0\0\0\0\0\0\0\x5\xf\0\0\x3\xef\0\0\0\0\x2\0\0\0\bp\0\0\0\0\0\0\0\0\0\0\x5\xf\0\0\x3\xef)

      [Troubleshooting]
      force_raster_widgets=1
      ignored_applications=@Invalid()
    '';
  };
}
