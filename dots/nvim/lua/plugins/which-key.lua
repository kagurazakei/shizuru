return {
  {
    "which-key.nvim",
    event = "DeferredUIEnter",
    after = function() require("which-key").setup({ preset = "modern" }) end,
  },
  {
    "which-colorscheme.nvim",
    before = function() require("lz.n").trigger_load("which-key") end,
    after = function()
      require("which-colorscheme").setup({
        prefix = "<leader>C", -- The prefix to your keymap
        group_name = "Colorschemes", -- The prefix group in `which-key.nvim`
        include_builtin = false, -- Whether to include the built-in Neovim colorschemes
        -- NOTE: If `custom_groups` is empty this will be ignored
        custom_only = false, -- Whether to only map the colorschemes defined in `custom_groups`
        custom_groups = {}, -- Custom groups for colorschemes (see the `Custom Groups` section below)
        excluded = {}, -- List of colorscheme names/variants to ignore
        grouping = {
          labels = {}, -- The labels assigned to a given group (see the `Labeling` section below)
          uppercase_groups = false, -- Whether to use uppercase groups for keymaps
          random = false, -- Whether to randomize the mappings
          inverse = false, -- Whether to map your colorschemes from z-a (if random is `true`, this does nothing)
          current_first = true, -- Whether to put the current colorscheme in the first group
        },
      })
    end,
  },
}
