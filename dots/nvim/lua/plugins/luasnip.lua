return {
  "luasnip",
  build = "make install_jsregexp",
  after = function()
    local snippet_paths = vim.api.nvim_get_runtime_file("lua/snippets", true)
    require("luasnip.loaders.from_lua").lazy_load({ paths = snippet_paths })
  end,
  keys = {
    {
      "<C-h>",
      function() require("luasnip").jump(-1) end,
      mode = { "i", "s" },
      desc = "Jump to previous snippet placeholder",
    },
    {
      "<C-l>",
      function() require("luasnip").jump(1) end,
      mode = { "i", "s" },
      desc = "Jump to previous snippet placeholder",
    },
  },
}
