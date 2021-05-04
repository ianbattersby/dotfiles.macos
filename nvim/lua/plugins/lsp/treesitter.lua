local function config()
  require'nvim-treesitter.configs'.setup {
    ensure_installed = vim.tbl_keys(require'languages'),
    highlight = {
      enable = true,
    }
  }
end

return {
  setup = function(use)
    use {
      'nvim-treesitter/nvim-treesitter',
      run = ":TSUpdate",
      config = config
    }
  end
}
