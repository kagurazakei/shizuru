{ pkgs, ... }:
{
  config.vim = {
    repl = {
      conjure.enable = true;
    };
    spellcheck = {
      enable = true;
      programmingWordlist.enable = true;
      languages = [
        "en"
        "us"
      ];
    };
    clipboard = {
      enable = true;
      registers = "unnamedplus";
      providers.wl-copy.enable = true;
    };
    options = {
      shiftwidth = 2;
      conceallevel = 1;
      scrolloff = 1;
    };
    preventJunkFiles = true;
    searchCase = "smart";
    viAlias = true;
    vimAlias = true;
    undoFile = {
      enable = true;
    };
    debugMode = {
      enable = false;
      level = 16;
      logFile = "/tmp/nvim.log";
    };
    lsp = {
      enable = true;
      formatOnSave = false;
      lspkind.enable = false;
      lightbulb.enable = false;
      lspsaga.enable = false;
      servers.nil.settings.nil.nix.autoArchive = true;
      otter-nvim = {
        enable = true;
        setupOpts.buffers.write_to_disk = true;
      };
      trouble.enable = true;
      lspSignature.enable = false; # doesn't work with blink
      nvim-docs-view.enable = false; # lags *horribly* whenever l is pressed
    };

    debugger = {
      nvim-dap = {
        enable = true;
        ui.enable = true;
      };
    };

    languages = {
      enableFormat = true;
      enableTreesitter = true;
      enableExtraDiagnostics = true;
      nim.enable = true;
      nix.enable = true;
      markdown.enable = true;
      html.enable = true;
      css.enable = true;
      r = {
        enable = true;
        format.type = [ "styler" ];
      };
      sql.enable = true;
      haskell.enable = true;
      java.enable = false;
      ts = {
        enable = true;
        extraDiagnostics.enable = false;
      };
      svelte.enable = false;
      vala.enable = true;
      go.enable = true;
      elixir.enable = false;
      zig.enable = true;
      ocaml.enable = true;
      nu.enable = true;
      python = {
        enable = true;
        lsp.servers = [ "pyright" ];
      };
      dart.enable = false;
      lua.enable = true;
      bash.enable = true;
      tailwind.enable = false;
      typst.enable = true;
      julia.enable = true;
      clang = {
        enable = true;
        lsp.servers = [ "clangd" ];
      };

      rust = {
        enable = true;
        extensions.crates-nvim.enable = true;
      };
    };

    visuals = {
      nvim-web-devicons.enable = true;
      cellular-automaton.enable = true;
      fidget-nvim.enable = true;
      highlight-undo.enable = true;

      indent-blankline = {
        enable = true;
      };

      nvim-cursorline = {
        enable = true;
        setupOpts = {
          lineTimeout = 0;
        };
      };
    };

    statusline = {
      lualine = {
        enable = true;
        theme = "tokyonight";
      };
    };

    # luaConfigRC.basic = ''
    #   vim.g.nvim_ghost_use_script = 1
    #   vim.g.nvim_ghost_python_executable = '${ghosttext-dependencies}/bin/python'
    # '';

    theme = {
      enable = true;
      name = "tokyonight";
      style = "night";
      transparent = false;
    };

    autopairs.nvim-autopairs.enable = true;

    autocomplete.blink-cmp = {
      enable = true;
      friendly-snippets.enable = true;
      setupOpts = {
        signature.enabled = true;
        cmdline = {
          keymap.preset = "cmdline";
          completion.menu.auto_show = true;
        };
      };
    };
    snippets.luasnip.enable = true;

    filetree = {
      nvimTree = {
        enable = false;
      };
    };

    tabline = {
      nvimBufferline.enable = false;
    };

    treesitter = {
      context.enable = true;
      grammars = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        nu
        kdl
        rnoweb
        yaml
        markdown
        r
        hyprlang
        toml
      ];
    };

    binds = {
      whichKey.enable = true;
      cheatsheet.enable = true;
    };

    telescope.enable = true;

    git = {
      enable = true;
      gitsigns = {
        enable = true;
        codeActions.enable = false; # throws an annoying debug message
      };
    };

    minimap = {
      minimap-vim.enable = false;
      codewindow.enable = false; # lighter, faster, and uses lua for configuration
    };

    dashboard = {
      dashboard-nvim.enable = false;
      alpha.enable = true;
    };

    notify = {
      nvim-notify.enable = true;
    };

    projects = {
      project-nvim.enable = false;
    };

    utility = {
      undotree.enable = true;
      oil-nvim.enable = true;
      ccc.enable = false;
      vim-wakatime.enable = true;
      icon-picker.enable = true;
      surround.enable = true;
      yazi-nvim.enable = true;
      diffview-nvim.enable = true;
      motion = {
        hop.enable = false;
        leap = {
          enable = true;
          mappings = {
            leapForwardTo = "s";
            leapBackwardTo = "S";
          };
        };
        precognition.enable = false;
      };

      images = {
        image-nvim.enable = false;
        img-clip.enable = true;
      };
    };

    notes = {
      obsidian = {
        enable = true;
        setupOpts = {
          workspaces = [
            {
              name = "notes";
              path = "~/Documents/Nextcloud/Notes/markdown";
            }
          ];
          templates = {
            folder = "templates";
            date_format = "%Y-%m-%d-%a";
            time_format = "%H:%M";
          };
          opts.legacy_commands = false;
        };
      };
      neorg = {
        enable = true;
        setupOpts = {
          load = {
            "core.defaults" = { };
            "core.concealer" = { };
            "core.completion" = {
              config.engine = "nvim-cmp";
            };
            "core.export" = { };
            "core.summary" = { };
            "core.text-objects" = { };
            "core.dirman" = {
              config = {
                workspaces = {
                  notes = "~/Documents/neorg";
                };
              };
            };
          };
        };
      };
      orgmode.enable = false;
      mind-nvim.enable = false;
      todo-comments.enable = true;
    };

    terminal = {
      toggleterm = {
        enable = true;
        lazygit.enable = true;
      };
    };

    ui = {
      borders.enable = true;
      noice.enable = true;
      colorizer.enable = true;
      modes-nvim.enable = false; # the theme looks terrible with catppuccin
      illuminate.enable = true;
      # fastaction.enable = true;
      breadcrumbs = {
        enable = true;
        navbuddy.enable = true;
      };
      smartcolumn = {
        enable = true;
        setupOpts.custom_colorcolumn = {
          # this is a freeform module, it's `buftype = int;` for configuring column position
          nix = "110";
          ruby = "120";
          java = "130";
          # go = ["90 130"];
        };
      };
    };
    assistant = {
      avante-nvim = {
        enable = true;
        setupOpts = {
          provider = "ollama";
          providers = {
            openai = {
              endpoint = "https://api.openai.com/v1";
              model = "gpt-4o"; # your desired model (or use gpt-4o, etc.)
              timeout = 30000; # Timeout in milliseconds, increase this for reasoning models
              extra_request_body = {
                temperature = 0;
                max_completion_tokens = 8192; # Increase this to include reasoning tokens (for reasoning models)
                reasoning_effort = "medium"; # low|medium|high, only used for reasoning models
              };
            };
            groq = {
              __inherited_from = "openai";
              api_key_name = "groq";
              endpoint = "https://api.groq.com/openai/v1/";
              model = "llama-3.3-70b-versatile";
              # disable_tools = true;
              # extra_request_body = {
              #   temperature = 1;
              #   max_tokens = 32768; # remember to increase this value, otherwise it will stop generating halfway
              # };
            };
            ollama = {
              endpoint = "http://127.0.0.1:11434";
              model = "gpt-oss:latest";
            };
          };
        };
      };
      chatgpt.enable = false;
      codecompanion-nvim = {
        enable = false;
        setupOpts = {
          strategies = {
            chat = {
              adapter = "ollama";
            };
            inline = {
              adapter = "ollama";
            };
            cmd = {
              adapter = "ollama";
            };
          };
        };
      };
      copilot = {
        enable = false;
        cmp.enable = true;
      };
    };

    session = {
      nvim-session-manager.enable = false;
    };

    gestures = {
      gesture-nvim.enable = false;
    };

    comments = {
      comment-nvim.enable = true;
    };

    presence = {
      neocord.enable = true;
    };

    extraPlugins = {
      # ghost-nvim = {
      #   package = pkgs.vimUtils.buildVimPlugin {
      #     name = "ghost-nvim";
      #     src = pkgs.fetchFromGitHub {
      #       owner = "subnut";
      #       repo = "nvim-ghost.nvim";
      #       rev = "v0.5.4";
      #       hash = "sha256-XldDgPqVeIfUjaRLVUMp88eHBHLzoVgOmT3gupPs+ao=";
      #     };
      #     setup = ''
      #       require('ghost').setup(),
      #     '';
      #   };
      # };
      R-nvim = {
        package = pkgs.vimUtils.buildVimPlugin {
          name = "R-nvim";
          src = pkgs.fetchFromGitHub {
            owner = "R-nvim";
            repo = "R.nvim";
            rev = "68a033246a1863c8028f7d7aae91d65fc06058c8";
            hash = "sha256-GhgzmIylttMyaV/B2QjlRcdtHW/Epw8ghQtJbQEJZN0=";
          };
          doCheck = false;
          setup = ''
            require('r').setup(),
          '';
        };
      };
    };

    lazy.plugins = with pkgs.vimPlugins; {
      ${twilight-nvim.pname} = {
        lazy = true;
        package = twilight-nvim;
        setupModule = "twilight-nvim";
        cmd = [ "Twilight" ];
        keys = [
          {
            key = "<leader>ut";
            mode = "n";
            action = ":Twilight<CR>";
            silent = true;
            desc = "Toggle Twilight";
          }
        ];
      };
      ${zen-mode-nvim.pname} = {
        lazy = true;
        package = zen-mode-nvim;
        setupModule = "zen-mode-nvim";
        cmd = [ "ZenMode" ];
        keys = [
          {
            key = "<leader>uz";
            mode = "n";
            action = ":ZenMode<CR>";
            silent = true;
            desc = "Toggle ZenMode";
          }
        ];
      };
      ${eyeliner-nvim.pname} = {
        package = eyeliner-nvim;
        event = [ "BufEnter" ];
      };
      ${quarto-nvim.pname} = {
        lazy = true;
        cmd = "QuartoPreview";
        package = quarto-nvim;
      };
      ${lazygit-nvim.pname} = {
        lazy = true;
        cmd = [
          "LazyGit"
          "LazyGitConfig"
          "LazyGitCurrentFile"
          "LazyGitFilter"
          "LazyGitFilterCurrentFile"
        ];
        package = lazygit-nvim;
        setupOpts = {
          open_cmd = "zen %s";
        };
      };
      ${typst-preview-nvim.pname} = {
        lazy = true;
        cmd = "TypstPreview";
        package = typst-preview-nvim;
        setupOpts = {
          open_cmd = "zen %s";
        };
      };
      ${boole-nvim.pname} = {
        lazy = true;
        event = [ "BufEnter" ];
        package = boole-nvim;
        setupModule = "boole";
        setupOpts = {
          mappings = {
            increment = "<c-a>";
            decrement = "<c-x>";
          };
          additions = [
            [
              "Foo"
              "Bar"
            ]
            [
              "tic"
              "tac"
              "toe"
            ]
          ];
          allow_caps_additions = [
            [
              "enable"
              "disable"
            ]
          ];
        };
      };
      ${harpoon2.pname} = {
        lazy = true;
        cmd = "TypstPreview";
        package = harpoon2;
        keys = [
          {
            key = "<leader>ad";
            mode = "n";
            action = '':lua require("harpoon"):list():add()<CR>'';
            silent = true;
            desc = "Harpoon add";
          }
          {
            key = "<leader>as";
            mode = "n";
            action = '':lua require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())<CR>'';
            silent = true;
            desc = "Harpoon switch";
          }
        ];
      };
    };
    keymaps = [
      {
        key = "<esc>";
        mode = "n";
        action = ":noh<CR>";
        silent = true;
        desc = "removes search highlight when pressing esc";
      }
      {
        key = "<leader><leader>";
        mode = "n";
        action = ":Telescope find_files<CR>";
        silent = true;
        desc = "Look for Files";
      }
      {
        key = "-";
        action = ":Oil<CR>";
        mode = "n";
        silent = true;
        desc = "enable Oil";
      }
      {
        key = "<F5>";
        action = ":UndotreeToggle<CR>";
        mode = "n";
        silent = true;
        desc = "Toggle Undotree";
      }
      {
        key = "j";
        action = "gj";
        mode = [
          "n"
          "x"
          "v"
        ];
        silent = true;
        desc = "Toggle Undotree";
      }
      {
        key = "k";
        action = "gk";
        mode = [
          "n"
          "x"
          "v"
        ];
        silent = true;
        desc = "Toggle Undotree";
      }
      {
        key = "<leader>lc";
        mode = "n";
        lua = true;
        action = /* lua */ ''
          function()
            require('conform').format({
              lsp_format = "fallback"
            })
          end
        '';
        desc = "format using Conform";
      }
    ];
  };
}
