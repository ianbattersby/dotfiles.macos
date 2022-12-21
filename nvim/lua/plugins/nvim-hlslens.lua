local M = {
  "kevinhwang91/nvim-hlslens",
}

function M.config()
  require("hlslens").setup {
    calm_down = true,
  }

  vim.api.nvim_set_keymap(
    "n",
    "n",
    [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
    { desc = "Next", noremap = true, silent = true }
  )
  vim.api.nvim_set_keymap(
    "n",
    "N",
    [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
    { desc = "Previous", noremap = true, silent = true }
  )
  vim.api.nvim_set_keymap(
    "n",
    "*",
    [[*<Cmd>lua require('hlslens').start()<CR>]],
    { desc = "", noremap = true, silent = true }
  )
  vim.api.nvim_set_keymap("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], { noremap = true, silent = true })
  vim.api.nvim_set_keymap("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], { noremap = true, silent = true })
  vim.api.nvim_set_keymap("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], { noremap = true, silent = true })

  vim.api.nvim_set_keymap("n", "<Leader>l", ":noh<CR>", { noremap = true, silent = true })
end

return M
