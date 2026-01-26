{
  inputs,
  ...
}: let
  ghostty = inputs.ghostty.packages.x86_64-linux.default;
in {
  hj.packages = [ ghostty ];
}
