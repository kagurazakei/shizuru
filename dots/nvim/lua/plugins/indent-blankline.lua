return {
  "indent-blankline.nvim",
  before = function() require("lz.n").trigger_load("rainbow-delimiters.nvim") end,
  event = { "BufReadPost", "BufNewFile" },
  after = function()
    local hooks = require("ibl.hooks")
    hooks.register(
      hooks.type.SCOPE_HIGHLIGHT,
      hooks.builtin.scope_highlight_from_extmark
    )
    require("ibl").setup({
      scope = {
        enabled = true,
        show_start = true,
        show_end = true,
        injected_languages = true,
        highlight = vim.g.rainbow_delimiters.highlight,
      },
      indent = {
        char = "┋",
      },
    })
  end,
}
