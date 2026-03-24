-- Hyprlang LSP
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*.hl", "hypr*.conf" },
  callback = function(event)
    print(string.format("starting hyprls for %s", vim.inspect(event)))
    vim.lsp.start({
      name = "hyprlang",
      cmd = { "hyprls" },
      root_dir = vim.fn.getcwd(),
      settings = {
        hyprls = {
          preferIgnoreFile = true, -- set to false to prefer `hyprls.ignore`
          ignore = { "hyprlock.conf", "hypridle.conf" },
        },
      },
    })
  end,
})
vim.filetype.add({ pattern = { [".*/hypr.*\\.conf"] = "hyprlang" } })
local servers = {}
local config_files = vim.api.nvim_get_runtime_file("lsp/*.lua", true)

for _, config_file in ipairs(config_files) do
  local name = config_file:match("([^/]*)%.lua$")

  if name and (name:len() > 0) then table.insert(servers, name) end
end
vim.lsp.enable(servers)
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if
      client
      and client:supports_method(
        vim.lsp.protocol.Methods.textDocument_documentHighlight,
        bufnr
      )
    then
      local highlight_augroup =
        vim.api.nvim_create_augroup("zakei/lsp_highlight", { clear = false })

      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = bufnr,
        callback = vim.lsp.buf.document_highlight,
        group = highlight_augroup,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = bufnr,
        callback = vim.lsp.buf.clear_references,
        group = highlight_augroup,
      })

      vim.api.nvim_create_autocmd("LspDetach", {
        callback = function(detach_args)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({
            group = "zakei/lsp_highlight",
            buffer = detach_args.buf,
          })
        end,
        group = vim.api.nvim_create_augroup(
          "zakei/lsp_detach",
          { clear = true }
        ),
      })
    end
  end,
  group = vim.api.nvim_create_augroup("zakei/lsp_attach", { clear = true }),
})
