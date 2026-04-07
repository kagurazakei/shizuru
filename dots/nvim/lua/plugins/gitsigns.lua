return {
  "gitsigns.nvim",
  event = "BufAdd",
  after = function()
    require("gitsigns").setup({
      signs = {
        add = { text = "┃" },
        change = { text = "┃" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      signs_staged = {
        add = { text = "┃" },
        change = { text = "┃" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      signs_staged_enable = true,
      signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
      numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
      linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
      watch_gitdir = {
        follow_files = true,
      },
      auto_attach = true,
      attach_to_untracked = true,
      current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 100,
        ignore_whitespace = true,
        virt_text_priority = 100,
        use_focus = true,
      },
      current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
      blame_formatter = nil, -- Use default
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil, -- Use default
      max_file_length = 40000, -- Disable if file is longer than this (in lines)
      preview_config = {
        -- Options passed to nvim_open_win
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
      on_attach = function(bufnr)
        local gitsigns = require("gitsigns")

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]h", bang = true })
          else
            gitsigns.nav_hunk("next")
          end
        end, { desc = "Gitsigns: next hunk" })

        map("n", "[h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[h", bang = true })
          else
            gitsigns.nav_hunk("prev")
          end
        end, { desc = "Gitsigns: prev hunk" })

        -- Actions
        map(
          "n",
          "<leader>hs",
          gitsigns.stage_hunk,
          { desc = "Gitsigns: stage hunk" }
        )
        map(
          "n",
          "<leader>hu",
          gitsigns.undo_stage_hunk,
          { desc = "Gitsigns: unstage hunk" }
        )
        map(
          "n",
          "<leader>hr",
          gitsigns.reset_hunk,
          { desc = "Gitsigns: reset hunk" }
        )

        map(
          "v",
          "<leader>hs",
          function() gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end
        )
        map(
          "v",
          "<leader>hu",
          function()
            gitsigns.undo_stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end
        )
        map(
          "v",
          "<leader>hr",
          function() gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end
        )

        map(
          "n",
          "<leader>hS",
          gitsigns.stage_buffer,
          { desc = "Gitsigns: stage Buffer" }
        )
        map(
          "n",
          "<leader>hR",
          gitsigns.reset_buffer,
          { desc = "Gitsigns: reset Buffer" }
        )

        -- diffs
        map(
          "n",
          "<leader>hp",
          gitsigns.preview_hunk,
          { desc = "Gitsigns: preview hunk" }
        )
        map(
          "n",
          "<leader>hi",
          gitsigns.preview_hunk_inline,
          { desc = "Gitsigns: inline hunk" }
        )
      end,
    })
  end,
}
