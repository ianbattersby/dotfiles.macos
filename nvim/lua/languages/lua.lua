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
}

return { server = "sumneko_lua", config = config }
