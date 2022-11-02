local function config()
  require("noice").setup {
    views = {
      notify = {
        render = "minimal",
      },
    },
    messages = {
      enabled = true,
      -- view = "popup",
      -- view_error = "split",
      -- view_warn = "mini",
      -- view_history = "split",
      -- view_search = "virtualtext",
    },
    notify = {
      enabled = true,
      view = "mini",
    },
    -- format = {
    --   default = "{message}",
    -- },
    presets = {
      lsp_doc_border = true,
      --bottom_search = true,
    },
  }
end

return {
  setup = function(use)
    use {
      "folke/noice.nvim",
      --event = "VimEnter",
      requires = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
      },
      config = config,
    }
  end,
}
