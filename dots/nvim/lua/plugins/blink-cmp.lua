return {
  "blink.cmp",
  before = function()
    require("lz.n").trigger_load("friendly-snippet")
    require("lz.n").trigger_load("luasnip")
    require("lz.n").trigger_load("colorful-menu")
  end,
  after = function()
    require("blink.cmp").setup({
      snippets = { preset = "luasnip" },
      keymap = {
        preset = "enter", -- before you pull out your hair
        -- I have capslock + hjkl translated to the arrow keys
        -- see keyd.nix for more info
        ["<C-n>"] = { "select_prev", "fallback" },
        ["<C-p>"] = { "select_next", "fallback" },
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
      },
      cmdline = {
        enabled = true,
        keymap = {
          preset = "cmdline",
          ["<Tab>"] = { "select_next", "fallback" },
          ["<S-Tab>"] = { "select_prev", "fallback" },
          ["CR"] = { "accept", "fallback" },
        },
        completion = {
          list = {
            selection = {
              preselect = false,
              auto_insert = true,
            },
          },

          menu = { auto_show = true },
        },
      },
      completion = {
        list = {
          selection = { preselect = true, auto_insert = true },
          max_items = 10,
        },
        accept = {
          auto_brackets = {
            enabled = true,
          },
        },
        menu = {
          draw = {
            components = {
              label = {
                text = function(ctx)
                  return require("colorful-menu").blink_components_text(ctx)
                end,
                highlight = function(ctx)
                  return require("colorful-menu").blink_components_highlight(
                    ctx
                  )
                end,
              },
              kind_icon = {
                text = function(ctx)
                  local kind_icon, _, _ =
                    require("mini.icons").get("lsp", ctx.kind)
                  return kind_icon
                end,

                highlight = function(ctx)
                  local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                  return hl
                end,
              },

              kind = {
                highlight = function(ctx)
                  local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                  return hl
                end,
              },
            },
          },
        },
      },
      sources = {
        -- add lazydev to your completion providers
        default = { "lazydev", "lsp", "path", "snippets", "buffer" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
        },
      },
      signature = { enabled = true },
    })
  end,
  event = "InsertEnter",
}
