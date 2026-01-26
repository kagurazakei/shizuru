{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    keyMode = "vi";
    escapeTime = 0;
    terminal = "screen-256color";
    historyLimit = 1000000;
    aggressiveResize = true;
    plugins = with pkgs.tmuxPlugins; [
      sensible
      yank
      resurrect
      continuum
      tmux-thumbs
      tmux-fzf
      fzf-tmux-url
      tmux-sessionx
      tmux-floax
      (pkgs.stdenv.mkDerivation {
        name = "tmux-window-name";
        src = pkgs.fetchFromGitHub {
          owner = "ofirgall";
          repo = "tmux-window-name";
          rev = "9a75967ced4f3925de0714e96395223aa7e2b4ad";
          sha256 = "klS3MoGQnEiUa9RldKGn7D9yxw/9OXbfww43Wi1lV/w=";
        };
        buildPhase = "true"; # no build needed
        installPhase = ''
          mkdir -p $out/share/tmux/plugins/tmux-window-name
          cp -r $src/* $out/share/tmux/plugins/tmux-window-name/
        '';
      })

      (pkgs.stdenv.mkDerivation {
        name = "catppuccin-tmux";
        src = pkgs.fetchFromGitHub {
          owner = "89iuv";
          repo = "tmux";
          rev = "e7b50832f9bc59b0b5ef5316ba2cd6f61e4e22fc";
          sha256 = "9ZfUqEKEexSh06QyR5C+tYd4tNfBi3PsA+STzUv4+/s=";
        };
        buildPhase = "true"; # no build needed
        installPhase = ''
          mkdir -p $out/share/tmux/plugins/catppuccin-tmux
          cp -r $src/* $out/share/tmux/plugins/catppuccin-tmux/
        '';
      })
    ];
  };
}
