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
        hyprlang = { "hyprls" },
        kdl = { "kdlfmt" },
        fish = { "fish_indent" },
        c = { "clang-format" },
        typst = { "typstyle" },
        rust = { "rustfmt" },
        haskell = { "fourmolu" },
      },
    })
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

    vim.api.nvim_create_user_command("Format", function(args)
      local range = nil
      if args.count ~= -1 then
        local end_line =
          vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
          start = { args.line1, 0 },
          ["end"] = { args.line2, end_line:len() },
        }
      end
      require("conform").format({
        async = true,
        lsp_format = "fallback",
        range = range,
      })
    end, { range = true })
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
