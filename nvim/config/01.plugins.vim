if exists('*minpac#init')
    packadd minpac

    call minpac#init()

    call minpac#add('k-takata/minpac', {'type': 'opt'})
    "call minpac#add('Shougo/neosnippet.vim')
    "call minpac#add('Shougo/neosnippet-snippets')
    call minpac#add('sheerun/vim-polyglot')
    call minpac#add('Shougo/vimshell')
    call minpac#add('roxma/nvim-yarp')
    call minpac#add('ncm2/ncm2')
    call minpac#add('ncm2/ncm2-bufword')
    call minpac#add('ncm2/ncm2-tmux')
    call minpac#add('ncm2/ncm2-path')
    call minpac#add('ncm2/ncm2-tern') "Javascript
    call minpac#add('ncm2/ncm2-jedi') "Python
    call minpac#add('ncm2/ncm2-racer') "Rust
    call minpac#add('Shougo/neco-vim') "ncm2-vim needs this
    call minpac#add('ncm2/ncm2-vim')
    call minpac#add('ncm2/ncm2-go')
    call minpac#add('w0rp/ale')
    call minpac#add('rust-lang/rust.vim')
    call minpac#add('mdempsky/gocode')
    call minpac#add('fatih/vim-go', {'go': 'GoUpdateBinaries'})
    call minpac#add('vim-airline/vim-airline')
    call minpac#add('vim-airline/vim-airline-themes')
    call minpac#add('chriskempson/base16-vim')
    call minpac#add('tmhedberg/SimpylFold')
    call minpac#add('Konfekt/FastFold')
    call minpac#add('junegunn/fzf')
    call minpac#add('junegunn/fzf.vim')
    call minpac#add('christoomey/vim-tmux-navigator')
    call minpac#add('autozimu/LanguageClient-neovim', {
                \ 'rev': 'next',
                \ 'do': '!bash install.sh',
                \ })
    call minpac#add('machakann/vim-highlightedyank')
    call minpac#add('kassio/neoterm')
    call minpac#add('janko-m/vim-test')
    call minpac#add('mhinz/neovim-remote')
    call minpac#add('tpope/vim-commentary')
endif

" Command mapping
command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()
command! PackStatus packadd minpac | source $MYVIMRC | call minpac#status()
