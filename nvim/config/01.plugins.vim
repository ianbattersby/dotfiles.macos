if exists('*minpac#init')
    packadd minpac

    call minpac#init()

    call minpac#add('k-takata/minpac', {'type': 'opt'})
    "call minpac#add('Shougo/neosnippet.vim')
    "call minpac#add('Shougo/neosnippet-snippets')
    call minpac#add('sheerun/vim-polyglot')
    call minpac#add('editorconfig/editorconfig-vim')
    call minpac#add('Shougo/vimshell')
    call minpac#add('roxma/nvim-yarp')
    call minpac#add('justinmk/vim-sneak')
    call minpac#add('neoclide/coc.nvim', {'branch': 'release', 'do': function('s:coc_cb')})
    call minpac#add('w0rp/ale')
    call minpac#add('rust-lang/rust.vim')
    call minpac#add('mdempsky/gocode')
    "call minpac#add('fatih/vim-go', {'go': 'GoUpdateBinaries'})
    call minpac#add('vim-airline/vim-airline')
    call minpac#add('vim-airline/vim-airline-themes')
    "call minpac#add('chriskempson/base16-vim')
    call minpac#add('morhetz/gruvbox')
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
    call minpac#add('kana/vim-textobj-user')
    call minpac#add('kana/vim-textobj-entire')
endif

" Command mapping
command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()
command! PackStatus packadd minpac | source $MYVIMRC | call minpac#status()

" Helper function for coc
function! s:coc_cb()
  if has('nvim')
    " NOTE: setup a `list` in VimL to supply the Coc `install_extension` func
    " TODO: autogen global_extensions in a var, ie. don't hardcode
    let g:coc_global_extensions = [
          \ 'coc-css',
          \ 'coc-html',
          \ 'coc-json',
          \ 'coc-yank',
          \ 'coc-rust-analyzer'
          \ 'coc-python',
          \ 'coc-eslint',
          \ 'coc-yaml',
          \ 'coc-tsserver'
          \ ]
    call coc#util#install()
    call coc#util#install_extension(g:coc_global_extensions)
  endif
endfunction
