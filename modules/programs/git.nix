{
  azalea.modules.git = {
    config,
    pkgs,
    ...
  }: let
    hanaKey = config.services.openssh.knownHosts.hana.publicKey;
    kaguraKey = config.services.openssh.knownHosts.kagura.publicKey;
    signKey =
      if config.networking.hostName == "hana"
      then hanaKey
      else if config.networking.hostName == "kagura"
      then kaguraKey
      else null;
  in {
    hj.rum.environment.hideWarning = true;
    hj.rum.programs.git = {
      enable = true;
      package = pkgs.stable.git;
      settings = {
        user = {
          name = "kagurazakei";
          email = "maotsugiri@gmail.com";
          signingKey = signKey;
        };
        column = {
          ui = "auto";
        };

        branch = {
          sort = "-committerdate";
        };

        tag = {
          sort = "version:refname";
        };

        init = {
          defaultBranch = "master";
        };

        rerere = {
          enabled = 1;
          autoupdate = 1;
        };

        diff = {
          algorithm = "histogram";
          colorMoved = "plain";
          renames = true;
        };

        difftool = {
          prompt = false;
        };

        push = {
          autoSetupRemote = true;
          followTags = true;
        };

        fetch = {
          prune = true;
          pruneTags = true;
          all = true;
        };

        rebase = {
          autoSquash = true;
          updateRefs = true;
        };

        color = {
          ui = "auto";
        };

        "color \"branch\"" = {
          current = "yellow bold";
          local = "green bold";
          remote = "cyan bold";
        };

        "color \"diff\"" = {
          meta = "yellow bold";
          frag = "magenta bold";
          old = "red bold";
          new = "green bold";
          whitespace = "red reverse";
        };

        "color \"status\"" = {
          added = "green bold";
          changed = "yellow bold";
          untracked = "red bold";
        };

        delta = {
          features = "catppuccin-mocha";
          "line-numbers" = false;
          dark = true;
        };

        trim = {
          bases = "master,main";
          protected = "*production";
        };

        "filter \"lfs\"" = {
          clean = "git-lfs clean -- %f";
          smudge = "git-lfs smudge -- %f";
          process = "git-lfs filter-process";
          required = true;
        };

        "delta \"catppuccin-mocha\"" = {
          "blame-palette" = "#1e1e2e #181825 #11111b #313244 #45475a";
          dark = true;
          "file-decoration-style" = "#6c7086";
          "file-style" = "#cdd6f4";
          "hunk-header-decoration-style" = "#6c7086 ul";
          "hunk-header-file-style" = "bold";
          "hunk-header-line-number-style" = "bold #a6adc8";
          "hunk-header-style" = "file line-number syntax";
          "line-numbers-left-style" = "#6c7086";
          "line-numbers-minus-style" = "bold #f38ba8";
          "line-numbers-plus-style" = "bold #a6e3a1";
          "line-numbers-right-style" = "#6c7086";
          "line-numbers-zero-style" = "#6c7086";
          "minus-emph-style" = "bold syntax #53394c";
          "minus-style" = "syntax #34293a";
          "plus-emph-style" = "bold syntax #404f4a";
          "plus-style" = "syntax #2c3239";
          "map-styles" = ''
            bold purple => syntax "#494060",
            bold blue => syntax "#384361",
            bold cyan => syntax "#384d5d",
            bold yellow => syntax "#544f4e"
          '';
          "syntax-theme" = "Catppuccin Mocha";
        };
      };
    };
  };
}
