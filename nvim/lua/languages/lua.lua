local lconfig = require("lspbuilder").new {
  {
    mode = "n",
    keybinding = "<leader>ct",
    action = "<Plug>PlenaryTestFile",
    desc = "Run Tests",
  },
}

local config = {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = {
          "?.lua",
          "?/?.lua",
        },
      },
      diagnostics = {
        globals = {
          -- Get the language server to recognize the `vim` global
          "vim",
          "fun",
        },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
        },
      },
      telemetry = {
        enable = false,
      },
    },
  },
  on_attach = lconfig:on_attach(),
}

return { server = "sumneko_lua", config = config }
