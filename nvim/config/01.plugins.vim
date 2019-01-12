" Required:
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/.cache/dein')
	call dein#begin('~/.cache/dein')

	" Let dein manage dein
	" Required:
	call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

	" Add or remove your plugins here:
    "call dein#add('Shougo/neosnippet.vim')
    "call dein#add('Shougo/neosnippet-snippets')
	call dein#add('sheerun/vim-polyglot')
	call dein#add('Shougo/vimshell')
    call dein#add('roxma/nvim-yarp')
    call dein#add('ncm2/ncm2')
    call dein#add('ncm2/ncm2-bufword')
    call dein#add('ncm2/ncm2-tmux')
    call dein#add('ncm2/ncm2-path')
    call dein#add('ncm2/ncm2-tern') "Javascript
    call dein#add('ncm2/ncm2-jedi') "Python
    call dein#add('ncm2/ncm2-racer') "Rust
    call dein#add('ncm2/ncm2-vim')
    call dein#add('ncm2/ncm2-go')
    call dein#add('w0rp/ale')
    call dein#add('rust-lang/rust.vim')
    call dein#add('mdempsky/gocode', {'rtp': 'nvim/'})
    call dein#add('fatih/vim-go', {'build': 'GoUpdateBinaries'})
	call dein#add('vim-airline/vim-airline')
	call dein#add('vim-airline/vim-airline-themes')
	call dein#add('scrooloose/nerdtree')
    call dein#add('chriskempson/base16-vim')
	call dein#add('tmhedberg/SimpylFold')
	call dein#add('Konfekt/FastFold')
    call dein#add('/usr/local/opt/fzf')
    call dein#add('junegunn/fzf.vim')
	call dein#add('alaric/neovim-visor')
	call dein#add('christoomey/vim-tmux-navigator')
	call dein#add('autozimu/LanguageClient-neovim', {
				\ 'rev': 'next',
				\ 'build': 'bash install.sh',
				\ })
    call dein#add('machakann/vim-highlightedyank')

	" Required:
	call dein#end()
	call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
	call dein#install()
endif

"End dein Scripts-------------------------
