local M = {
  "folke/neoconf.nvim",
  enabled = false,
}

function M.config()
  require "neoconf" .setup()
end

return M
