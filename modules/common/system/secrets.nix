{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [
    inputs.sops-nix.nixosModules.sops
    inputs.private-key.nixosModules.default
    ./ssh.nix
  ];
  environment.systemPackages = with pkgs; [
    sops
    age
  ];
  sops = {
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
    "recovery-key" = {
      sopsFile = ../../../secrets/secrets.yaml;
      path = "/home/antonio/.config/git/access.txt";
      owner = "antonio";
      mode = "0400";
    };

    "age-private" = {
      sopsFile = ../../../secrets/secrets.yaml;
      owner = "root";
      path = "/etc/agenix/private.txt";
      mode = "0400";
    };
    "gpg-key" = {
      sopsFile = ../../../secrets/secrets.yaml;
      path = "/home/antonio/.config/keys/gpg-key.txt";
      owner = "antonio";
      mode = "0400";
    };
    "github-ssh" = {
      sopsFile = ../../../secrets/secrets.yaml;
      owner = "antonio";
      mode = "0400";
    };
    "codeberg-ssh" = {
      sopsFile = ../../../secrets/secrets.yaml;
      owner = "antonio";
      mode = "0400";
    };
    "gitlab-ssh" = {
      sopsFile = ../../../secrets/secrets.yaml;
      owner = "antonio";
      mode = "0400";
    };
    "root-access-token" = {
      sopsFile = ../../../secrets/secrets.yaml;
      mode = "0400";
      path = "/etc/nix/root-access.conf";
    };
    "anilist" = {
      sopsFile = ../../../secrets/secrets.yaml;
      owner = "antonio";
      mode = "0400";
      path = "/home/antonio/.config/fastanime/anilist.txt";
    };
  };

  age.identityPaths = ["/etc/agenix/keys.txt"];
  age.secrets = {
    private = {
      file = ../../../secrets/private.age;
      owner = "antonio";
      mode = "0400";
    };
  };
  nix.extraOptions = "
  !include ${config.sops.secrets."nix-access-token".path}
  !include ${config.sops.secrets."root-access-token".path}
  ";
}
