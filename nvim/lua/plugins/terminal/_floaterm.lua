local function config()
  require("which-key").register({
    ["\\"] = { ":FloatermNew --autoclose=2 --height=0.9 --width=0.9 --wintype=floating<CR>", "Terminal" },
  }, { prefix = "<leader>" })
end

return {
  setup = function(use)
    use {
      "voldikss/vim-floaterm",
      after = "which-key.nvim",
      config = config,
    }
  end,
}
