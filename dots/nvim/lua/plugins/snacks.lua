return {
  { "ascii.nvim", enabled = true, event = "DeferredUIEnter" },
  {
    "snacks.nvim",
    event = "DeferredUIEnter",
    after = function()
      require("snacks").setup({
        quickfile = { enabled = true },
        bigfile = { enabled = true },
        words = { enabled = true },
        scope = { enabled = true },
        input = { enabled = true },
        gh = { enable = true },
        gitbrowse = { enabled = true },
        explorer = {
          enabled = true,
          replace_netrw = true,
          trash = true,
        },
        indent = {
          enabled = true,
          char = "┋",
          animate = {
            enabled = true,
          },
        },
        image = { enabled = true },
        picker = { enabled = true },
        terminal = {
          enabled = true,
          win = {
            style = "float",
            border = "rounded",
            width = math.floor(vim.o.columns * 0.8),
            height = math.floor(vim.o.lines * 0.8),
          },
        },
        scroll = {
          enabled = true,
        },
        lazygit = {
          enabled = true,
        },
        statuscolumn = { enabled = true },
        dashboard = {
          row = nil,
          col = nil,
          width = 60,
          -- Defaults to a picker that supports `fzf-luabigfile `telescope.nvim` and `mini.pick`
          ---@type fun(cmd:string, opts:table)|nil
          pick = nil,

          -- Used by the `keys` section to show keymaps.
          -- Set your custom keymaps here.
          -- When using a function, the `items` argument are the default keymaps.
          ---@type snacks.dashboard.Item[]
          preset = {
            keys = {
              {
                icon = " ",
                key = "f",
                desc = "Find File",
                action = ":lua Snacks.dashboard.pick('files')",
              },
              {
                icon = " ",
                key = "n",
                desc = "New File",
                action = ":ene | startinsert",
              },
              {
                icon = " ",
                key = "g",
                desc = "Find Text",
                action = ":lua Snacks.dashboard.pick('live_grep')",
              },
              {
                icon = " ",
                key = "r",
                desc = "Recent Files",
                action = ":lua Snacks.dashboard.pick('oldfiles')",
              },
              {
                icon = " ",
                key = "c",
                desc = "LazyGit",
                action = ":lua Snacks.lazygit.open()",
              },
              {
                icon = " ",
                key = "s",
                desc = "Restore Session",
                section = "session",
              },
              { icon = " ", key = "q", desc = "Quit", action = ":qa" },
            },
            header = [[
                                              
       ████ ██████           █████      ██
      ███████████             █████ 
      █████████ ███████████████████ ███   ███████████
     █████████  ███    █████████████ █████ ██████████████
    █████████ ██████████ █████████ █████ █████ ████ █████
  ███████████ ███    ███ █████████ █████ █████ ████ █████
 ██████  █████████████████████ ████ █████ █████ ████ ██████
          ]],
          },

          -- item field formatters
          formats = {
            icon = function(item)
              if
                item.file and item.icon == "file" or item.icon == "directory"
              then
                return require("snacks").dashboard.icon(item.file, item.icon)
              end
              return { item.icon, width = 2, hl = "icon" }
            end,
            footer = { "%s", align = "center" },
            header = { "%s", align = "center" },
            file = function(item, ctx)
              local fname = vim.fn.fnamemodify(item.file, ":~")
              fname = ctx.width
                  and #fname > ctx.width
                  and vim.fn.pathshorten(fname)
                or fname
              if #fname > ctx.width then
                local dir = vim.fn.fnamemodify(fname, ":h")
                local file = vim.fn.fnamemodify(fname, ":t")
                if dir and file then
                  file = file:sub(-(ctx.width - #dir - 2))
                  fname = dir .. "/…" .. file
                end
              end
              local dir, file = fname:match("^(.*)/(.+)$")
              return dir
                  and { { dir .. "/", hl = "dir" }, { file, hl = "file" } }
                or { { fname, hl = "file" } }
            end,
          },

          sections = {
            {
              section = "terminal",
              cmd = "{cat ~/tmp/nv.txt; echo \"                                           "
                .. vim.version().major
                .. "."
                .. vim.version().minor
                .. "."
                .. vim.version().patch
                .. "\"} | { command -v lolcat >/dev/null && lolcat || cat; }",
              align = "center",
              padding = 0,
            },
            {
              pane = 2,
              section = "terminal",
              cmd = "colorscript -e square",
              height = 5,
              padding = 1,
            },
            {
              pane = 2,
              icon = " ",
              desc = "Browse Repo",
              padding = 1,
              key = "b",
              action = function() Snacks.gitbrowse() end,
            },
            function()
              local in_git = Snacks.git.get_root() ~= nil
              local cmds = {
                {
                  title = "Notifications",
                  cmd = "gh notify -s -a -n5",
                  action = function()
                    vim.ui.open("https://github.com/notifications")
                  end,
                  key = "n",
                  icon = " ",
                  height = 5,
                  enabled = true,
                },
                {
                  icon = " ",
                  title = "Git Status",
                  cmd = "git --no-pager diff --stat -B -M -C",
                  height = 10,
                },
              }
              return vim.tbl_map(
                function(cmd)
                  return vim.tbl_extend("force", {
                    pane = 2,
                    section = "terminal",
                    enabled = in_git,
                    padding = 1,
                    ttl = 5 * 60,
                    indent = 3,
                  }, cmd)
                end,
                cmds
              )
            end,
            { section = "keys", gap = 1, padding = 1 },
          },
        },
      })
    end,
    wk = {
      { "<leader>d", desc = "Dashboard" },
    },
    keys = {
      {
        "<leader>dd",
        "<cmd>lua Snacks.dashboard.open()<CR>",
        desc = "Open Dashboard",
      },
      {
        "<leader>dg",
        "<cmd>Snacks dashboard keys<CR>",
        desc = "Dashboard Keys",
      },
      {
        "<C-e>",
        "<cmd>lua Snacks.explorer.open()<CR>",
        desc = "Open File Explorer",
      },
      {
        "<leader>uC",
        function() Snacks.picker.colorschemes() end,
        desc = "Colorschemes",
      },
      {
        "<leader>.",
        function() Snacks.scratch() end,
        desc = "Toggle Scratch Buffer",
      },
      {
        "<leader>S",
        function() Snacks.scratch.select() end,
        desc = "Select Scratch Buffer",
      },
      {
        "<c-/>",
        function() Snacks.terminal() end,
        desc = "Toggle Terminal",
      },
      {
        "<c-_>",
        function() Snacks.terminal() end,
        desc = "which_key_ignore",
      },
      {
        "<leader>z",
        function() Snacks.zen() end,
        desc = "Toggle Zen Mode",
      },
      {
        "<leader>z",
        function() Snacks.zen() end,
        desc = "Toggle Zen Mode",
      },
      {
        "<leader>gg",
        function() Snacks.lazygit() end,
        desc = "Lazygit",
      },
      {
        "<leader>un",
        function() Snacks.notifier.hide() end,
        desc = "Dismiss All Notifications",
      },
      {
        "<leader>dr",
        function() Snacks.rename.rename_file() end,
        desc = "Rename File",
      },
    },
    cmd = {
      "Snacks",
      "SnacksDashboard",
    },
  },
}
