{
  imports = [
    ./bootloader.nix
    ./btrfs.nix
    ./laptop-secrets.nix
    ./cachix.nix
    ./console.nix
    # ./gaming.nix
    ./grub.nix
    ./kernel.nix
    ./local-hardware-clock.nix
    ./locale.nix
    ./network.nix
    ./nix.nix
    ./plymouth.nix
    ./powermanagement.nix
    ./scheduler.nix
    ./security.nix
    ./services.nix
    #./secrets.nix
    ./system.nix
    ./virtualization.nix
    ./vm-guest-services.nix
    #./zfs.nix
    ./zram.nix
  ];
}
