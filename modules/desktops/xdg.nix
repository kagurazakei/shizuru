{
  azalea.modules.xdg = {
    lib,
    pkgs,
    ...
  }: {
    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      config = {
        common = {
          default = "gtk gnome";
          "org.freedesktop.impl.portal.ScreenCast" = "gnome";
          "org.freedesktop.impl.portal.Screenshot" = "gnome";
          "org.freedesktop.impl.portal.RemoteDesktop" = "gnome";
          "org.freedesktop.impl.portal.FileChooser" = "termfilechooser";
        };
      };
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-gnome
        xdg-desktop-portal-wlr
        xdg-desktop-portal
        xdg-desktop-portal-termfilechooser
      ];
    };
    environment.sessionVariables.NIX_XDG_DESKTOP_PORTAL_DIR = lib.mkForce null;
    hj.xdg.config.files = {
      "xdg-desktop-portal-termfilechooser/config".text = ''
        [filechooser]
            cmd=${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
      '';
    };
  };
}
