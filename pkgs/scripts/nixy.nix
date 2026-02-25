{
  writeShellScriptBin,
  fzf,
  ...
}:
writeShellScriptBin "nixy" ''
  CONFIG_DIR="$HOME/nixos"
  HOSTNAME="$(hostname)"

  run_command() {
    eval "$1"
  }

  ui() {
    APPS=(
      "󰑓  Rebuild System        :: sudo nixos-rebuild switch --flake $CONFIG_DIR#$HOSTNAME"
      "󰦗  Upgrade System        :: sudo nixos-rebuild switch --upgrade --flake $CONFIG_DIR#$HOSTNAME"
      "󰚰  Update Flake          :: cd $CONFIG_DIR && nix flake update"
      "  Collect Garbage       :: sudo nix-collect-garbage -d"
      "󰍜  Clean Boot Menu       :: sudo /run/current-system/bin/switch-to-configuration boot"
      "󰒲  Push & Remote Build   :: cd $CONFIG_DIR && git add . && git commit -m \"update $(date '+%F %T')\" && git push"
      "󰈆  Loop Mode             :: nixy loop"
      "󰅖  Exit                  :: exit 0"
    )

    SYSTEM_INFO="󰒋  $HOSTNAME  |  $(uname -r)  |  $(date '+%H:%M')"

    selected=$(printf "%s\n" "''${APPS[@]}" | \
      ${fzf}/bin/fzf \
        --height=22 \
        --layout=reverse \
        --border=rounded \
        --info=inline \
        --prompt="󱓞  Nixy ❯ " \
        --pointer="➤" \
        --marker="✓" \
        --header="$SYSTEM_INFO" \
        --preview='echo {} | awk -F ":: " "{print \$2}"' \
        --preview-window=down:3:wrap \
        --color=border:#89b4fa,label:#cba6f7,header:#f38ba8,pointer:#a6e3a1,marker:#f9e2af)

    [[ -z "$selected" ]] && exit 0

    command=$(echo "$selected" | awk -F ':: ' '{print $2}')
    run_command "$command"
  }

  if [[ "$1" == "loop" ]]; then
    while true; do
      clear
      nixy
      echo ""
      echo "Press Enter to continue or 'e' to exit"
      read -n 1 REPLY
      [[ "$REPLY" == "e" ]] && exit 0
    done
  fi

  if [[ -z "$1" ]]; then
    ui
    exit 0
  fi

  # Direct CLI usage (no UI)
  case "$1" in
    rebuild)
      sudo nixos-rebuild switch --flake "$CONFIG_DIR#$HOSTNAME"
      ;;
    upgrade)
      sudo nixos-rebuild switch --upgrade --flake "$CONFIG_DIR#$HOSTNAME"
      ;;
    update)
      cd "$CONFIG_DIR" && nix flake update
      ;;
    gc)
      sudo nix-collect-garbage -d
      ;;
    cb)
      sudo /run/current-system/bin/switch-to-configuration boot
      ;;
    *)
      echo "Unknown argument"
      ;;
  esac
''
