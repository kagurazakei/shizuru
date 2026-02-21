{
  lib,
  python312Packages,
  mpv,
  writeShellScriptBin,
  sources,
}:

let
  version = "3.3.7";

  wrappedMpv = writeShellScriptBin "mpv" ''
    export __NV_PRIME_RENDER_OFFLOAD=0  # Force Intel GPU
    exec ${mpv}/bin/mpv \
      --gpu-context=wayland \
      --vo=gpu \
      --hwdec=no \
      "$@"
  '';
in
python312Packages.buildPythonApplication {
  pname = "viu";
  inherit version;

  pyproject = true;

  src = sources.viu;
  build-system = with python312Packages; [
    hatchling
  ];

  dependencies = with python312Packages; [
    click
    inquirerpy
    requests
    rich
    thefuzz
    yt-dlp
    dbus-python
    plyer
    fastapi
    pycryptodome
    pypresence
    httpx
    pydantic
  ];

  postPatch = ''
    substituteInPlace pyproject.toml \
      --replace-fail "pydantic>=2.11.7" "pydantic>=2.11.4"
  '';

  makeWrapperArgs = [
    "--prefix PATH : ${lib.makeBinPath [ wrappedMpv ]}"
  ];

  # Tests currently not suitable for nix build
  doCheck = false;

  meta = with lib; {
    description = "Your browser anime experience from the terminal";
    homepage = "https://github.com/viu-media/Viu";
    changelog = "https://github.com/viu-media/Viu/releases/tag/v${version}";
    license = licenses.unlicense;
    maintainers = with maintainers; [ theobori ];
    mainProgram = "viu";
    platforms = platforms.linux;
  };
}
