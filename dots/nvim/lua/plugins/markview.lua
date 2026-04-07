local presets = require("markview.presets")
local table = require("markview.presets").tables
return {
  "markview.nvim",
  after = function()
    require("markview").setup({
      markdown = {
        headings = presets.headings.slanted,
        tables = table.rounded,
      },
    })
  end,
}
