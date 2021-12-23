local function config()
  vim.g.copilot_no_tab_map = true
  vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
end

return {
  setup = function(use)
    use {
      "github/copilot.vim",
      config = config,
    }
  end,
}
