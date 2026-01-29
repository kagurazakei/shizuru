{
  pkgs,
  inputs,
  ...
}: {
  hj.packages = with pkgs; [
    inputs.alejandra.packages.${pkgs.stdenv.hostPlatform.system}.default
    stylua
    dwt1-shell-color-scripts
    inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
