local map = vim.keymap.set
local defaults = function(desc)
  return { noremap = true, silent = true, desc = desc }
end
vim.g.mapleader = " "
vim.g.maplocalleader = " "

map(
  "n",
  "<leader>e",
  "<cmd>Yazi<cr>",
  { silent = true, desc = "Yazi Current Directory" }
)
map(
  "n",
  "<leader>E",
  "<cmd>Yazi toggle<cr>",
  { silent = true, desc = "Yazi Toggle" }
)
vim.keymap.set(
  "n",
  "<Esc>",
  "<cmd>nohlsearch<CR>",
  { desc = "Clear search highlights" }
)
vim.keymap.set(
  "t",
  "<Esc><Esc>",
  "<C-\\><C-n>",
  { desc = "Exit terminal mode" }
)

vim.keymap.set(
  "n",
  "<leader>q",
  vim.diagnostic.setloclist,
  { desc = "Open diagnostic quickfix list" }
)

vim.keymap.set(
  { "n", "v" },
  "<leader>y",
  "\"+y",
  { desc = "Yank to clipboard" }
)
vim.keymap.set(
  { "n", "v" },
  "<leader>Y",
  "\"+y$",
  { desc = "Yank to end of line to clipboard" }
)
vim.keymap.set(
  { "n", "v" },
  "<leader>p",
  "\"+p",
  { desc = "Paste from clipboard after cursor" }
)
vim.keymap.set(
  { "n", "v" },
  "<leader>P",
  "\"+P",
  { desc = "Paste from clipboard before cursor" }
)

vim.keymap.set(
  { "n", "v" },
  "<A-d>",
  "\"_d",
  { desc = "Delete without yanking" }
)
vim.keymap.set(
  { "n", "v" },
  "<A-c>",
  "\"_c",
  { desc = "Change without yanking" }
)
vim.keymap.set(
  { "n", "v" },
  "<A-D>",
  "\"_D",
  { desc = "Delete to end of line without yanking" }
)
vim.keymap.set(
  { "n", "v" },
  "<A-C>",
  "\"_C",
  { desc = "Change to end of line without yanking" }
)
vim.keymap.set(
  { "n", "v" },
  "<A-m>",
  "<cmd>lua MiniMap.toggle()<cr>",
  { desc = "Mini Map" }
)

map(
  { "v", "n" },
  "<Tab>",
  "<cmd>bnext<cr>",
  { silent = true, desc = "Next buffer " }
)
map(
  { "v", "n" },
  "<S-Tab>",
  "<cmd>bprevious<cr>",
  { silent = true, desc = "Previous buffer" }
)
map("n", "<leader>tw", "<C-W>p", { silent = true, desc = "Other Window" })
map("n", "<leader>td", "<C-W>c", { silent = true, desc = "Delete Window" })
map("n", "<leader>t-", "<C-W>s", { silent = true, desc = "Split Window Below" })
map("n", "<leader>t|", "<C-W>v", { silent = true, desc = "Split Window Right" })
-- map("n", "<leader>-", "<C-W>s", {silent = true, desc = "Split Window Below"})
map("n", "<leader>|", "<C-W>v", { silent = true, desc = "Split Window Right" })
-- Save file
map("n", "<leader>w", "<cmd>w<cr><esc>", { silent = true, desc = "Save file" })
-- Quit/Session
map("n", "<leader>qi", "<cmd>q<cr>!", { silent = true, desc = "Quit all" })
map(
  "n",
  "<leader>qq",
  "<cmd>w<cr>q",
  { silent = true, desc = "Force Write & Quit" }
)
map(
  "n",
  "<leader>qs",
  "function() lua require('persistence').load() end",
  { silent = true, desc = "Restore Session" }
)
map(
  "n",
  "<leader>ql",
  "function() lua require('persistence').load({ last = true })end",
  { silent = true, desc = "Restore Last Session" }
)

map(
  "n",
  "<leader>qd",
  "function() lua require('persistence').stop() end",
  { silent = true, desc = "Don't save current session" }
)

map(
  "v",
  "J",
  ":m '>+1<CR>gv=gv",
  { silent = true, desc = "Move up when line is highlighted" }
)
map(
  "v",
  "K",
  ":m '<-2<CR>gv=gv",
  { silent = true, desc = "Move down when line is highlighted" }
)
map("n", "J", "mzJ`z", {
  silent = true,
  desc = "Allow cursor to stay in the same place after appeding to current line",
})
map(
  "v",
  "<",
  "<gv",
  { silent = true, desc = "Indent while remaining in visual mode." }
)
map(
  "v",
  ">",
  ">gv",
  { silent = true, desc = "Indent while remaining in visual mode." }
)
map("n", "<C-d>", "<C-d>zz", {
  silent = true,
  desc = "Allow <C-d> and <C-u> to keep the cursor in the middle",
})
map(
  "n",
  "<C-u>",
  "<C-u>zz",
  { silent = true, desc = "Allow C-d and C-u to keep the cursor in the middle" }
)

-- Remap for dealing with word wrap and adding jumps to the jumplist.
map(
  "n",
  "j",
  [[(v:count > 1 ? 'm`' . v:count : 'g') . 'j']],
  { silent = true, expr = true }
)
map(
  "n",
  "k",
  [[(v:count > 1 ? 'm`' . v:count : 'g') . 'k']],
  { silent = true, expr = true }
)
map(
  "n",
  "n",
  "nzzzv",
  { silent = true, desc = "Allow search terms to stay in the middle" }
)
map(
  "n",
  "N",
  "Nzzzv",
  { silent = true, desc = "Allow search terms to stay in the middle" }
)

-- Paste stuff without saving the deleted word into the buffer

map(
  { "n", "v" },
  "<leader>p",
  [["+p]],
  { silent = true, desc = "Paste to System Clipboards" }
)
map(
  { "n", "v" },
  "<leader>P",
  [["+P]],
  { silent = true, desc = "Paste to System Clipboards" }
)

-- Copy stuff to system clipboard with <leader> + y or just y to have it just in vim
map(
  { "n", "v" },
  "<leader>y",
  [["+y]],
  { silent = true, desc = "Copy to System Clipboard" }
)
map(
  "n",
  "<leader>Y",
  [["+Y]],
  { silent = true, desc = "Copy to system clipboard" }
)

-- Delete to void register
map(
  { "n", "v" },
  "<leader>d",
  [["_d]],
  { silent = true, desc = "Delete to void register" }
)

-- <C-c> instead of pressing esc just because
map("i", "<C-c>", "<Esc>", { silent = true, desc = "Exit insert mode" })
map(
  "n",
  "<C-f>",
  "<cmd>silent !tmux neww tmux-sessionizer-script<CR>",
  { desc = "Switch between projects" }
)
