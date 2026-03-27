vim.o.breakindent = true
vim.o.confirm = true
vim.o.clipboard = "unnamedplus"
vim.o.cursorline = true
vim.o.expandtab = true
vim.opt.fillchars =
  { fold = " ", foldclose = "", foldopen = "", foldsep = " " }
vim.o.foldcolumn = "1"
vim.o.foldlevelstart = 99
vim.o.guicursor = "n-v-c-sm:block,i-ci-ve:ver25"
vim.o.ignorecase = true
vim.o.inccommand = "split"
vim.o.laststatus = 3
vim.o.linebreak = true
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.o.mouse = "a"
vim.o.number = true
vim.o.pumblend = 10
vim.o.pumheight = 10
vim.o.relativenumber = true
vim.o.ruler = false
vim.o.scrolloff = 4
vim.o.shiftround = true
vim.o.shiftwidth = 2
vim.o.showmode = false
vim.o.sidescrolloff = 8
vim.o.signcolumn = "yes"
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.smoothscroll = true
vim.o.softtabstop = 2
vim.o.splitbelow = true
vim.o.splitkeep = "screen"
vim.o.splitright = true
vim.o.tabstop = 2
vim.o.termguicolors = true
vim.o.timeoutlen = 300
vim.o.title = true
vim.o.undofile = true
vim.o.updatetime = 200
vim.o.winborder = "rounded"

-- We have to set these both manually because of the way mnw handles PATH
vim.o.grepformat = "%f:%l:%c:%m"
vim.o.grepprg = "rg --vimgrep"

if vim.fn.has("nvim-0.12") == 1 then vim.o.pumborder = "rounded" end
if not vim.g.neovide then return end

local font_size = 15
vim.o.guifont = "JetBrainsMono Nerd Font" .. ":h" .. font_size
vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_underline_automatic_scaling = true -- Noticeable for font sizes above 15
