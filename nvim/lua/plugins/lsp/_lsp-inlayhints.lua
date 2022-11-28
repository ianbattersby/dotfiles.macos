local function config()
  require("lsp-inlayhints").setup {
    inlay_hints = {
      parameter_hints = {
        show = true,
        remove_colon_start = true,
        remove_colon_end = true,
        separator = " | ",
        prefix = " <- ",
      },
      type_hints = {
        show = true,
        remove_colon_start = true,
        remove_colon_end = true,
        separator = " | ",
        prefix = " ",
      },
      only_current_line = false,
    },
  }

  -- Steal the colorscheme from catpuccin for highlight
  local ok, hl = pcall(vim.api.nvim_get_hl_by_name, "DiagnosticVirtualTextHint", true)
  if ok then
    vim.api.nvim_set_hl(0, "LspInlayHint", hl)
  end

  -- Initialise lsp-inlayhints in the buffer on_attach
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp_inlayhints", { clear = true }),
    callback = function(args)
      require("lsp-inlayhints").on_attach(vim.lsp.get_client_by_id(args.data.client_id), args.buf)
    end,
  })
end

return {
  setup = function(use)
    use {
      "lvimuser/lsp-inlayhints.nvim",
      after = "catppuccin",
      config = config,
    }
  end,
}
