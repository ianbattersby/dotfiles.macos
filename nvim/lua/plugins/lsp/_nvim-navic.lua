local function config()
  require("nvim-navic").setup { depth_limit = 2, highlight = true }

  -- Initialise nvim-navic in the buffer on_attach
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp_nvim_navic", { clear = true }),

    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client.server_capabilities.documentSymbolProvider then
        require("nvim-navic").attach(client, args.buf)
      end
    end,
  })
end

return {
  setup = function(use)
    use {
      "SmiteshP/nvim-navic",
      requires = { "neovim/nvim-lspconfig" },
      config = config,
    }
  end,
}
