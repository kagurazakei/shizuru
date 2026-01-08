{pkgs, ...}: {
  services = {
    xserver = {
      enable = true;
      excludePackages = [pkgs.xterm];
      desktopManager.xterm.enable = false;
      desktopManager.runXdgAutostartIfNone = true;
      xkb = {
        layout = "us";
        variant = "";
      };
    };

    smartd = {
      enable = false;
      autodetect = true;
    };

    gvfs.enable = true;
    udisks2.enable = true;
    tumbler.enable = true;
    udev.enable = true;
    envfs.enable = true;
    dbus.enable = true;
    dbus.packages = with pkgs; [
      gcr
      gnome-settings-daemon
    ];
    fstrim = {
      enable = true;
      interval = "weekly";
    };

    libinput.enable = true;
    rpcbind.enable = false;
    nfs.server.enable = false;
    openssh.enable = true;
    blueman.enable = true;
    #printing = {
    #  enable = false;
    #  drivers = [
    # pkgs.hplipWithPlugin
    #  ];
    #};

    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    ipp-usb.enable = true;

    # syncthing = {
    # enable = false;
    # user = "${username}";
    # dataDir = "/home/${username}";
    # configDir = "/home/${username}/.config/syncthing";
    #};
  };
}
