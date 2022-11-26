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

  local ok, hl = pcall(vim.api.nvim_get_hl_by_name, "DiagnosticVirtualTextHint", true)
  if ok then
    vim.api.nvim_set_hl(0, "LspInlayHint", hl)
  end
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
