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
    textobjects = {
      select = {
        enable = true,

        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,

        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = { query = "@function.outer", desc = "outer function" },
          ["if"] = { query = "@function.inner", desc = "inner function" },
          ["ac"] = { query = "@class.outer", desc = "outer class" },
          ["ic"] = { query = "@class.inner", desc = "inner class" },
        },
        -- You can choose the select mode (default is charwise 'v')
        --
        -- Can also be a function which gets passed a table with the keys
        -- * query_string: eg '@function.inner'
        -- * method: eg 'v' or 'o'
        -- and should return the mode ('v', 'V', or '<c-v>') or a table
        -- mapping query_strings to modes.
        selection_modes = {
          ["@parameter.outer"] = "v", -- charwise
          ["@function.outer"] = "V", -- linewise
          ["@function.inner"] = "<c-v>",
          ["@class.outer"] = "<c-v>", -- blockwise
        },
        -- If you set this to `true` (default is `false`) then any textobject is
        -- extended to include preceding or succeeding whitespace. Succeeding
        -- whitespace has priority in order to act similarly to eg the built-in
        -- `ap`.
        --
        -- Can also be a function which gets passed a table with the keys
        -- * query_string: eg '@function.inner'
        -- * selection_mode: eg 'v'
        -- and should return true of false
        include_surrounding_whitespace = false,
      },
      swap = {
        enable = true,
        swap_next = {
          ["<leader>crp"] = { query = "@parameter.inner", desc = "Param right" },
        },
        swap_previous = {
          ["<leader>crP"] = { query = "@parameter.inner", desc = "Param left" },
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]]"] = { query = "@function.outer", desc = "Next function start" },
          ["]c"] = { query = "@class.outer", desc = "Next class start" },
        },
        goto_next_end = {
          ["]["] = { query = "@function.outer", desc = "Next function end" },
          ["]C"] = { query = "@class.outer", desc = "Next class end" },
        },
        goto_previous_start = {
          ["[["] = { query = "@function.outer", desc = "Previous function start" },
          ["[c"] = { query = "@class.outer", desc = "Previous class start" },
        },
        goto_previous_end = {
          ["[]"] = { query = "@function.outer", desc = "Previous function end" },
          ["[C"] = { query = "@class.outer", desc = "Previous class end" },
        },
      },
      lsp_interop = {
        enable = true,
        border = "rounded",
        peek_definition_code = {
          ["<leader>cp"] = { query = "@function.outer", desc = "Peek function" },
          ["<leader>cP"] = { query = "@class.outer", desc = "Peek class" },
        },
      },
    },
  }
end

return {
  setup = function(use)
    use {
      "nvim-treesitter/nvim-treesitter",
      requires = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        --"nvim-treesitter/nvim-treesitter-refactor"
      },
      run = ":TSUpdate",
      config = config,
    }
  end,
}
