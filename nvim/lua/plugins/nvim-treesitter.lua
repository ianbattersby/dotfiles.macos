return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- last release is way too old and doesn't work on Windows
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSUpdateSync" },
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        init = function()
          -- PERF: no need to load the plugin, if we only need its queries for mini.ai
          local plugin = require "lazy.core.config".spec.plugins["nvim-treesitter"]
          local opts = require "lazy.core.plugin".values(plugin, "opts", false)
          local enabled = false
          if opts.textobjects then
            for _, mod in ipairs({ "move", "select", "swap", "lsp_interop" }) do
              if opts.textobjects[mod] and opts.textobjects[mod].enable then
                enabled = true
                break
              end
            end
          end
          if not enabled then
            require "lazy.core.loader".disable_rtp_plugin "nvim-treesitter-textobjects"
          end
        end,
      },
      {
        "nvim-treesitter/nvim-treesitter-context",
        event = "VeryLazy",
        enabled = true,
        opts = { mode = "cursor", max_lines = 3 },
        keys = {
          {
            "<leader>ut",
            function()
              local LazyUtil = require "lazy.core.util"
              local tsc = require "treesitter-context"
              tsc.toggle()
              if LazyUtil.inject.get_upvalue(tsc.toggle, "enabled") then
                LazyUtil.info("Enabled Treesitter Context", { title = "Option" })
              else
                LazyUtil.warn("Disabled Treesitter Context", { title = "Option" })
              end
            end,
            desc = "Toggle Treesitter Context",
          },
        },
      },
    },
    keys = {
      { "<c-space>", desc = "Increment selection" },
      { "<bs>", desc = "Decrement selection", mode = "x" },
    },
    ---@type TSConfig
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        "bash",
        "c",
        -- "c_sharp",
        "dockerfile",
        "go",
        "gomod",
        "gowork",
        "gosum",
        "html",
        "hcl",
        "javascript",
        "jsdoc",
        "json",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "ron",
        "rust",
        "terraform",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      },
      -- Let wildfire.nvim handle this!
      -- incremental_selection = {
      --   enable = true,
      --   keymaps = {
      --     init_selection = "<C-space>",
      --     node_incremental = "<C-space>",
      --     scope_incremental = false,
      --     node_decremental = "<bs>",
      --   },
      -- },
    },
    ---@param opts TSConfig
    config = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        ---@type table<string, boolean>
        local added = {}
        opts.ensure_installed = vim.tbl_filter(function(lang)
          if added[lang] then
            return false
          end
          added[lang] = true
          return true
        end, opts.ensure_installed)
      end
      require "nvim-treesitter.configs".setup(opts)
    end,
  },
}
