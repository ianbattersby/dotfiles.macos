local M = {
  "folke/which-key.nvim",
}

function M.config()
  require "which-key" .setup {}

  require "which-key" .register({
    ["?"] = { "<CMD>Cheatsheet<CR>", "Cheatsheet" },
    b = { name = "Buffers" },
    c = { name = "Code", r = { name = "Refactor" } },
    d = {
      name = "Debug",
      -- Remove these when packer.nvim support keymap descriptions again
      s = { name = "Step" },
      h = { name = "Hover" },
      u = { name = "UI" },
      r = { name = "Repl" },
      B = { name = "Breakpoints" },
    },
    e = { name = "Testing", d = { name = "Debug" } },
    f = { name = "Find" },
    g = { name = "Goto" },
    h = { name = "Hunk", t = { name = "Toggle" } },
    m = {
      name = "Mind",
    },
    n = { name = "Noice" },
    q = { name = "Session" },
    s = { name = "Split" },
    t = { name = "Terminal" },
    w = {
      name = "Workspace",
    },
    x = {
      name = "Diagnostics",
    }
  }, { prefix = "<leader>" })
end

return M
