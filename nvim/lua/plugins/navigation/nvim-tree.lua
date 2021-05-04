local function config()
  local global = {vim.g}
  require'utils'.opts({
    nvim_tree_side = 'left',
    nvim_tree_follow = 1,
    nvim_tree_quit_on_open = 1,
    nvim_tree_lsp_diagnostics = 1,
    nvim_tree_disable_netrw = 0,
    nvim_tree_hijack_netrw = 0,
  }, global)

  local options = { noremap = true }
  require'utils'.map('n', '<A-1>', '<CMD>NvimTreeToggle<CR>', options)
end

return {
  setup = function(use)
    use {
      'kyazdani42/nvim-tree.lua',
      requires = 'nvim-web-devicons',
      config = config
    }
  end
}
