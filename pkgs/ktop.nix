{
  lib,
  python3,
  sources,
}:
python3.pkgs.buildPythonApplication rec {
  pname = "ktop";
  version = "nightly";

  format = "other";

  src = sources.ktop;

  propagatedBuildInputs = with python3.pkgs; [
    psutil
    rich
    nvidia-ml-py
  ];

  installPhase = ''
    runHook preInstall

    install -Dm755 ktop.py $out/bin/ktop

    runHook postInstall
  '';

  meta = with lib; {
    description = "Terminal system monitor with GPU support";
    platforms = platforms.linux;
    mainProgram = "ktop";
  };
}
