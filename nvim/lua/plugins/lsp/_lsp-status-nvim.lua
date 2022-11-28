local function config()
  -- Initialise lsp-status.nvim in the buffer on_attach
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp_status", { clear = true }),
    callback = function(args)
      require("lsp-status").on_attach(vim.lsp.get_client_by_id(args.data.client_id))
    end,
  })
end

return {
  setup = function(use)
    use {
      "nvim-lua/lsp-status.nvim",
      config = config,
    }
  end,
}
