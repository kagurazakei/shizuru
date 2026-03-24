# specials/xvim/shell.nix
{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  name = "xvim-dev";
  buildInputs = with pkgs; [
    npins
    bat
    (writeShellScriptBin "opt" ''
      npins --lock-file opt-plugins.json "$@"
    '')
    (writeShellScriptBin "start" ''
      npins --lock-file start-plugins.json "$@"
    '')
  ];

  shellHook = "";
}
