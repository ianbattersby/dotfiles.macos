local M = {
  "akinsho/toggleterm.nvim",
  version = "*",
  event = "VeryLazy",
  keys = {
    { "<leader>\\", "<CMD>ToggleTerm<CR>", desc = "Toggle Terminal" },
    { "<leader>ftt", "<CMD>ToggleTerm<CR>", desc = "Toggle Terminal" },
    { "<leader>ftT", "<CMD>ToggleTerm direction='float'<CR>", desc = "Float" },
    { "<leader>fth", "<CMD>ToggleTermToggleAll<CR>", desc = "Hide" },
    { "<leader>ftn", "<CMD>ToggleTermSetName<CR>", desc = "Name" },
    { "<leader>ftl", "<CMD>ToggleTermSendCurrentLine<CR>", desc = "Send (Current Line)" },
    { "<leader>ftv", "<CMD>ToggleTermSendVisualLines<CR>", desc = "Send (Visual Line)" },
    { "<leader>fts", "<CMD>ToggleTermSendVisualSelection<CR>", desc = "Send (Visual Selection)" },
  }
}

function M.config()
  require "toggleterm".setup {
    size = function(term)
      if term.direction == "horizontal" then
        return 10
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4
      end
    end,
    direction = "horizontal",
    winbar = { enabled = true },
    shading_factor = "15",
  }

  vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "term://*",
    callback = function()
      vim.keymap.set("t", "<C-Space>", [[<C-\><C-n>]], { buffer = 0 })
      vim.keymap.set("t", "<C-h>", [[<CMD>wincmd h<CR>]], { buffer = 0 })
      vim.keymap.set("t", "<C-j>", [[<CMD>wincmd j<CR>]], { buffer = 0 })
      vim.keymap.set("t", "<C-k>", [[<CMD>wincmd k<CR>]], { buffer = 0 })
      vim.keymap.set("t", "<C-l>", [[<CMD>wincmd l<CR>]], { buffer = 0 })
    end,
  })

  vim.api.nvim_create_autocmd("TermEnter", {
    pattern = "term://*toggleterm#*",
    callback = function()
      vim.keymap.set(
        "n",
        "<c-t>",
        [[<CMD>exec v:count1 . "ToggleTerm"<CR>]],
        { buffer = 0, silent = true, noremap = true }
      )
    end,
  })
end

return M
