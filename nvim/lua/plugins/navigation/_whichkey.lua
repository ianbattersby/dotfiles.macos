local function config()
  require("which-key").setup {}

  require("which-key").register({
    ["?"] = { name = "Cheatsheet" },
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
      -- Remove these when packer.nvim support keymap descriptions again
      o = { name = "Open" },
      q = { name = "Close" },
      p = { name = "Project" },
      s = { name = "Smart Project" },
    },
    q = { name = "Diagnostics" },
    s = { name = "Split" },
    t = { name = "Terminal" },
    w = {
      name = "Workspace",
      -- Remove these when packer.nvim support keymap descriptions again
      v = { name = "Diff View" },
    },
  }, { prefix = "<leader>" })
end

return {
  setup = function(use)
    use {
      "folke/which-key.nvim",
      config = config,
    }
  end,
}
