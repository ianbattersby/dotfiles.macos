return {
  server = "helm_ls",
  config = {
    on_attach = require "plugins.lsp.builder".new {}:on_attach(),
  },
}
