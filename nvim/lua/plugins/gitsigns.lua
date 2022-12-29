local M = {
  "lewis6991/gitsigns.nvim",
  dependencies = "nvim-lua/plenary.nvim",
  priority = 500,
}

function M.config()
  require("gitsigns").setup {
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl = true, -- Toggle with `:Gitsigns toggle_linehl`
  }

  -- Initialise gitsigns in the buffer on_attach
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp_gitsigns", { clear = true }),
    callback = function(args)
      local gs = package.loaded.gitsigns

      vim.keymap.set("n", "]g", function()
        if vim.wo.diff then
          return "]g"
        end
        vim.schedule(function()
          gs.next_hunk()
        end)
        return "<Ignore>"
      end, { expr = true, desc = "Next hunk" })

      vim.keymap.set("n", "[g", function()
        if vim.wo.diff then
          return "[g"
        end
        vim.schedule(function()
          gs.prev_hunk()
        end)
        return "<Ignore>"
      end, { expr = true, desc = "Previous hunk" })

      vim.keymap.set({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", { desc = "Stage hunk", buffer = args.buf })
      vim.keymap.set({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", { desc = "Reset hunk", buffer = args.buf })
      vim.keymap.set("n", "<leader>hS", gs.stage_buffer, { desc = "Stage buffer", buffer = args.buf })
      vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo stage hunk", buffer = args.buf })
      vim.keymap.set("n", "<leader>hR", gs.reset_buffer, { desc = "Reset buffer", buffer = args.buf })
      vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { desc = "Previous hunk", buffer = args.buf })
      vim.keymap.set("n", "<leader>hb", function()
        gs.blame_line { full = true }
      end, { desc = "Blame line", buffer = args.buf })
      vim.keymap.set(
        "n",
        "<leader>htb",
        gs.toggle_current_line_blame,
        { desc = "Toggle line blame", buffer = args.buf }
      )
      vim.keymap.set("n", "<leader>hd", gs.diffthis, { desc = "Diff file", buffer = args.buf })
      vim.keymap.set("n", "<leader>hD", function()
        gs.diffthis "~"
      end, { desc = "Diff directory", buffer = args.buf })
      vim.keymap.set("n", "<leader>htd", gs.toggle_deleted, { buffer = args.buf })
      vim.keymap.set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk", buffer = args.buf })
    end,
  })
end

return M
