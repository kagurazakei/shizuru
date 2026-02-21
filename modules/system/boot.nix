{
  azalea.modules.boot =
    { pkgs, sources, ... }:
    {
      environment.systemPackages = [
        (pkgs.callPackage "${sources.shizuruPkgs}/pkgs/default.nix" { }).kureiji-ollie-cursors
      ];
      boot = {
        consoleLogLevel = 0;
        loader.efi = {
          canTouchEfiVariables = true;
        };
        loader.timeout = 0;
        loader.systemd-boot = {
          enable = true;
          consoleMode = "max";
          configurationLimit = 8;
          editor = false;
        };
        tmp = {
          useTmpfs = false;
          tmpfsSize = "30%";
        };
        binfmt.registrations.appimage = {
          wrapInterpreterInShell = true;
          interpreter = "${pkgs.appimage-run}/bin/appimage-run";
          recognitionType = "magic";
          offset = 0;
          mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
          magicOrExtension = ''\x7fELF....AI\x02'';
        };
        plymouth = {
          enable = true;
          themePackages = [
            (pkgs.callPackage "${sources.shizuruPkgs}/pkgs/default.nix" { }).cat-plymouth
          ];
          theme = "catppuccin-mocha-mod";
        };
      };
    };
}
