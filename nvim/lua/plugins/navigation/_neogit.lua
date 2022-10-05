local function config()
  require("neogit").setup {}
end

return {
  setup = function(use)
    use {
      "TimUntersberger/neogit",
      module = "neogit",
      requires = { "nvim-lua/plenary.nvim" },
      config = config,
    }
  end,
}
