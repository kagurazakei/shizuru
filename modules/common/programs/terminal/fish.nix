{
  pkgs,
  config,
  username,
  lib,
  ...
}: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
    '';
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
    flags = ["--cmd cd"];
  };
  programs.direnv.enableFishIntegration = true;
  programs.starship = {
    enable = true;
    transientPrompt.enable = true;
    # I don't know why they thought not including starship in environment.systemPackages was
    # a genius idea
    transientPrompt.left = ''
      ${pkgs.starship}/bin/starship module directory
      ${pkgs.starship}/bin/starship module character
    '';
  };
  programs.fzf.keybindings = true;

  environment.systemPackages = [
    pkgs.fishPlugins.done
    pkgs.fishPlugins.sponge
    pkgs.eza
    pkgs.fish-lsp
    pkgs.fishPlugins.hydro
  ];
  hj = {
    xdg.config.files = let
      dot = config.hjem.users.${username}.impure.dotsDir;
    in {
      "fish/config.fish".source = lib.mkForce (dot + "/fish/config.fish");
      "fish/user_variables.fish".source = lib.mkForce (dot + "/fish/user_variables.fish");
      "fish/abbreviations.fish".source = lib.mkForce (dot + "/fish/abbreviations.fish");
      "fish/aliases.fish".source = lib.mkForce (dot + "/fish/aliases.fish");
    };
  };
}
