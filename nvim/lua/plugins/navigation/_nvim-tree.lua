local function config()
  vim.cmd [[nnoremap <C-n> :NvimTreeToggle<CR>]]
  vim.cmd [[nnoremap <leader>r :NvimTreeRefresh<CR>]]

  require("nvim-tree").setup {
    disable_netrw = true,
    hijack_netrw = true,
    open_on_setup = false,
    ignore_ft_on_setup = {},
    open_on_tab = false,
    hijack_cursor = false,
    update_cwd = false,
    update_focused_file = {
      enable = true,
      update_cwd = false,
      ignore_list = {},
    },
    diagnostics = {
      enable = false,
      icons = {
        hint = "",
        info = "",
        warning = "",
        error = "",
      },
    },
    system_open = {
      cmd = nil,
      args = {},
    },
    filters = {
      dotfiles = false,
      custom = {},
    },
    view = {
      width = 35,
      hide_root_folder = false,
      side = "left",
      mappings = {
        custom_only = false,
        list = {},
      },
    },
    actions = {
      open_file = {
        resize_window = true,
      },
    },
  }

  vim.cmd [[autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif]]
end

return {
  setup = function(use)
    use {
      "kyazdani42/nvim-tree.lua",
      module = "nvim-tree",
      requires = { "kyazdani42/nvim-web-devicons" },
      after = { "onedark.nvim", "nvim-web-devicons" },
      config = config,
    }
  end,
}
