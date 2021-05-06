local function config()
  require'nvim-treesitter.configs'.setup {
    ensure_installed = { "bash", "c_sharp", "css", "go", "gomod", "javascript", "json", "jsdoc", "lua", "python", "rust", "scss", "toml", "yaml" }, --"maintained", --vim.tbl_keys(require'languages')),
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
