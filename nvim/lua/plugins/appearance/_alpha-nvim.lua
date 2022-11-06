local function config()
  local startify = require "alpha.themes.startify"

  local top_buttons = {
    startify.button("e", "New file", "<CMD>ene <CR>"),
    startify.button("/", "Last session", "<CMD>SessionManager load_last_session<CR>"),
  }

  startify.config.layout[4] = vim.tbl_deep_extend("keep", { val = top_buttons }, startify.config.layout[4])

  require("alpha").setup(startify.config)

  vim.keymap.set("n", "<leader>a", "<CMD>Alpha<CR>", { noremap = true, silent = true, desc = "Startup" })
end

return {
  setup = function(use)
    use {
      "goolord/alpha-nvim",
      requires = { "kyazdani42/nvim-web-devicons" },
      config = config,
    }
  end,
}
