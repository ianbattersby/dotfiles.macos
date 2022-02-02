local function config()
  vim.g.copilot_filetypes = {
    ["*"] = false,
    ["javascript"] = true,
    ["typescript"] = true,
    ["lua"] = false,
    ["rust"] = true,
    ["c"] = true,
    ["c#"] = true,
    ["c++"] = true,
    ["go"] = true,
    ["python"] = true,
  }

  vim.g.copilot_no_tab_map = true
  vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

  -- require("which-key").register({
  --   ["C-j"] = { "copilot#Accept('<CR>')", "Accept copilot suggestion" },
  -- }, { mode = "i", expr = true })
end

return {
  setup = function(use)
    use {
      "github/copilot.vim",
      --after = "which-key.nvim",
      config = config,
    }
  end,
}
