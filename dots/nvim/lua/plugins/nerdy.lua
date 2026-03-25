return {
  "nerdy.nvim",
  lazy = false,
  cmd = "Nerdy",
  before = function() require("lz.n").trigger_load("snacks.nvim") end,
  after = function()
    require("nerdy").setup({
      max_recents = 30, -- Configure recent icons limit
      copy_to_clipboard = true, -- Copy glyph to clipboard instead of inserting
      copy_register = "+", -- Register to use for copying (if `copy_to_clipboard` is true)
      keys = {
        { "<leader>in", ":Nerdy list<CR>", desc = "Browse nerd icons" },
        {
          "<leader>iN",
          ":Nerdy recents<CR>",
          desc = "Browse recent nerd icons",
        },
      },
    })
  end,
}
