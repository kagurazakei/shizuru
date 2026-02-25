{
  dandelion.modules.getty-autostart = {
    config,
    lib,
    ...
  }: {
    services.getty = {
      autologinUser = "antonio";
      autologinOnce = true;
    };
    programs.fish.loginShellInit = lib.mkIf config.programs.uwsm.enable ''
      if uwsm check may-start;
        uwsm start niri-uwsm.desktop
      end
    '';
  };
}
