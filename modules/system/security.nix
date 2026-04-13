{
  azalea.modules.security = {...}: {
    security = {
      sudo = {
        enable = true;
        wheelNeedsPassword = false;
        extraRules = [
          {
            users = ["antonio"];
            commands = [
              {
                command = "/run/current-system/sw/bin/nixos-rebuild";
                options = [
                  "SETENV"
                  "NOPASSWD"
                ];
              }
              {
                command = "/run/current-system/sw/bin/nh";
                options = [
                  "SETENV"
                  "NOPASSWD"
                ];
              }
              {
                command = "ALL";
                options = [
                  "SETENV"
                  "NOPASSWD"
                ];
              }
            ];
          }
        ];
        extraConfig = ''
          Defaults pwfeedback
          Defaults env_keep += "EDITOR PATH DISPLAY"
          Defaults passprompt = "[sudo 󱅞 ]: "
        '';
      };
    };
  };
}
