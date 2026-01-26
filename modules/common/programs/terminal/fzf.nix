{...}: {
  hj.rum.programs.fzf = {
    enable = true;
    integrations = {
      fish.enable = true;
      nushell.enable = true;
    };
  };

  hj.files."~/.config/fzf/default".text = ''
    --layout=reverse
    --height=40%
    --info=inline
    --border=rounded
    --pointer=▶
    --marker=✓
    --prompt=❯
    --color=dark
    --color=bg+:#0a0a13,bg:#0a0a13
    --color=spinner:#8be9fd,hl:#ff92df
    --color=fg:#f8f8f2,header:#bd93f9
    --color=info:#a4ffff,pointer:#ff79c6
    --color=marker:#ff5555,fg+:#ffffff
    --color=prompt:#bd93f9,hl+:#ff92df
  '';
}
