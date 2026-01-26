{...}: {
  chaotic.nyx.cache.enable = true;
  chaotic.nyx.overlay.enable = true;

  nix = {
    settings = {
      substituters = [
        "https://nix-community.cachix.org"
        "https://chaotic-nyx.cachix.org"
        "https://nyx.chaotic.cx"
        "https://hyprland.cachix.org"
        "https://yazi.cachix.org"
        "https://walker-git.cachix.org"
        "https://walker.cachix.org"
        "https://catppuccin.cachix.org"
        "https://niri.cachix.org"
        "https://cache.nixos.org?priority=10" # Keep this last
      ];

      trusted-substituters = [
        "https://nix-community.cachix.org"
        "https://chaotic-nyx.cachix.org"
        "https://nyx.chaotic.cx"
        "https://hyprland.cachix.org"
        "https://yazi.cachix.org"
        "https://walker-git.cachix.org"
        "https://walker.cachix.org"
        "https://catppuccin.cachix.org"
        "https://niri.cachix.org"
        "https://cache.nixos.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
        "walker-git.cachix.org-1:vmC0ocfPWh0S/vRAQGtChuiZBTAe4wiKDeyyXM0/7pM="
        "walker.cachix.org-1:fG8q+uAaMqhsMxWjwvk0IMb4mFPFLqHjuvfwQxE4oJM="
        "catppuccin.cachix.org-1:noG/4HkbhJb+lUAdKrph6LaozJvAeEEZj4N732IysmU="
        "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];

      connect-timeout = 5;
      log-lines = 25;
      fallback = true;
      warn-dirty = false;
    };

    extraOptions = ''
      min-free = ${toString (1024 * 1024 * 1024)}
      max-free = ${toString (5 * 1024 * 1024 * 1024)}
    '';
  };

  environment.variables.NIX_REMOTE = "daemon";
}
