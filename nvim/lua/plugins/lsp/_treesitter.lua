local function config()
  local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()

  parser_configs.hcl = {
    install_info = {
      url = "https://github.com/MichaHoffmann/tree-sitter-hcl",
      files = { "src/parser.c", "src/scanner.cc" },
      branch = "main",
    },
  }

  require("nvim-treesitter.configs").setup {
    ensure_installed = {
      "bash",
      "c_sharp",
      "css",
      "go",
      "gomod",
      "javascript",
      "json",
      "jsdoc",
      "lua",
      "python",
      "regex",
      "rust",
      "scss",
      "toml",
      "yaml",
      "hcl",
      "markdown",
      "zig",
    }, --"maintained", --vim.tbl_keys(require'languages')),
    highlight = {
      enable = true,
    },
    indent = {
      enable = false,
    },
    -- refactor = {
    --   highlight_current_scope = { enable = false },
    --   highlight_definitions = { enable = true },
    --   smart_rename = { enable = true, keymaps = { smart_rename = "gnr" } },
    --   navigation = {
    --     enable = true,
    --     keymaps = {
    --       goto_definition_lsp_fallback = "gnd",
    --     },
    --   },
    -- },
    incremental_selection = {
      enable = false,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
    },
  }
end

return {
  setup = function(use)
    use {
      "nvim-treesitter/nvim-treesitter",
      --requires = { "nvim-treesitter/nvim-treesitter-refactor" },
      run = ":TSUpdate",
      config = config,
    }
  end,
}
