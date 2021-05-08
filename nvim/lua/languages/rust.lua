local settings = {
  ["rust-analyzer"] = {
    assist = {
      importMergeBehavior = "last",
      importPrefix = "by_self",
    },
    cargo = {
      loadOutDirsFromCheck = true
    },
    procMacro = {
      enable = true
    },
  }
}

return {name = "rust", config = { auto_install = false, settings = settings}}
