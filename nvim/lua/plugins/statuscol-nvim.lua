local M = {
  "luukvbaal/statuscol.nvim"
}

function M.config()
  require "statuscol".setup {
    setopt = true,
  }
end

return M
