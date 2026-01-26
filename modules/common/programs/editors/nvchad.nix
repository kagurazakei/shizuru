{ pkgs, inputs, ... }: {
  hj.packages = with pkgs; [
    inputs.alejandra.packages.${pkgs.system}.default
    stylua
    dwt1-shell-color-scripts
    inputs.neovim-nightly-overlay.packages.${pkgs.system}.default
  ];
}
