# extra plugins and plugin overrides (for latest rev)
{
  sources,
  vimPlugins,
  vimUtils,
  lib,
}: let
  inherit (vimUtils) buildVimPlugin;
  inherit (lib) substring;
  toVersion = substring 0 8;
in
  vimPlugins.extend (
    _final: prev: {
      neorg = prev.neorg.overrideAttrs (_: {
        src = sources.neorg;
        version = toVersion sources.neorg.revision;
      });
      direnv-nvim = buildVimPlugin {
        pname = "direnv.nvim";
        version = toVersion sources."direnv.nvim".revision;
        src = sources."direnv.nvim";
      };
      blink-cmp = buildVimPlugin {
        pname = "blink.cmp";
        version = toVersion sources.blink-cmp.revision;
        src = sources.blink-cmp;
        installPhase = ''
          runHook preInstall
          cp -r lua plugin doc $out/
          runHook postInstall
        '';
        env.RUSTC_BOOTSTRAP = true;
      };
      blin-pairs = buildVimPlugin {
        pname = "blink.pairs";
        version = toVersion sources.blink-pairs.revision;
        src = sources.blink-pairs;
        installPhase = ''
          runHook preInstall
          cp -r lua plugin doc $out/
          runHook postInstall
        '';
        env.RUSTC_BOOTSTRAP = true;
      };
    }
  )
