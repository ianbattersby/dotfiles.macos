local function config()
  require("notify").setup {
    stages = "static",
    render = "minimal",
    on_open = function(win)
      local bufnr = vim.api.nvim_win_get_buf(win)

      if bufnr then
        vim.keymap.set(
          "n",
          "<C-Space>",
          require("notify").dismiss,
          { noremap = true, silent = true, desc = "Dismiss", buffer = bufnr }
        )

        vim.keymap.set(
          "n",
          "<C-t>",
          "<CMD>tab split<CR>",
          { noremap = true, silent = true, desc = "Split Tab", buffer = bufnr }
        )
      end
    end,
  }

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
