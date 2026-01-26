{pkgs, ...}: {
  hj = {
    packages = with pkgs; [
      master.carapace
      master.carapace-bridge
      nushell
      fish
      inshellisense
    ];
  };
}
