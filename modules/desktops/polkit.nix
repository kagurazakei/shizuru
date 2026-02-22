{
  azalea.modules.polkit = {
    username,
    pkgs,
    ...
  }: {
    users.users.${username}.packages = with pkgs; [
      polkit_gnome
    ];

    systemd.user.services.polkit-gnome = {
      description = "KDE PolicyKit Agent";
      wantedBy = ["graphical-session.target"];
      after = ["graphical-session.target"];
      partOf = ["graphical-session.target"];

      serviceConfig = {
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      };
    };
  };
}
