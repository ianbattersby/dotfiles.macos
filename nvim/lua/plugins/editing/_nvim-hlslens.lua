local function config()
  require("hlslens").setup {
    build_position_cb = function(plist, bufnr, changedtick, pattern)
      require("scrollbar").search_handler.show(plist.start_pos)
    end,
  }

  vim.cmd [[
		noremap <silent> n <Cmd>execute('normal! ' . v:count1 . 'n')<CR>
			\<Cmd>lua require('hlslens').start()<CR>
		noremap <silent> N <Cmd>execute('normal! ' . v:count1 . 'N')<CR>
			\<Cmd>lua require('hlslens').start()<CR>
		noremap * *<Cmd>lua require('hlslens').start()<CR>
		noremap # #<Cmd>lua require('hlslens').start()<CR>
		noremap g* g*<Cmd>lua require('hlslens').start()<CR>
		noremap g# g#<Cmd>lua require('hlslens').start()<CR>
		nnoremap <silent> <leader>l :noh<CR>

		augroup scrollbar_search_hide
      autocmd!
      autocmd CmdlineLeave : lua require('scrollbar').search_handler.hide()
    augroup END
	]]
end

return {
  setup = function(use)
    use {
      "kevinhwang91/nvim-hlslens",
      after = "nvim-scrollbar",
      config = config,
    }
  end,
}
