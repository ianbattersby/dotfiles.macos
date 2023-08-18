local M = {
  "akinsho/toggleterm.nvim",
  version = "*",
  keys = {
    { "<leader>ft", "<CMD>ToggleTerm<CR>",                   desc = "Toggle Terminal" },
    { "<leader>fT", "<CMD>ToggleTerm direction='float'<CR>", desc = "Float" },
    -- { "<leader>th", "<CMD>ToggleTermToggleAll<CR>",          desc = "Hide" },
    -- { "<leader>tn", "<CMD>ToggleTermSetName<CR>",            desc = "Name" },
  }
}

function M.config()
  require "toggleterm" .setup {
    size = function(term)
      if term.direction == "horizontal" then
        return 10
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4
      end
    end,
    direction = "horizontal",
    winbar = { enabled = true },
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
