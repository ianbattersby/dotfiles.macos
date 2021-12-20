local function config()
  local map = vim.api.nvim_set_keymap
  local options = { noremap = true }

  map("n", "<leader>tt", "<CMD>FloatermNew --autoclose=2 --height=0.9 --width=0.9 --wintype=floating<CR>", options)
end

return {
  setup = function(use)
    use {
      "voldikss/vim-floaterm",
      config = config,
    }
  end,
}
