return {
  setup = function(use)
    use {
      "akinsho/toggleterm.nvim",
      tag = "*",
      config = function()
        require("toggleterm").setup {
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

        vim.keymap.set("n", "<leader>tt", "<CMD>ToggleTerm<CR>", { noremap = true, silent = true, desc = "Toggle" })
        vim.keymap.set(
          "n",
          "<leader>tf",
          "<CMD>ToggleTerm direction='float'<CR>",
          { noremap = true, silent = true, desc = "Toggle" }
        )
        vim.keymap.set(
          "n",
          "<leader>th",
          "<CMD>ToggleTermToggleAll<CR>",
          { noremap = true, silent = true, desc = "Hide" }
        )
        vim.keymap.set(
          "n",
          "<leader>tn",
          "<CMD>ToggleTermSetName<CR>",
          { noremap = true, silent = true, desc = "Name" }
        )

        vim.api.nvim_create_autocmd("TermOpen", {
          pattern = "term://*",
          callback = function()
            vim.keymap.set("t", "<C-Space>", [[<C-\><C-n>]], { buffer = 0 })
            vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], { buffer = 0 })
            vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], { buffer = 0 })
            vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], { buffer = 0 })
            vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], { buffer = 0 })
          end,
        })
      end,
    }
  end,
}
