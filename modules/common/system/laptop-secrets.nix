{
  inputs,
  pkgs,
  config,
  ...
}:
{
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
    users.antonio = {
      directories = [
        "Downloads"
        "Music"
        "Pictures"
        "Documents"
        "Videos"
        {
          directory = ".gnupg";
          mode = "0700";
        }
        {
          directory = ".ssh";
          mode = "0700";
        }
        {
          directory = ".sops-nix";
          mode = "0700";
        }
        {
          directory = ".local/share/keyrings";
          mode = "0700";
        }
        ".local/share/direnv"
      ];
      files = [
        ".screenrc"
      ];
    };
  };
  environment.systemPackages = with pkgs; [
    sops
    age
  ];

  sops = {
    age.keyFile = "/persistent/var/lib/sops-nix/keys.txt";
    defaultSopsFile = ../../../secrets/laptop.yaml;
    defaultSopsFormat = "yaml";
  };
  sops.secrets = {
    "nix-access-token" = {
      sopsFile = ../../../secrets/laptop.yaml;
      owner = "antonio";
      mode = "0440";
      path = "/etc/nix/access-token.conf";
    };
    "github-authentication-code" = {
      sopsFile = ../../../secrets/laptop.yaml;
      owner = "root";
      path = "/etc/sops-nix/keys.txt";
    };
  };
  nix.extraOptions = ''
    !include ${config.sops.secrets."nix-access-token".path}
  '';
}
