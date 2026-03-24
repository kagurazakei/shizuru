---@meta

---@class TSSetupOpts
---@field highlight? boolean Enable tree-sitter highlighting (Default: true)
---@field fold? boolean Enable tree-sitter-based folding (Default: true)
---@field indent? boolean Enable tree-sitter-based indentation (Default: true)

local M = {}

---Configures Tree-sitter features for the current buffer.
---Defaults to enabling all features if no overrides are provided.
---@param opts? TSSetupOpts Configuration overrides.
function M.setup_buffer(opts)
  ---@type table<string, boolean>
  local defaults = {
    highlight = true,
    fold = true,
    indent = true,
  }

  local settings = vim.tbl_extend("force", defaults, opts or {})

  if not vim.api.nvim_buf_is_valid(0) then return end

  if settings.highlight then vim.treesitter.start() end

  if settings.fold then
    vim.wo[0][0].foldmethod = "expr"
    vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
  end

  if settings.indent then
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end
end

return M
