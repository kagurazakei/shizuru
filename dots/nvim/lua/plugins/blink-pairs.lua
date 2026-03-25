return {
  "blink.pairs",
  after = function()
    require("blink.pairs").setup({
      mappings = {
        enabled = true,
        cmdline = true,
        disabled_filetypes = {},
        wrap = {
          ["<C-b>"] = "motion",
          ["<C-S-b>"] = "motion_reverse",
        },
        pairs = {},
      },
      highlights = {
        enabled = true,
        cmdline = true,
        groups = { "BlinkPairsOrange", "BlinkPairsPurple", "BlinkPairsBlue" },
        unmatched_group = "BlinkPairsUnmatched",
        matchparen = {
          enabled = true,
          cmdline = false,
          include_surrounding = false,
          group = "BlinkPairsMatchParen",
          priority = 250,
        },
      },
      debug = false,
    })
  end,
}
