local M = {}

function M.setup()
  local lspconfig = require "lspconfig"
  local languages = require "languages"

  for _, language_impl in pairs(vim.tbl_keys(languages)) do
    local language = languages[language_impl]

    local cmp_enhanced_config = vim.tbl_deep_extend(
      "force",
      lspconfig[language.server] or {},
      { capabilities = require "cmp_nvim_lsp".default_capabilities() }
    )

    if language ~= nil then
      if language.initialize ~= nil then
        language.initialize()
      end

      local language_config = type(language.config) == "function" and language.config() or language.config or {}

      if language_config ~= nil then
        local combined_config = vim.tbl_deep_extend("force", cmp_enhanced_config, language_config)

        if combined_config.on_attach == nil then
          local lconfig = require "plugins.lsp.builder".new()
          combined_config.on_attach = lconfig:on_attach()
        end

        lspconfig[language.server].setup(combined_config)
      end

      if language.finalize ~= nil then
        language.finalize()
      end
    end
  end
end

return M
