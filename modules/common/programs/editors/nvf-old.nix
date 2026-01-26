{ pkgs, ... }:
{
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        preventJunkFiles = true; # stop those weird ~ files from appearing
        undoFile.enable = true; # multi-session undo
        enableLuaLoader = true;
        clipboard = {
          enable = true;
          providers.wl-copy.enable = true;
          registers = "unnamedplus";
        };
        viAlias = false;
        vimAlias = true;
        luaConfigRC = {
          basic = ''
            -- Restore terminal cursor to vertical beam on exit
            vim.api.nvim_create_autocmd("ExitPre", {
              group = vim.api.nvim_create_augroup("Exit", { clear = true }),
              command = "set guicursor=a:ver1",
              desc = "Set cursor back to beam when leaving Neovim.",
            })

            -- Remove "disable mouse" entries from the context menu
            vim.api.nvim_create_autocmd("VimEnter", {
              callback = function()
                vim.cmd("aunmenu PopUp.How-to\\ disable\\ mouse")
                vim.cmd("aunmenu PopUp.-1-")
              end,
              desc = "Remove 'disable mouse' entries from context menu",
                    })
          '';
        };

        debugger = {
          nvim-dap = {
            enable = true;
            ui.enable = true;
          };
        };

        lsp.enable = true;
        treesitter.enable = true;

        languages = {
          enableFormat = true;
          enableTreesitter = true;
          enableExtraDiagnostics = true;

          nix = {
            enable = true;
            treesitter.enable = true;
          };
          clang.enable = true;

          sql = {
            enable = true;
            treesitter.enable = true;
          };
          markdown = {
            enable = true;
            treesitter.enable = true;
          };
          html = {
            enable = true;
            treesitter.enable = true;
          };
          lua = {
            enable = true;
            treesitter.enable = true;
          };
          php = {
            enable = true;
            treesitter.enable = true;
          };
          ts = {
            enable = true;
            treesitter.enable = true;
          };
          python = {
            enable = true;
            treesitter.enable = true;
          };
          qml.enable = true;

          bash = {
            enable = true;
            treesitter.enable = true;
          };
          css = {
            enable = true;
            treesitter.enable = true;
          };
          kotlin = {
            enable = true;
            treesitter.enable = true;
          };
          tailwind = {
            enable = true;
          };
          terraform = {
            enable = true;
            treesitter.enable = true;
          };
          yaml = {
            enable = true;
            treesitter.enable = true;
          };
          typst = {
            enable = true;
            treesitter.enable = true;
          };
        };

        notes = {
          todo-comments.enable = true;
        };

        visuals = {
          nvim-web-devicons.enable = true;
          nvim-cursorline.enable = true;
          fidget-nvim.enable = true;
          highlight-undo.enable = true;
          indent-blankline.enable = true;
          cellular-automaton.enable = true;
          cinnamon-nvim.enable = true;
          nvim-scrollbar.enable = true;
          rainbow-delimiters.enable = true;
          tiny-devicons-auto-colors.enable = true;
        };

        statusline = {
          lualine = {
            enable = true;
            theme = "catppuccin";
          };
        };

        theme = {
          enable = true;
          name = "catppuccin";
          style = "mocha";
          transparent = true;
        };

        autopairs.nvim-autopairs.enable = true;
        autocomplete.blink-cmp = {
          enable = true;
          friendly-snippets.enable = true;
        };

        filetree = {
          neo-tree = {
            enable = true;
          };
        };

        tabline = {
          nvimBufferline.enable = true;
        };

        binds = {
          whichKey.enable = true;
          cheatsheet.enable = true;
        };

        telescope.enable = true;

        git = {
          enable = true;
          gitsigns.enable = true;
          gitsigns.codeActions.enable = false; # throws an annoying debug message
        };

        dashboard = {
          alpha.enable = true;
        };

        utility = {
          ccc.enable = true;
          direnv.enable = true;
          mkdir.enable = true;
          multicursors.enable = true;
          new-file-template = {
            enable = true;
          };

          nvim-biscuits.enable = true;
          oil-nvim.enable = true;
          outline.aerial-nvim.enable = true;
          preview.glow.enable = true;
          smart-splits.enable = true;
          snacks-nvim = {
            enable = true;
          };
          surround.enable = true;
          undotree.enable = true;
          vim-wakatime.enable = true;
          icon-picker.enable = true;
          diffview-nvim.enable = true;
          motion = {
            leap.enable = true;
          };
          yazi-nvim.enable = true;
        };

        terminal = {
          toggleterm = {
            enable = true;
            lazygit.enable = true;
          };
        };

        ui = {
          noice.enable = true;
          colorizer.enable = true;
          illuminate.enable = true;
          breadcrumbs = {
            enable = true;
            navbuddy.enable = true;
          };
          fastaction.enable = true;
        };

        assistant = {
          copilot = {
            enable = true;
            cmp.enable = true;
            setupOpts = {
              panel.enabled = true;
              suggestion.enabled = true;
            };
            mappings = {
              panel = {
                open = "cpn";
              };
              suggestion = {
                accept = "cpc";
              };
            };

          };
        };

        comments = {
          comment-nvim.enable = true;
        };

        presence = {
          neocord.enable = true;
        };
      };
    };
  };
  # make indents normal lmfao
  hj = {
    files.".editorconfig".source = (pkgs.formats.ini { }).generate ".editorconfig" {
      "*" = {
        charset = "utf-8";
        end_of_line = "lf";
        indent_size = 2;
        indent_style = "space";
        insert_final_newline = true;
        max_line_width = 80;
        trim_trailing_whitespace = true;
      };
    };
  };
}
