vim.cmd [[packadd packer.nvim]]

-- vim._update_package_paths()

return require('packer').startup(function()
  use {'wbthomason/packer.nvim', opt = true}
  use {'k-takata/minpac', opt = true}
  use {'sheerun/vim-polyglot'}
  use {'editorconfig/editorconfig-vim'}
  use {'Shougo/vimshell'}
  use {'roxma/nvim-yarp'}
  use {'justinmk/vim-sneak'}
  use {'neoclide/coc.nvim', branch = 'release'}
  use {'rust-lang/rust.vim'}
  use {'mdempsky/gocode'}
  use {'vim-airline/vim-airline'}
  use {'vim-airline/vim-airline-themes'}
  use {'morhetz/gruvbox'}
  use {'tmhedberg/SimpylFold'}
  use {'Konfekt/FastFold'}
  use {'junegunn/fzf'}
  use {'junegunn/fzf.vim'}
  use {'neovim/nvim-lspconfig'}
  use {'machakann/vim-highlightedyank'}
  -- use {'kassio/neoterm'}
  use {'janko-m/vim-test'}
  use {'mhinz/neovim-remote'}
  use {'tpope/vim-commentary'}
  use {'kana/vim-textobj-user'}
  use {'kana/vim-textobj-entire'}
  use {'christoomey/vim-tmux-navigator'}

  use {
    'w0rp/ale',
    ft = {'sh', 'zsh', 'bash', 'c', 'cpp', 'cmake', 'html', 'markdown', 'racket', 'vim', 'tex'},
    cmd = 'ALEEnable',
    config = 'vim.cmd[[ALEEnable]]'
  }

  -- use {
  --   'nvim-lua/telescope.nvim',
  --   requires = {{ 'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim' }}
  -- }

  -- Lazy loading:
  -- Load on specific commands
  -- use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}

  -- Load on an autocommand event
  -- use {'andymass/vim-matchup', event = 'VimEnter *'}
end)
