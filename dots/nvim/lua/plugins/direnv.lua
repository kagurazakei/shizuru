return {
  "direnv.nvim",
  lazy = false,
  after = function()
    if vim.fn.executable("direnv") ~= 1 then
      -- skip loading this if direnv is not in path
      return
    end
    require("direnv").setup({
      bin = "direnv",
      autoload_direnv = true,

      -- Statusline integration
      statusline = {
        enabled = true,
        icon = "",
      },

      -- Keyboard mappings
      keybindings = {
        allow = "<Leader>Da",
        deny = "<Leader>Dd",
        reload = "<Leader>Dr",
        edit = "<Leader>De",
      },

      -- Notification settings
      notifications = {
        level = vim.log.levels.INFO,
        silent_autoload = true,
      },
    })
  end,
}
