local function config()
  vim.g.ultest_use_pty = 1

  vim.g["test#strategy"] = { nearest = "neovim", file = "neovim", suite = "neovim" }

  vim.g["test#enabled_runners"] = {
    "javascript#ava",
    "javascript#cucumberjs",
    "python#pytest",
    "python#behave",
    "go#gotest",
    "lua#busted",
    "rust#cargotest",
  }

  --These don't work due to some "Dictionary as String" error :'(
  --vim.g["test#runner_commands"] = { "Ava", "CucumberJS", "Busted", "CargoTest" }
end

return {
  setup = function(use)
    use {
      "rcarriga/vim-ultest",
      requires = { "vim-test/vim-test" },
      run = ":UpdateRemotePlugins",
      config = config,
    }
  end,
}
