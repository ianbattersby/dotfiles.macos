local M = {
  "ianbattersby/noice.nvim",
  branch = "extend-notify-events",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
    "ianbattersby/telescope.nvim",
  },
}

function M.config()
  require("noice").setup {
    views = {
      notify = {
        render = "minimal",
        on_open = function(win, notif)
          local bufnr = vim.api.nvim_win_get_buf(win)

          if bufnr then
            vim.keymap.set(
              "n",
              "<C-Space>",
              require("notify").dismiss,
              { noremap = true, silent = true, desc = "Dismiss", buffer = bufnr }
            )

            if type(notif) == "table" then
              vim.keymap.set("n", "<C-t>", function()
                local opened = require("notify").open(notif)
                vim.cmd "tab split"
                vim.api.nvim_win_set_buf(0, opened.buffer)
              end, { noremap = true, silent = true, desc = "Split Out", buffer = bufnr })
            end
          end
        end,
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
      view = "notify",
    },
    commands = {
      last = { view = "split" },
      errors = { view = "split" },
    },
    lsp = {
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    presets = {
      lsp_doc_border = true,
      bottom_search = true,
    },
  }

  vim.keymap.set({ "n", "i" }, "<C-]>", function()
    if vim.api.nvim_buf_get_option(0, "filetype") == "noice" then
      vim.cmd "q"
    else
      require("noice").cmd "last"
    end
  end, { silent = true, noremap = true, desc = "Last message" })

  vim.keymap.set({ "n" }, "<leader>fm", function()
    require("noice").cmd "telescope"
  end, { silent = true, noremap = true, desc = "Message history" })

  -- Load Telescope extension
  require("telescope").load_extension "noice"
end

return M
