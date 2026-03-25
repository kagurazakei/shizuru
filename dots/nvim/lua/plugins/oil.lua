return {
  "oil.nvim",
  after = function()
    require("oil").setup({
      default_file_explorer = true,
      columns = {
        "icon",
      },
      buf_options = {
        buflisted = false,
        bufhidden = "hide",
      },
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,

      view_options = {
        -- Show files and directories that start with "."
        show_hidden = true,
        is_hidden_file = function(name, bufnr)
          local m = name:match("^%.")
          return m ~= nil
        end,
        is_always_hidden = function(name, bufnr) return false end,
        natural_order = "fast",
        case_insensitive = false,
        sort = {
          { "type", "asc" },
          { "name", "asc" },
        },
        highlight_filename = function(
          entry,
          is_hidden,
          is_link_target,
          is_link_orphan
        )
          return nil
        end,
      },
      git = {
        -- Return true to automatically git add/mv/rm files
        add = function(path) return false end,
        mv = function(src_path, dest_path) return false end,
        rm = function(path) return false end,
      },
      -- Configuration for the floating window in oil.open_float
      float = {
        -- Padding around the floating window
        padding = 10,
        max_width = 50,
        max_height = 70,
        border = "rounded",
        win_options = {
          winblend = 30,
        },
        get_win_title = nil,
        preview_split = "auto",
        override = function(conf) return conf end,
      },
      confirmation = {
        max_width = 0.5,
        min_width = { 40, 0.4 },
        width = nil,
        max_height = 0.9,
        min_height = { 10, 0.9 },
        height = nil,
        border = nil,
        win_options = {
          winblend = 0,
        },
      },
      progress = {
        max_width = 0.9,
        min_width = { 40, 0.1 },
        width = nil,
        max_height = { 10, 0.9 },
        min_height = { 5, 0.1 },
        height = nil,
        border = "rounded",
        minimized_border = "none",
        win_options = {
          winblend = 0,
        },
      },
      -- Configuration for the floating SSH window
      ssh = {
        border = nil,
      },
      keymaps_help = {
        border = nil,
      },
      preview_win = {
        update_on_cursor_moved = true,
        preview_method = "fast_scratch",
        disable_preview = function(filename) return false end,
        win_options = {},
        max_width = 40,
        min_width = 40,
        width = nil,
        max_height = 0.9,
        min_height = { 10, 1.0 },
        border = "rounded",
      },
      win_options = {
        wrap = false,
        signcolumn = "no",
        cursorcolumn = false,
        foldcolumn = "0",
        spell = false,
        list = false,
        conceallevel = 3,
        concealcursor = "nvic",
      },
      constrain_cursor = "editable",
      keymaps = {

        ["<C-h>"] = "actions.parent",
        ["<C-l>"] = {
          "actions.select",
          opts = {
            -- Added in my personal fork (will upstream at some point)
            confirm = false,
          },
        },

        -- TODO: enable again when my intuition is fixed
        H = false,
        J = false,
        K = false,
        L = false,
        ["<C-j>"] = false,
        ["<C-k>"] = false,
        ["<C-c"] = "actions.close",
        -- Print path to current entry
        ["g~"] = function()
          local dir = oil.get_current_dir()
          local entry = oil.get_cursor_entry()
          if entry == nil then return end
          vim.print(dir .. entry.name)
        end,
        ["<C-f>"] = {
          function() search_first_char(false, true) end,
          mode = "n",
        },
        ["<C-;>"] = {
          function() search_first_char(true, true) end,
          mode = "n",
        },
        ["<C-,>"] = {
          function() search_first_char(true, false) end,
          mode = "n",
        },

        ["<CR>"] = false,
        ["<Esc>"] = {
          ":bd<CR>",
          mode = "n",
          silent = true,
        },
        ["<Tab>"] = "actions.preview",
        ["gs"] = {
          callback = function()
            sort_by_recent = not sort_by_recent
            if sort_by_recent then
              oil.set_sort({ { "mtime", "desc" } })
              oil.set_columns({
                { "mtime", highlight = "NonText", format = "%b %d" },
                { "icon" },
              })
            else
              oil.set_sort({
                { "type", "asc" },
                { "name", "asc" },
              })
              oil.set_columns({ "icon" })
            end
          end,
          nowait = true, -- Override the existing `gs` bind
        },

        ["<C-a>"] = add_to_qflist,
        ["<leader>s"] = function()
          fzf_lua.live_grep({
            cwd = oil.get_current_dir(),
            cwd_prompt = true,
            actions = {
              ["default"] = function(selected, opts)
                oil.close()
                fzf_lua.actions.file_edit(selected, opts)
              end,
            },
          })
        end,
      },
    })

    vim.keymap.set(
      "n",
      "-",
      "<cmd>Oil --float<CR>",
      { desc = "Open parent directory" }
    )
    vim.keymap.set("n", "=", "<cmd>Oil<CR>", { desc = "Open parent directory" })
    vim.api.nvim_create_autocmd("User", {
      pattern = "OilActionsPost",
      callback = function(event)
        if event.data.actions[1].type == "move" then
          Snacks.rename.on_rename_file(
            event.data.actions[1].src_url,
            event.data.actions[1].dest_url
          )
        end
      end,
    })
  end,
}
