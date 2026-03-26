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
          [[ -z "''${1:-}" ]] && echo "Missing file after --file" >&2 && exit 1
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
    npins-helper [--file path] add github repo [repo ...] [npins args]
    npins-helper [--file path] add git url [url ...] [npins args]
    npins-helper [--file path] add tarball url [url ...]
    npins-helper [--file path] remove name [name ...]
    npins-helper [--file path] show

  Examples:
    npins-helper --file ~/nixos/npins/sources.json add github nixos/nixpkgs neovim/neovim -b main
    npins-helper add git https://github.com/user/repo.git -b main
    npins-helper remove blink-cmp mini.nvim
  EOF
      exit 1
    }

    [[ -z "''${cmd:-}" ]] && usage

    # ---------------- COMMANDS ----------------
    case "$cmd" in

      # ---------------- ADD ----------------
      add)
        type="''${1:-}"
        shift || true
        [[ -z "$type" ]] && usage

        case "$type" in

          github)
            repos=()

            while [[ $# -gt 0 && "$1" != -* ]]; do
              repos+=("$1")
              shift
            done

            [[ ''${#repos[@]} -eq 0 ]] && err "No github repos provided"

            for r in "''${repos[@]}"; do
              owner="''${r%%/*}"
              repo="''${r##*/}"

              [[ "$owner" == "$repo" ]] && err "Invalid github repo: $r"

              log "github → $owner/$repo"
              npins_cmd add github "$owner" "$repo" "$@"
            done
            ;;

          git)
            urls=()

            while [[ $# -gt 0 && "$1" != -* ]]; do
              urls+=("$1")
              shift
            done

            [[ ''${#urls[@]} -eq 0 ]] && err "No git urls provided"

            for url in "''${urls[@]}"; do
              log "git → $url"
              npins_cmd add git "$url" "$@"
            done
            ;;

          tarball)
            urls=("$@")

            [[ ''${#urls[@]} -eq 0 ]] && err "No tarball urls provided"

            for url in "''${urls[@]}"; do
              name="$(basename "$url" | sed 's/\.tar\..*$//')"
              log "tarball → $name"
              npins_cmd add tarball "$url" -n "$name"
            done
            ;;

          *)
            err "Unknown type: $type"
            ;;
        esac
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
