{
  azalea.modules.openssh = {config, ...}: {
    services.openssh = {
      enable = true;
      openFirewall = true;
      startWhenNeeded = true;

      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
        AllowUsers = config.zaphkiel.data.users;
      };

      knownHosts = {
        hana = {
          publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEaNh2GVxWz2zLxDa8cMnPtfYQPk1A3xlKKVuKOTNrp2 antonio@hana";
        };
        kagura = {
          publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDT989Rm6vSVS4cSP2NevoXVS7UnFVYHgfsE6dbM2+s6 hana@antonio";
        };
      };
    };
  };
}
