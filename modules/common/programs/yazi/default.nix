{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./keymap.nix
    ./yazi.nix
    ./theme.nix
  ];

  programs.yazi = {
    enable = true;
    initLua = ./configs/init.lua;
    plugins = {
      relative-motions = ./plugins/relative-motions.yazi;
      rich-preview = ./plugins/rich-preview.yazi;
      allmytoes = ./plugins/allmytoes.yazi;
      compress = ./plugins/compress.yazi;
      full-border = ./plugins/full-border.yazi;
      git = ./plugins/git.yazi;
      hide-preview = ./plugins/hide-preview.yazi;
      ouch = ./plugins/ouch.yazi;
      yatline = ./plugins/yatline.yazi;
     # yatline-githead = ./plugins/yatline-githead.yazi;
      rsync = ./plugins/rsync.yazi;
      searchjump = ./plugins/searchjump.yazi;
      smart-enter = ./plugins/smart-enter.yazi;
      smart-filter = ./plugins/smart-filter.yazi;
      starship = ./plugins/starship.yazi;
    };
  };
}
