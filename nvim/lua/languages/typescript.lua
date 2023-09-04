local function initialize()
  local mason_registry = require "mason-registry"
  local tsserver_path = mason_registry.get_package "typescript-language-server":get_install_path()

  require "typescript-tools".setup {
    on_attach = require "plugins.lsp.builder".new():on_attach(),
    tsserver_file_preferences = {
      includeInlayParameterNameHints = "all",
      includeInlayParameterNameHintsWhenArgumentMatchesName = false,
      includeInlayFunctionParameterTypeHints = true,
      includeInlayVariableTypeHints = true,
      includeInlayPropertyDeclarationTypeHints = true,
      includeInlayFunctionLikeReturnTypeHints = true,
      includeInlayEnumMemberValueHints = true,
    },
    tsserver_format_options = {},
    settings = {
      tsserver_path = tsserver_path .. "/node_modules/typescript/lib/tsserver.js",
      separate_diagnostic_server = true,
      publish_diagnostic_on = "insert_leave",
      expose_as_code_action = {},
      tsserver_plugins = {},
      tsserver_max_memory = "auto",
      tsserver_format_options = {},
      tsserver_file_preferences = {},
      complete_function_calls = false,
    },
  }
end

return { server = "typescript-tools", config = nil, initialize = initialize }
