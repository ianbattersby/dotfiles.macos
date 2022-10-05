local function config()
  vim.keymap.set(
    "n",
    "<leader>\\",
    "<CMD>FloatermNew --autoclose=2 --height=0.9 --width=0.9 --wintype=floating<CR>",
    { noremap = true, silent = true, desc = "Terminal" }
  )
end

return {
  setup = function(use)
    use {
      "voldikss/vim-floaterm",
      config = config,
    }
  end,
}
