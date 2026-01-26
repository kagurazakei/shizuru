{...}: {
  hj.rum.programs.fuzzel = {
    enable = true;
  };
  hj.files = {
    ".config/fuzzel/fuzzel.ini".source = "${./fuzzel.ini}";
  };
}
