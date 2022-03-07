local function config()
  local lspconfig = require "lspconfig"
  local languages = require "languages"
  local lspstatus = require "lsp-status"

  local lspinstaller_servers = require "nvim-lsp-installer.servers"

  local function make_config()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.codeLens = { dynamicRegistration = false }

    -- Enhance capabilities according to lsp-status
    capabilities = vim.tbl_extend("keep", capabilities or {}, lspstatus.capabilities)

    -- Enhance capabilities according to cmp_nvim_lsp
    require("cmp_nvim_lsp").update_capabilities(capabilities)

    return {
      root_dir = function(fname)
        return lspconfig.util.find_git_ancestor(fname) or require("utils").find_session_directory()
      end,
      capabilities = capabilities,
    }
  end

  local function setup_servers()
    local displayinfo = false

    for _, language_impl in pairs(vim.tbl_keys(languages)) do
      local language = languages[language_impl]

      if language then
        if language.initialize ~= nil then
          language.initialize()
        end

        local configuration = vim.tbl_deep_extend("force", make_config(), language.config)

        if configuration.on_attach == nil then
          local lconfig = require("lspbuilder").new()
          configuration.on_attach = lconfig:on_attach()
        end

        local server_available, requested_server = lspinstaller_servers.get_server(language.server)
        --print("LspInstaller server available for ", language.server, "? ", server_available)

        if server_available then
          --print("Using LspInstaller for: ", language.server)
          requested_server:on_ready(function()
            requested_server:setup(configuration)
          end)
          if not requested_server:is_installed() then
            --print("Installing Lsp server: ", language.server)
            requested_server:install()
            displayinfo = true
          end
        else
          --print("Manually configuring LSP config for: ", language.server)
          lspconfig[language.server].setup(configuration)
          --vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
        end

        if language.finalize ~= nil then
          language.finalize()
        end
      end
    end

    if displayinfo == true then
      require("nvim-lsp-installer").info_window.open()
    end
  end

  lspstatus.register_progress()

  setup_servers()

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
  })

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "single",
  })

  -- This is overrided by lsp_signature
  -- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  --   border = "single",
  -- })

  require("lsp_signature").setup {
    bind = true,
    doc_lines = 0,
    floating_window = true,
    fix_pos = true,
    hint_enable = true,
    hint_prefix = " ",
    hint_scheme = "String",
    hi_parameter = "Search",
    max_height = 22,
    max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
    handler_opts = {
      border = "single", -- double, rounded, single, shadow, none
    },
    zindex = 200, -- by default it will be on top of all floating windows, set to 50 send it to bottom
    padding = "", -- character to pad on left and right of signature can be ' ', or '|'  etc
  }
end

return {
  setup = function(use)
    use {
      "neovim/nvim-lspconfig",
      requires = {
        "williamboman/nvim-lsp-installer",
        "nvim-lua/lsp_extensions.nvim",
        "nvim-lua/lsp-status.nvim",
        "ray-x/lsp_signature.nvim",
      },
      after = { "rust-tools.nvim", "nvim-lsp-installer", "nvim-cmp", "lsp-status.nvim", "which-key.nvim" },
      config = config,
    }
  end,
}
