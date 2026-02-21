{ ... }:
{
  azalea.modules.agenix =
    {
      lib,
      config,
      pkgs,
      sources,
      ...
    }:
    {
      imports = [
        (sources.agenix + "/modules/age.nix")
        (lib.mkAliasOptionModule [ "zaphkiel" "secrets" ] [ "age" "secrets" ])
      ];
      environment.systemPackages = [
        (pkgs.callPackage "${sources.agenix}/pkgs/agenix.nix" { })
      ];
      age.identityPaths = [
        "/etc/ssh/ssh_host_ed25519_key"
        "/persistent/etc/sops-nix/id_ed25519"
      ]
      ++ builtins.map (username: "/home/${username}/.ssh/id_ed25519") config.zaphkiel.data.users;
    };
}
