{
  writers,
  pkgs,
  ...
}: let
  lutThemes = pkgs.runCommand "lutui-themes" {} ''
        mkdir -p $out

        cat > $out/droxo-mokyo <<EOF
    #0a0a13
    #11121d
    #181825
    #181825
    #f8f8f2
    #cdd6f4
    #e2e2df
    #ff5555
    #50fa7b
    #5af78e
    #08bdba
    #33b1ff
    #78a9ff
    #bd93f9
    #ff79c6
    #82cfff
    EOF

        cat > $out/tokyo-mod <<EOF
    #0a0a13
    #12121a
    #1b1b28
    #1e1e2e
    #cbccd1
    #787c99
    #d5d6db
    #a9b1d6
    #9ece6a
    #c0caf5
    #bb9af7
    #f7768e
    #2ac3de
    #0db9d7
    #b4f9f8
    EOF
  '';
in
  writers.writeFishBin "lutui" ''
    set LUTGEN ${pkgs.lutgen}/bin/lutgen
    set THEMES ${lutThemes}
    set USER_THEME_DIR $HOME/.config/lutgen

    function ensure_themes
      mkdir -p $USER_THEME_DIR

      for theme in droxo-mokyo tokyo-mod
        if not test -e $USER_THEME_DIR/$theme
          ln -s $THEMES/$theme $USER_THEME_DIR/$theme
        end
      end
    end

    function run_command
      eval $argv
    end

    function ui
      ensure_themes

      set ACTIONS \
        "JPG (tokyo-mod) :: $LUTGEN apply *.jpg --preserve -p tokyo-mod" \
        "PNG (tokyo-mod) :: $LUTGEN apply *.png --preserve -p tokyo-mod" \
        "ALL (tokyo-mod) :: $LUTGEN apply *.jpg *.png *.jpeg --preserve -p tokyo-mod" \
        "JPG (droxo-mokyo) :: $LUTGEN apply *.jpg --preserve -p droxo-mokyo" \
        "PNG (droxo-mokyo) :: $LUTGEN apply *.png --preserve -p droxo-mokyo" \
        "ALL (droxo-mokyo) :: $LUTGEN apply *.jpg *.png *.jpeg --preserve -p droxo-mokyo" \
        "Exit :: exit 0"

      set selected (printf "%s\n" $ACTIONS | \
        ${pkgs.fzf}/bin/fzf \
          --height=20 \
          --layout=reverse \
          --border=rounded \
          --prompt="LutUI ❯ " \
          --preview='echo {} | awk -F ":: " "{print \$2}"' \
          --preview-window=down:3:wrap)

      if test -z "$selected"
        exit 0
      end

      set command (echo $selected | awk -F ':: ' '{print $2}')
      run_command $command
    end

    ui
  ''
