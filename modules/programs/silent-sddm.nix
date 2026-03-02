{...} @ inputs: {
  # NOTE
  # ╭──────────────────────────────────────────────────────────╮
  # │ complete this weird inputs error ( check                 │
  # │ nixosConfiguration )                                     │
  # ╰──────────────────────────────────────────────────────────╯
  # not really using this which is why the weird @inputs
  # to excape eval errors using laziness

  azalea.modules.silent-sddm = {
    imports = [inputs.silent-sddm.nixosModules.default];
    programs.silentSDDM = {
      enable = true;
      theme = "silvia";
    };
  };
}
