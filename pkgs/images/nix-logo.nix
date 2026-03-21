{
  pkgs ? import <nixpkgs> {},
  runCommandLocal ? pkgs.runCommandLocal,
}: let
  base16Scheme = {
    base00 = "11121d";
    base01 = "1e1e2e";
    base02 = "414559";
    base03 = "51576d";
    base04 = "626880";
    base05 = "c6d0f5";
    base06 = "f2d5cf";
    base07 = "babbf1";
    base08 = "e78284";
    base09 = "ef9f76";
    base0A = "e5c890";
    base0B = "a6d189";
    base0C = "81c8be";
    base0D = "8caaee";
    base0E = "ca9ee6";
    base0F = "eebebe";
  };
  src =
    pkgs.writeText "nix-logo.svg"
    /*
    XML
    */
    ''
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="-3147.3225303193467 -2992.9837954790196 11119.632365326193 5985.967590958039">
          <defs>
              <linearGradient gradientUnits="userSpaceOnUse" id="linear-gradient-44584babfef90c4cb32c8ee42b1193ba" x1="-319.9999999999999" x2="127.99999999999996" y1="-554.2562584220408" y2="221.70250336881628">
                <stop offset="0%" stop-color="$base08" />
                <stop offset="25%" stop-color="$base08" />
                <stop offset="100%" stop-color="$base08" />
              </linearGradient>
              <linearGradient gradientUnits="userSpaceOnUse" id="linear-gradient-96af2d924a4fbf5b015c244addc578a8" x1="-319.9999999999999" x2="127.99999999999996" y1="-554.2562584220408" y2="221.70250336881628">
                <stop offset="0%" stop-color="$base09" />
                <stop offset="25%" stop-color="$base09" />
                <stop offset="100%" stop-color="$base09" />
              </linearGradient>
              <linearGradient gradientUnits="userSpaceOnUse" id="linear-gradient-33ff75d118a188d564af252422e7cc92" x1="-319.9999999999999" x2="127.99999999999996" y1="-554.2562584220408" y2="221.70250336881628">
                <stop offset="0%" stop-color="$base0A" />
                <stop offset="25%" stop-color="$base0A" />
                <stop offset="100%" stop-color="$base0A" />
              </linearGradient>
              <linearGradient gradientUnits="userSpaceOnUse" id="linear-gradient-2a0b6b52f041088f95dc76196e6b4d88" x1="-319.9999999999999" x2="127.99999999999996" y1="-554.2562584220408" y2="221.70250336881628">
                <stop offset="0%" stop-color="$base0B" />
                <stop offset="25%" stop-color="$base0B" />
                <stop offset="100%" stop-color="$base0B" />
              </linearGradient>
              <linearGradient gradientUnits="userSpaceOnUse" id="linear-gradient-c6751d2115edfa2506ed6789e247b928" x1="-319.9999999999999" x2="127.99999999999996" y1="-554.2562584220408" y2="221.70250336881628">
                <stop offset="0%" stop-color="$base0D" />
                <stop offset="25%" stop-color="$base0D" />
                <stop offset="100%" stop-color="$base0D" />
              </linearGradient>
              <linearGradient gradientUnits="userSpaceOnUse" id="linear-gradient-6b2d1737e4a2ebfe17f3769056568c22" x1="-319.9999999999999" x2="127.99999999999996" y1="-554.2562584220408" y2="221.70250336881628">
                <stop offset="0%" stop-color="$base0E" />
                <stop offset="25%" stop-color="$base0E" />
                <stop offset="100%" stop-color="$base0E" />
              </linearGradient>
          </defs>
          <rect x="-3147.32" y="-3500.98" fill="$base01" width="11119.63" height="7085.97"/>
          <g transform="translate(2403.49 0)">
            <polygon fill="url(#linear-gradient-44584babfef90c4cb32c8ee42b1193ba)" points="-303.9999999999999 -304.8409421321224 -175.9999999999999 -526.5434455009388 384.00000000000006 443.40500673763256 128.00000000000006 443.40500673763256 -4.072608916703642e-14 221.70250336881628 -128.00000000000023 443.40500673763245 -256.0000000000002 443.40500673763245 -320.0000000000002 332.55375505322434 -128.0 0.0" transform="translate(-319.9999999999999 554.2562584220408) rotate(0 319.9999999999999 -554.2562584220408)"/>
            <polygon fill="url(#linear-gradient-96af2d924a4fbf5b015c244addc578a8)" points="-303.9999999999999 -304.8409421321224 -175.9999999999999 -526.5434455009388 384.00000000000006 443.40500673763256 128.00000000000006 443.40500673763256 -4.072608916703642e-14 221.70250336881628 -128.00000000000023 443.40500673763245 -256.0000000000002 443.40500673763245 -320.0000000000002 332.55375505322434 -128.0 0.0" transform="translate(-319.9999999999999 554.2562584220408) rotate(60 319.9999999999999 -554.2562584220408)"/>
            <polygon fill="url(#linear-gradient-33ff75d118a188d564af252422e7cc92)" points="-303.9999999999999 -304.8409421321224 -175.9999999999999 -526.5434455009388 384.00000000000006 443.40500673763256 128.00000000000006 443.40500673763256 -4.072608916703642e-14 221.70250336881628 -128.00000000000023 443.40500673763245 -256.0000000000002 443.40500673763245 -320.0000000000002 332.55375505322434 -128.0 0.0" transform="translate(-319.9999999999999 554.2562584220408) rotate(120 319.9999999999999 -554.2562584220408)"/>
            <polygon fill="url(#linear-gradient-2a0b6b52f041088f95dc76196e6b4d88)" points="-303.9999999999999 -304.8409421321224 -175.9999999999999 -526.5434455009388 384.00000000000006 443.40500673763256 128.00000000000006 443.40500673763256 -4.072608916703642e-14 221.70250336881628 -128.00000000000023 443.40500673763245 -256.0000000000002 443.40500673763245 -320.0000000000002 332.55375505322434 -128.0 0.0" transform="translate(-319.9999999999999 554.2562584220408) rotate(180 319.9999999999999 -554.2562584220408)"/>
            <polygon fill="url(#linear-gradient-c6751d2115edfa2506ed6789e247b928)" points="-303.9999999999999 -304.8409421321224 -175.9999999999999 -526.5434455009388 384.00000000000006 443.40500673763256 128.00000000000006 443.40500673763256 -4.072608916703642e-14 221.70250336881628 -128.00000000000023 443.40500673763245 -256.0000000000002 443.40500673763245 -320.0000000000002 332.55375505322434 -128.0 0.0" transform="translate(-319.9999999999999 554.2562584220408) rotate(240 319.9999999999999 -554.2562584220408)"/>
            <polygon fill="url(#linear-gradient-6b2d1737e4a2ebfe17f3769056568c22)" points="-303.9999999999999 -304.8409421321224 -175.9999999999999 -526.5434455009388 384.00000000000006 443.40500673763256 128.00000000000006 443.40500673763256 -4.072608916703642e-14 221.70250336881628 -128.00000000000023 443.40500673763245 -256.0000000000002 443.40500673763245 -320.0000000000002 332.55375505322434 -128.0 0.0" transform="translate(-319.9999999999999 554.2562584220408) rotate(300 319.9999999999999 -554.2562584220408)"/>
          </g>
      </svg>
    '';
  height = toString (1080 * 2);
  width = toString (1920 * 2);
  inherit
    (base16Scheme)
    base01
    base08
    base09
    base0A
    base0B
    base0D
    base0E
    ;
in
  runCommandLocal "nix-logo.png"
  {
    nativeBuildInputs = [pkgs.python312Packages.cairosvg];
    inherit
      src
      width
      height
      base01
      base08
      base09
      base0A
      base0B
      base0D
      base0E
      ;
    dontUnpack = true;
  }
  ''
    # Copy and patch the SVG with colors
    cp "$src" wallpaper.svg

    # Replace color placeholders
    sed "s/\\\$base01/#$base01/g" -i wallpaper.svg
    sed "s/\\\$base08/#$base08/g" -i wallpaper.svg
    sed "s/\\\$base09/#$base09/g" -i wallpaper.svg
    sed "s/\\\$base0A/#$base0A/g" -i wallpaper.svg
    sed "s/\\\$base0B/#$base0B/g" -i wallpaper.svg
    sed "s/\\\$base0D/#$base0D/g" -i wallpaper.svg
    sed "s/\\\$base0E/#$base0E/g" -i wallpaper.svg

    # Generate PNG
    python3 -m cairosvg wallpaper.svg \
      --output $out \
      --output-width $width \
      --output-height $height
  ''
