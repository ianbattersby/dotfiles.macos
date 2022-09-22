local function config()
  require("mind").setup {}

  require("which-key").register({
    m = {
      name = "Mind",
      o = { "<cmd>MindOpenMain<CR>", "Open" },
      x = { "<cmd>MindClose<CR>", "Close" },
      p = { "<cmd>MindOpenProject", "Project" },
      s = { "<cmd>MindOpenSmartProject", "Smart Project" },
      r = { "<cmd>MindReloadState", "Reload" },
    },
  }, { prefix = "<leader>" })
end

return {
  setup = function(use)
    use {
      "phaazon/mind.nvim",
      requires = { "nvim-lua/plenary.nvim" },
      branch = "v2.2",
      config = config,
    }
  end,
}
