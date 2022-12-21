local M = {
  "sudormrfbin/cheatsheet.nvim",
  cmd = "Cheatsheet",
  keys = { "n", "<leader>?", "Cheatsheet" },
  dependencies = {
    { "ianbattersby/telescope.nvim" },
    { "nvim-lua/popup.nvim" },
    { "nvim-lua/plenary.nvim" },
  },
}

function M.config()
  -- Set this here so that 'cheatsheat.nvim' doesn't set it.
  --vim.keymap.set("n", "<leader>?", "<CMD>Cheatsheet<CR>", { noremap = true, silent = true, desc = "Cheatsheet" })

  require("cheatsheet").setup {
    -- Whether to show bundled cheatsheets

    -- For generic cheatsheets like default, unicode, nerd-fonts, etc
    -- bundled_cheatsheets = {
    --     enabled = {},
    --     disabled = {},
    -- },
    bundled_cheatsheets = true,

    -- For plugin specific cheatsheets
    -- bundled_plugin_cheatsheets = {
    --     enabled = {},
    --     disabled = {},
    -- }
    bundled_plugin_cheatsheets = true,

    -- For bundled plugin cheatsheets, do not show a sheet if you
    -- don't have the plugin installed (searches runtimepath for
    -- same directory name)
    include_only_installed_plugins = true,

    -- Key mappings bound inside the telescope window
    telescope_mappings = {
      ["<CR>"] = require("cheatsheet.telescope.actions").select_or_fill_commandline,
      ["<A-CR>"] = require("cheatsheet.telescope.actions").select_or_execute,
      ["<C-Y>"] = require("cheatsheet.telescope.actions").copy_cheat_value,
      ["<C-E>"] = require("cheatsheet.telescope.actions").edit_user_cheatsheet,
    },
  }
end

return M