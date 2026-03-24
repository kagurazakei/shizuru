return {
  "cord.nvim",
  enabled = true,
  build = ":Cord update",
  after = function()
    require("cord").setup({
      display = {
        theme = "catppuccin",
        flavor = "dark",
      },
    })
  end,
}
