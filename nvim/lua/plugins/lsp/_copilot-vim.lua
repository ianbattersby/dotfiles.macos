local function config() end

return {
  setup = function(use)
    use {
      "github/copilot.vim",
      config = config,
    }
  end,
}
