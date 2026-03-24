return {
  "conform.nvim",
  after = function()
    require("conform").setup({
      format_on_save = { timeout_ms = 500 },
      formatters_by_ft = {
        gdscript = { "gdformat" },
        lua = { "stylua" },
        nix = { "nixfmt" },
        toml = { "taplo" },
        hyprls = { "hyprls" },
        kdl = { "kdlfmt" },
        fish = { "fish_indent" },
      },
    })
  end,
  cmd = "ConformInfo",
  event = "BufWritePre",
  keys = {
    {
      "<leader>f",
      function() require("conform").format({ timeout_ms = 500 }) end,
      mode = { "n", "x" },
      desc = "Format buffer",
    },
  },
}
