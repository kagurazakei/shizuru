return {
  "nvim-colorizer.lua",
  after = function() require("colorizer").setup() end,
  keys = {

    { "<leader>C", "<cmd> ColorizerToggle<CR>", desc = "toggle Colorizer" },
  },
}
