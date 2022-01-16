local function config()
  require("help-vsplit").setup()
end

return {
  setup = function(use)
    use {
      "anuvyklack/help-vsplit.nvim",
      config = config,
    }
  end,
}
