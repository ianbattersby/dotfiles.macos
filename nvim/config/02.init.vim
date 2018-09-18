" init.vim contains all of the initialization plugins for vim
" note that this has to be sourced second since dein needs to
" run its scripts first. This contains misc startup settings
" for vim

"let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" Enable syntax highlighting
syntax on

" Fixes backspace
set backspace=indent,eol,start

" Enable line numbers
set nu

" Enable line/column info at bottom
set ruler
set cursorline " highlights current line

set scrolloff=3

" Autoindentation
set ai
filetype indent plugin on

" Copies using system clipboard
set clipboard+=unnamedplus

" Tab = 4 spaces
set tabstop=4
set shiftwidth=4
set sta
set et
set sts=4

" enable mouse support
set mouse=a mousemodel=popup

" markdown file recognition
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" relative line numbers
" Sets relative line numbers in normal mode, absolute line numbers in insert
" mode
set number
set relativenumber

" use ripgreg instead of grep
set grepprg=rg\ --vimgrep

" python executables
let g:python_host_prog = '/usr/local/bin/python2'
let g:python3_host_prog = '/usr/local/bin/python3'

" ruby executables
let g:ruby_host_prog = '/usr/local/bin/ruby'

" Set colors in terminal
" Solarized, dark, with true color support
set termguicolors
set background=dark
"colorscheme NeoSolarized
colorscheme solarized8_high

" Ensure colours work inside tmux
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" Hide key presses
set noshowcmd

" Show hidden characters
set nolist
set listchars=nbsp:¬,extends:»,precedes:«,trail:•

" close vim if only window left is nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" crontab filetype tweak (the way vim normally saves files confuses crontab
" so this workaround allows for editing
au FileType crontab setlocal bkc=yes

set hidden

" terminal settings
autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufLeave term://* stopinsert

" Permanent undo
set undodir=~/.vimdid
set undofile

" from http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
endif

if executable('rg')
    set grepprg=rg\ --no-heading\ --vimgrep
    set grepformat=%f:%l:%c:%m
endif
