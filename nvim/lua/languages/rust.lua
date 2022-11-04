-- Inspired and significantly reliant on the awesome rust-tools.nvim, but
-- lconfig allows more control and to follow the setup pattern already used.
-- https://github.com/simrat39/rust-tools.nvim
local lconfig = require("lspbuilder").new {
  {
    mode = "n",
    keybinding = "<leader>cc",
    action = ':lua require("rust-tools.hover_actions").hover_actions()<CR>',
    desc = "Actions (Hover)",
  },
}

local config = {
  on_attach = lconfig:on_attach(),
}

return { server = "rust_analyzer", config = config }
