local function config()
  require("which-key").setup {}

  require("which-key").register({
    c = {
      name = "Code",
      r = { name = "Refactor" },
    },
    d = {
      name = "Debug",
      s = { name = "Step" },
      h = { name = "Hover" },
      u = { name = "UI" },
      r = { name = "Repl" },
      B = { name = "Breakpoints" },
    },
    g = { name = "Goto" },
    m = { name = "Mind" },
    q = { name = "Diagnostics" },
    s = { name = "Split" },
    t = { mame = "Terminal" },
    w = { name = "Workspace" },
  }, { prefix = "<leader>" })

  require("which-key").register({ name = "Session" }, { prefix = "<leader><leader>" })
end

return {
  setup = function(use)
    use {
      "folke/which-key.nvim",
      config = config,
    }
  end,
}
