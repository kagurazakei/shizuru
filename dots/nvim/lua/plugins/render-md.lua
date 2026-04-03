return {
  "render-markdown.nvim",
  before = function()
    require("lz.n").trigger_load("nvim-treesitter")
    require("lz.n").trigger_load("mini.nvim")
  end,
  after = function()
    require("render-markdown").setup({
      file_types = { "markdown", "vimwiki" },
    })
  end,
}
