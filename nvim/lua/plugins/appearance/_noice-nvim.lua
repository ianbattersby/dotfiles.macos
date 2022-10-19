local function config()
  require("noice").setup {
    notify = {
      enabled = true,
    },
    hacks = {
      slip_duplicate_messages = true,
    },
    lsp_progress = {
      enabled = true,
    },
  }
end

return {
  setup = function(use)
    use {
      "folke/noice.nvim",
      event = "VimEnter",
      requires = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
      },
      config = config,
    }
  end,
}
