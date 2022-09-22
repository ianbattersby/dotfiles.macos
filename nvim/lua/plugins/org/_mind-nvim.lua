local function config()
  require("mind").setup {}

  require("which-key").register({
    m = {
      name = "Mind",
      o = { "<cmd>MindOpenMain<CR>", "Open" },
      q = { "<cmd>MindClose<CR>", "Close" },
      p = { "<cmd>MindOpenProject<CR>", "Project" },
      s = { "<cmd>MindOpenSmartProject<CR>", "Smart Project" },
      r = { "<cmd>MindReloadState<CR>", "Reload" },
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
