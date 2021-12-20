return {
  setup = function()
    local opt = vim.opt -- to set options
    vim.g.mapleader = " "
    opt.autoindent = true
    opt.cmdheight = 1
    opt.backspace = { "indent", "eol", "start" }
    opt.clipboard = "unnamedplus"
    opt.completeopt = "menu,menuone,noselect"
    opt.cursorline = true
    opt.cursorcolumn = false
    opt.ruler = true
    opt.encoding = "utf-8" -- Set default encoding to UTF-8
    opt.expandtab = true -- Use spaces instead of tabs
    opt.foldenable = false
    opt.foldmethod = "indent"
    opt.formatoptions = "l"
    opt.hidden = true -- Enable background buffers
    opt.hlsearch = true -- Highlight found searches
    opt.ignorecase = true -- Ignore case
    opt.inccommand = "split" -- Get a preview of replacements
    opt.incsearch = true -- Shows the match while typing
    opt.joinspaces = false -- No double spaces with join
    vim.o.lazyredraw = true
    opt.linebreak = true -- Stop words being broken on wrap
    opt.number = true -- Show line numbers
    opt.list = true -- Show some invisible characters
    opt.listchars = { tab = " ", trail = "·" }
    opt.relativenumber = true
    opt.scrolloff = 4 -- Lines of context
    opt.shiftround = true -- Round indent
    opt.shiftwidth = 4 -- Size of an indent
    vim.o.shortmess = vim.o.shortmess .. "c"
    opt.showmode = false -- Don't display mode
    opt.showcmd = false
    opt.sidescrolloff = 8 -- Columns of context
    opt.signcolumn = "yes:1" -- always show signcolumns
    opt.smartcase = true -- Do not ignore case with capitals
    opt.smartindent = true -- Insert indents automatically
    opt.spelllang = { "en_gb" }
    opt.splitbelow = true -- Put new windows below current
    opt.splitright = true -- Put new windows right of current
    opt.tabstop = 4 -- Number of spaces tabs count for
    opt.softtabstop = 4
    --opt.termguicolors = true -- You will have bad experience for diagnostic messages when it's default 4000.
    vim.o.whichwrap = vim.o.whichwrap .. "<,>" -- Wrap movement between lines in edit mode with arrows
    opt.wrap = false
    -- opt.cc = "80"
    opt.mouse = "a"
    opt.mousemodel = "popup"
    opt.guicursor =
      "n-v-c-sm:block-blinkwait50-blinkon50-blinkoff50,i-ci-ve:ver25-Cursor-blinkon100-blinkoff100,r-cr-o:hor20"
    opt.undodir = vim.fn.stdpath "data" .. "/undo"
    opt.undofile = true
    vim.cmd "au TextYankPost * lua vim.highlight.on_yank {on_visual = true}"
    -- Give me some fenced codeblock goodness
    vim.g.markdown_fenced_languages = { "html", "javascript", "typescript", "css", "scss", "lua", "vim" }
    opt.grepprg = "rg --vimgrep --no-heading"
    opt.grepformat = "%f:%l:%c:%m"
    vim.g.python_host_prog = "/usr/local/bin/python"
    vim.g.python3_host_prog = "/usr/local/bin/python3"
    vim.g.ruby_host_prog = "/usr/local/bin/ruby"

    vim.cmd [[
			set ai
			filetype indent plugin on
			syntax enable
		]]
  end,
}
