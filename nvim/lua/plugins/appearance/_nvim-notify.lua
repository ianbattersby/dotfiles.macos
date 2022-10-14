local function config()
  require("notify").setup {
    render = "minimal",
  }

  -- Let's assume noice will do this
  --vim.notify = require "notify"
end

return {
  setup = function(use)
    use {
      "rcarriga/nvim-notify",
      requires = { "nvim-lua/plenary.nvim" },
      config = config,
    }
  end,
}
