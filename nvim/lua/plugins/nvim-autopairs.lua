local M = {
  "windwp/nvim-autopairs",
  event = "VeryLazy"
}

function M.config()
  local npairs = require "nvim-autopairs"
  local Rule = require "nvim-autopairs.rule"

  npairs.setup {
    disable_filetype = {
      "TelescopePrompt",
      "vim",
      "guihua",
      "guihua_rust",
      "clap_input",
      "packer",
      "lazy",
      "help",
      "neo-tree",
      "Trouble",
      "trouble",
      "dap-repl",
      "Outline",
      "mind",
      "neotest-summary",
    },
    check_ts = true,
    ts_config = {
      lua = { "string" }, -- it will not add a pair on that treesitter node
      javascript = { "template_string" },
      java = false,       -- don't check treesitter on java
    },
  }

  local ts_conds = require "nvim-autopairs.ts-conds"

  -- press % => %% only while inside a comment or string
  npairs.add_rules {
    Rule("%", "%", "lua"):with_pair(ts_conds.is_ts_node { "string", "comment" }),
    Rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node { "function" }),
  }

  -- Disable matching of single quotes in Rust.
  npairs.get_rule "'"[1]:with_pair(function()
    if vim.bo.filetype == "rust" then
      return false
    end

    return true
  end)
  -- end)

  -- When pressing a space after a pair, insert an extra space before the closing
  -- pair.
  local space_pairs = { "()", "[]", "{}" }

  npairs.add_rules {
    Rule(" ", " "):with_pair(function(opts)
      local pair = opts.line:sub(opts.col, opts.col + 1)

      return vim.tbl_contains(space_pairs, pair)
    end),
  }
end

return M
