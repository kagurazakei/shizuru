{
  writers,
  npins,
}:
writers.writeBashBin "npins-add" ''
  set -euo pipefail

  NPINS_FILE="''${NPINS_FILE:-npins/sources.json}"

  # ---------------- file override ----------------
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --file)
        shift
        NPINS_FILE="$1"
        shift
        ;;
      *)
        break
        ;;
    esac
  done

  cmd="''${1:-}"
  shift || true

  npins_cmd() {
    ${npins}/bin/npins --lock-file "$NPINS_FILE" "$@"
  }

  log() { echo "[INFO] $*"; }
  err() { echo "[ERROR] $*" >&2; exit 1; }

  case "$cmd" in

    add)
      type="''${1:-}"
      shift || true

      case "$type" in

        github)
          for r in "$@"; do
            owner="''${r%%/*}"
            repo="''${r##*/}"
            [[ "$owner" == "$repo" ]] && err "bad github: $r"

            log "github $owner/$repo"
            npins_cmd add github "$owner" "$repo"
          done
          ;;

        git)
          for url in "$@"; do
            log "git $url"
            npins_cmd add git "$url"
          done
          ;;

        tarball)
          for url in "$@"; do
            name="$(basename "$url" | sed 's/\.tar\..*$//')"
            log "tarball $name"
            npins_cmd add tarball "$url" -n "$name"
          done
          ;;

        *)
          err "unknown type"
          ;;
      esac
      ;;

    remove)
      [[ $# -eq 0 ]] && err "no pins provided"
      for p in "$@"; do
        log "remove $p"
        npins_cmd remove "$p"
      done
      ;;

    show)
      npins_cmd show
      ;;

    *)
      echo "Usage:"
      echo "  npins-add [--file path] add github repo1 repo2"
      echo "  npins-add remove pin1 pin2"
      echo "  npins-add show"
      exit 1
      ;;
  esac
''
