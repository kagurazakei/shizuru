return {
  {
    "ui",
  },
  {
    "base16-nvim",
    after = function()
      require("base16-colorscheme").with_config({
        telescope = true,
        indentblankline = true,
        notify = true,
        ts_rainbow = true,
        cmp = true,
        illuminate = true,
        dapui = true,
      })
    end,
  },
  {
    "rose-pine",
    colorscheme = {
      "rose-pine",
      "rose-pine-dawn",
      "rose-pine-main",
      "rose-pine-moon",
    },
    after = function()
      require("rose-pine").setup({
        variant = "auto", -- auto, main, moon, or dawn
        dark_variant = "main", -- main, moon, or dawn
        dim_inactive_windows = false,
        extend_background_behind_borders = true,

        enable = {
          terminal = true,
          legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
          migrations = true, -- Handle deprecated options automatically
        },
        styles = { bold = true, italic = true, transparency = false },

        highlight_groups = {
          -- leafy search
          CurSearch = { fg = "base", bg = "leaf", inherit = false },
          Search = { fg = "text", bg = "leaf", blend = 20, inherit = false },

          -- make blink transparent
          BlinkCmpDoc = { bg = "NONE" },
          BlinkCmpDocSeparator = { bg = "NONE" },
          BlinkCmpScrollBarGutter = { bg = "NONE" },
          -- here to let you know that I tried my fucking best to get rid of
          -- the transparency of whatever that shit is called but failed after
          -- a fuck tone of tries thank god devMode exists otherwise I would
          -- have kms'd
        },
      })
    end,
  },
  {
    "tokyonight.nvim",
    colorscheme = {
      "tokyonight",
      "tokyonight-night",
      "tokyonight-storm",
      "tokyonight-day",
      "tokyonight-moon",
    },
    after = function()
      require("tokyonight").setup({
        transparent = false,
        lualine_bold = true,
        styles = { sidebars = "transparent", floats = "transparent" },
        on_colors = function(colors) colors.bg_statusline = nil end,
        on_highlights = function(hl, c)
          hl.ColorColumn = { bg = c.none }
          hl.TabLineFill = { bg = c.none }
        end,
      })
    end,
  },
}
