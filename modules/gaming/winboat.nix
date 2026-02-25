{
  azalea.modules.winboat =
    { pkgs, ... }:
    {
      virtualisation.docker.enable = true;
      environment.systemPackages = [ pkgs.winboat ];
      users.users.antonio.extraGroups = [ "docker" ];
    };
}
