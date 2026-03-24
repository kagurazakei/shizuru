vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function(args)
    if args.match:match("^%w%w+:[\\/][\\/]") then return end
    local file = vim.uv.fs_realpath(args.match) or args.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
  desc = "Automatically create directory when saving a file",
  group = vim.api.nvim_create_augroup(
    "heitor/auto_create_directory",
    { clear = true }
  ),
})

local cursorline_toggle =
  vim.api.nvim_create_augroup("heitor/cursorline_toggle", { clear = true })

vim.api.nvim_create_autocmd({ "BufLeave", "WinLeave" }, {
  callback = function() vim.wo.cursorline = false end,
  desc = "Disable cursorline when leaving window",
  group = cursorline_toggle,
})

vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
  callback = function() vim.wo.cursorline = true end,
  desc = "Enable cursorline when entering window",
  group = cursorline_toggle,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function() vim.hl.on_yank() end,
  desc = "Highlight when yanking text",
  group = vim.api.nvim_create_augroup(
    "heitor/highlight_yank",
    { clear = true }
  ),
})

local line_number_toggle =
  vim.api.nvim_create_augroup("heitor/line_number_toggle", { clear = true })

vim.api.nvim_create_autocmd(
  { "BufLeave", "CmdlineEnter", "FocusLost", "InsertEnter", "WinLeave" },
  {
    callback = function(args)
      if vim.wo.number then vim.wo.relativenumber = false end

      -- Redraw here to avoid having to first write something for the line numbers to update.
      if args.event == "CmdlineEnter" then
        if not vim.tbl_contains({ "@", "-" }, vim.v.event.cmdtype) then
          vim.cmd.redraw()
        end
      end
    end,
    desc = "Switch to absolute line numbers when in insert mode or unfocused",
    group = line_number_toggle,
  }
)

vim.api.nvim_create_autocmd(
  { "BufEnter", "CmdlineLeave", "FocusGained", "InsertLeave", "WinEnter" },
  {
    callback = function()
      if
        vim.wo.number and not vim.startswith(vim.api.nvim_get_mode().mode, "i")
      then
        vim.wo.relativenumber = true
      end
    end,
    desc = "Switch to relative line numbers when in normal mode and focused",
    group = line_number_toggle,
  }
)

vim.api.nvim_create_autocmd("VimResized", {
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
  desc = "Resize splits when Neovim is resized",
  group = vim.api.nvim_create_augroup("heitor/resize_splits", { clear = true }),
})
