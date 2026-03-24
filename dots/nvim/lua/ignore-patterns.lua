local dev_directories = { "^%.direnv$", "^%.git$" }

local languages = {
  godot = {
    "^server%.pipe$",
    "^%.godot",
    "%.gd%.uid$",
    "%.import$",
    "%.tmp$",
  },

  nix = { "^result" },
}

return vim
  .iter({ dev_directories, unpack(vim.tbl_values(languages)) })
  :flatten()
  :totable()
