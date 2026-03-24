require("tree-sitter").setup_buffer()
vim.lsp.enable("nixd")
vim.schedule(function() vim.lsp.inlay_hint.enable(true, { bufnr = 0 }) end)
return {
  settings = {
    ["nil"] = {
      nix = {
        flake = {
          autoArchive = true,
          autoEvalInputs = true,
        },
      },
    },
  },
}
