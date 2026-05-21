{
  lib,
  stdenv,
}: let
  sources = import ../npins;
in
  stdenv.mkDerivation (_finalAttrs: {
    pname = "ambxst";
    version = "nightly";
    src = sources.ambxst;
    meta = {
      description = "An Axtremely customizable shell";
      homepage = "https://github.com/kagurazakei/Ambxst";
      license = lib.licenses.agpl3Only;
      maintainers = with lib.maintainers; [Anxiedie];
      mainProgram = "ambxst";
      platforms = lib.platforms.all;
    };
  })
