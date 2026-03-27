return {
  "telescope.nvim",
  before = function() require("lz.n").trigger_load("telescope-fzf-native.nvim") end,
  after = function()
    require("telescope").setup({
      defaults = {
        mappings = {
          i = {
            ["<C-h>"] = "which_key",
          },
        },
      },
      pickers = {
        find_files = {
          theme = "dropdown",
        },
      },
      extension = {
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        },
      },
    })
  end,
}
