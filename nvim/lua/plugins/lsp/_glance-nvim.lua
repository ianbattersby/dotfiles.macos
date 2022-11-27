local function config()
  require("glance").setup {
    border = {
      enable = true,
    },
    hooks = {
      before_open = function(results, open, jump, method)
        local uri = vim.uri_from_bufnr(0)
        if #results == 1 then
          local target_uri = results[1].uri or results[1].targetUri

          if target_uri == uri then
            jump(results[1])
          else
            open(results)
          end
        else
          open(results)
        end
      end,
    },
  }

  local ok, hl = pcall(vim.api.nvim_get_hl_by_name, "NeogitHunkHeaderHighlight", true)
  if ok then
    vim.api.nvim_set_hl(0, "GlanceBorderTop", hl)
  end
end

return {
  setup = function(use)
    use {
      "dnlhc/glance.nvim",
      config = config,
    }
  end,
}
