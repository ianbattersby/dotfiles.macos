local function config()
  vim.cmd[[nnoremap <C-n> :NvimTreeToggle<CR>]]
  vim.cmd[[nnoremap <leader>r :NvimTreeRefresh<CR>]]
  vim.cmd[[nnoremap <leader>n :NvimTreeFindFile<CR>]]

  require'nvim-tree'.setup {
    disable_netrw       = true,
    hijack_netrw        = true,
    open_on_setup       = false,
    ignore_ft_on_setup  = {},
    auto_close          = true,
    open_on_tab         = false,
    hijack_cursor       = false,
    update_cwd          = false,
    update_to_buf_dir   = {
      enable = true,
      auto_open = true,
    },
    update_focused_file = {
      enable      = true,
      update_cwd  = true,
      ignore_list = {}
    },
    diagnostics = {
      enable = false,
      icons = {
        hint = "",
        info = "",
        warning = "",
        error = "",
      }
    },
    system_open = {
      cmd  = nil,
      args = {}
    },
    filters = {
      dotfiles = false,
      custom = {}
    },
    view = {
      width = 30,
      height = 30,
      hide_root_folder = false,
      side = 'left',
      auto_resize = false,
      mappings = {
        custom_only = false,
        list = {}
      }
    }
  }
end

return {
  setup = function(use)
    use {
      'kyazdani42/nvim-tree.lua',
      requires = { 'kyazdani42/nvim-web-devicons' },
      config = config
    }
  end
}
