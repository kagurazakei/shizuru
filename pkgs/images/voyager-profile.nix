{
  fetchurl,
  imagemagick,
  runCommandLocal,
}:
runCommandLocal "voyager-face.jpg" {
  nativeBuildInputs = [imagemagick];
  src = fetchurl {
    url = "https://drive.google.com/file/d/1twJv9RlKAdi5SM33194h7zbF72wCUN4i/view?usp=drive_link";
    hash = "sha256-0RKzzRxW1mtqHutt+9aKzkC5KijIiVLQqW5IRFI/IWY=";
  };
  dontUnpack = true;
}
''
  magick $src -crop 640x640+2300+1580 $out
''
