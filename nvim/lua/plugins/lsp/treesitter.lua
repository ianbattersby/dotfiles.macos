local function config()
  require'nvim-treesitter.configs'.setup {
    ensure_installed = { "bash", "c_sharp", "css", "go", "gomod", "javascript", "json", "jsdoc", "lua", "python", "regex", "rust", "scss", "toml", "yaml" }, --"maintained", --vim.tbl_keys(require'languages')),
    highlight = {
      enable = true,
    },
    indent = {
      enable = true
    },
    refactor = {
      highlight_current_scope = { enable = false },
      highlight_definitions = { enable = true },
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gs",
        node_incremental = "gj",
        scope_incremental = "gl",
        node_decremental = "gk",
      },
    },
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
