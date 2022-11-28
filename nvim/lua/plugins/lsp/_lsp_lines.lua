local function config()
  require("lsp_lines").setup {}
end

return {
  setup = function(use)
    use {
      "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
      config = config,
    }
  end,
}
