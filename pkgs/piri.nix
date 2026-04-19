{
  lib,
  rustPlatform,
  sources,
}:
rustPlatform.buildRustPackage (_finalAttrs: {
  pname = "piri";
  version = "0.1.7";
  src = sources.piri;
  cargoHash = "sha256-iFbBpf6vy/0K7Ooubm4WsGZ2tyw+qFT7TkBSuVrOa9o=";

  meta = {
    description = "Piri is a high-performance Niri extension tool built with Rust. It leverages efficient Niri IPC interaction and a unified event distribution mechanism to provide a robust, state-driven plugin system";
    homepage = "https://github.com/Asthestarsfalll/piri";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [Asthestarsfalll];
    mainProgram = "piri";
  };
})
