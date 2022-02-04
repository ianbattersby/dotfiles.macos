local function config()
  require("notify").setup {
    render = "minimal",
  }

  vim.notify = require "notify"
end

return {
  setup = function(use)
    use {
      "rcarriga/nvim-notify",
      requires = { "nvim-lua/plenary.nvim" },
      after = { "which-key.nvim" },
      config = config,
    }
  end,
}
