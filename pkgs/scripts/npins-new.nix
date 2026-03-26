{
  writers,
  bash,
  npins,
  coreutils,
  gnused,
}:
writers.writeBashBin "npins-helper" ''
    #!${bash}/bin/bash
    set -euo pipefail

    export PATH="${coreutils}/bin:${gnused}/bin:${npins}/bin:$PATH"

    # ---------------- GLOBAL CONFIG ----------------
    NPINS_FILE="''${NPINS_FILE:-npins/sources.json}"

    # ---------------- ARG PARSER ----------------
    while [[ $# -gt 0 ]]; do
      case "$1" in
        --file)
          shift
          [[ -z "''${1:-}" ]] && echo "Missing file after --file" && exit 1
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

    # ---------------- helpers ----------------
    log() {
      printf "\033[1;34m[INFO]\033[0m %s\n" "$*"
    }

    err() {
      printf "\033[1;31m[ERROR]\033[0m %s\n" "$*" >&2
      exit 1
    }

    npins_cmd() {
      ${npins}/bin/npins --lock-file "$NPINS_FILE" "$@"
    }

    # ---------------- usage ----------------
    usage() {
      cat <<EOF
  📦 NPins Helper

  Usage:
    npins-helper [--file path] add <mixed sources...>
    npins-helper [--file path] remove name [name ...]
    npins-helper [--file path] show

  Add supports inline mixed sources with per-source options:

    github owner/repo [args...]
    git URL [args...]
    tarball URL [args...]

  Examples:
    npins-helper --file sources.json add github nixos/nixpkgs -b master github neovim/neovim -b main
    npins-helper add github owner/repo -b main git https://example.com/repo.git
    npins-helper add github a/b -b main github c/d --at 123456 git https://repo

  EOF
      exit 1
    }

    [[ -z "''${cmd:-}" ]] && usage

    # ---------------- COMMANDS ----------------
    case "$cmd" in

      # ---------------- ADD ----------------
      add)
        [[ $# -eq 0 ]] && usage

        while [[ $# -gt 0 ]]; do
          type="$1"
          shift

          case "$type" in

            github)
              [[ $# -eq 0 ]] && err "Missing github repo"

              repo="$1"
              shift

              owner="''${repo%%/*}"
              name="''${repo##*/}"
              [[ "$owner" == "$name" ]] && err "Invalid github repo: $repo"

              args=()
              while [[ $# -gt 0 && "$1" != "github" && "$1" != "git" && "$1" != "tarball" ]]; do
                args+=("$1")
                shift
              done

              log "github → $owner/$name ''${args[*]}"
              npins_cmd add github "$owner" "$name" "''${args[@]}"
              ;;

            git)
              [[ $# -eq 0 ]] && err "Missing git url"

              url="$1"
              shift

              args=()
              while [[ $# -gt 0 && "$1" != "github" && "$1" != "git" && "$1" != "tarball" ]]; do
                args+=("$1")
                shift
              done

              log "git → $url ''${args[*]}"
              npins_cmd add git "$url" "''${args[@]}"
              ;;

            tarball)
              [[ $# -eq 0 ]] && err "Missing tarball url"

              url="$1"
              shift

              name="$(basename "$url" | sed 's/\.tar\..*$//')"

              args=()
              while [[ $# -gt 0 && "$1" != "github" && "$1" != "git" && "$1" != "tarball" ]]; do
                args+=("$1")
                shift
              done

              log "tarball → $name ''${args[*]}"
              npins_cmd add tarball "$url" -n "$name" "''${args[@]}"
              ;;

            *)
              err "Unknown type: $type"
              ;;
          esac
        done
        ;;

      # ---------------- REMOVE ----------------
      remove)
        [[ $# -eq 0 ]] && err "No pins provided"

        for name in "$@"; do
          log "remove → $name"
          npins_cmd remove "$name"
        done
        ;;

      # ---------------- SHOW ----------------
      show)
        npins_cmd show
        ;;

      *)
        usage
        ;;
    esac
''
