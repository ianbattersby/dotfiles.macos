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
      format = {
        enable = true,
        defaultConfig = {
          indent_style = "space",
          indent_size = "2",
          call_arg_parentheses = "remove_table_only",
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
        checkThirdParty = false,
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
        },
      },
      telemetry = {
        enable = false,
      },
      completion = {
        callSnippet = "Replace",
      },
    }
  }
}

return { server = "lua_ls", config = config }
