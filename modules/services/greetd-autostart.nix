{
  azalea.modules.greetd-autostart = {
    services.greetd = {
      enable = true;
      settings =
        let
          initial_session = {
            command = "uwsm start niri-uwsm.desktop";
            user = "antonio";
          };
        in
        {
          inherit initial_session;
          default_session = initial_session;
        };
    };
  };
}
