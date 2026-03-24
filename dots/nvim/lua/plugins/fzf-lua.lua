return {
  "fzf-lua",
  after = function()
    local ignore_patterns = require("ignore-patterns")
    require("fzf-lua").setup({
      files = { file_ignore_patterns = ignore_patterns },
    })
  end,
  cmd = "FzfLua",
  keys = {
    { "<leader>sb", "<cmd>FzfLua buffers<CR>", desc = "Search buffers" },
    { "<leader>sf", "<cmd>FzfLua files<CR>", desc = "Search files" },
    {
      "<leader>sn",
      function() require("fzf-lua").files({ cwd = vim.env.NEOVIM_CONFIG }) end,
      desc = "Search Neovim configuration",
    },
    { "<leader>sr", "<cmd>FzfLua resume<CR>", desc = "Resume last picker" },
  },
}
