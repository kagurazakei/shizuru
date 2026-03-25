return {
  "quicker.nvim",
  event = "FileType qf",
  keys = {
    {
      "<leader>xq",
      function() require("quicker").toggle() end,
      desc = "Toggle quickfix",
    },
    {
      "<leader>xl",
      function() require("quicker").toggle({ loclist = true }) end,
      desc = "Toggle loclist list",
    },
    {
      "<leader>xd",
      function()
        local quicker = require("quicker")
        if quicker.is_open() then
          quicker.close()
        else
          vim.diagnostic.setqflist()
        end
      end,
      desc = "Toggle diagnostic",
    },
  },
  after = function()
    ---@type quicker.SetupOptions
    require("quicker").setup({
      borders = {
        vert = require("icons").misc.vertical_bar,
        keys = {
          {
            ">",
            function()
              require("quicker").expand({
                before = 2,
                after = 2,
                add_to_existing = true,
              })
            end,
            desc = "Expand quickfix context",
          },
          {
            "<",
            function() require("quicker").collapse() end,
            desc = "Collapse quickfix context",
          },
        },
      },
    })
  end,
}
