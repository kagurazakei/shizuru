{
  azalea.modules.amd = {pkgs, ...}: {
    environment.systemPackages = [pkgs.radeontop];
    hardware.graphics = {
      extraPackages = with pkgs; [
        rocmPackages.clr.icd
        libvdpau-va-gl
        libvdpau-va-gl
      ];
    };
    services.xserver.videoDrivers = ["amdgpu"];
    systemd.tmpfiles.rules = [
      "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
    ];
    environment.sessionVariables.RADV_PERFTEST = "video_decode";
  };
}
