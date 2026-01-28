{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [
    inputs.sops-nix.nixosModules.sops
    inputs.impermanence.nixosModules.impermanence
  ];
  environment.persistence."/persistent" = {
    enable = true; # NB: Defaults to true, not needed
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
      {
        directory = "/var/lib/colord";
        user = "colord";
        group = "colord";
        mode = "u=rwx,g=rx,o=";
      }
    ];
    files = [
      "/etc/sops-nix/keys.txt"
      {
        file = "/var/keys/secret_file";
        parentDirectory = {
          mode = "u=rwx,g=,o=";
        };
      }
    ];
  };
  environment.systemPackages = with pkgs; [
    sops
    age
  ];
  sops = {
    age.keyFile = "/persistent/etc/sops-nix/keys.txt";
    defaultSopsFile = ../../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
  };

  sops.secrets = {
    "nix-access-token" = {
      sopsFile = ../../../secrets/secrets.yaml;
      path = "/etc/nix/access-token.conf";
      owner = "antonio";
      mode = "0400";
    };
    "wakatime" = {
      sopsFile = ../../../secrets/secrets.yaml;
      path = "/etc/sops-nix/wakatime.txt";
      owner = "antonio";
      mode = "0440";
    };
  };

  nix.extraOptions = "
  !include ${config.sops.secrets."nix-access-token".path}
  ";
}
