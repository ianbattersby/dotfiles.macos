lua require('nvim-lsp-keybindings')

" Use C-Space to Esc out of any mode
nnoremap <C-Space> <Esc>:noh<CR>
vnoremap <C-Space> <Esc>gV
onoremap <C-Space> <Esc>
cnoremap <C-Space> <C-c>
inoremap <C-Space> <Esc>

" Terminal sees <C-@> as <C-space>
nnoremap <C-@> <Esc>:noh<CR>
vnoremap <C-@> <Esc>gV
onoremap <C-@> <Esc>
cnoremap <C-@> <C-c>
inoremap <C-@> <Esc>

" Quick sourcing of the current file, allowing for quick vimrc testing
nnoremap <leader>sop :source %<cr>

" Files and buffers
map <C-p> :Files<CR>
nmap <leader>; :Buffers<CR>

" Quick-save
nmap <leader>w :w<CR>

" split pane navigation
nnoremap <A-j> <C-W>j
nnoremap <A-k> <C-W>k
nnoremap <A-l> <C-W>l
nnoremap <A-h> <C-W>h

" Delete trailing whitespace with F5
nnoremap <silent> <F5> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

" nerdtree
" autocmd vimenter * NERDTree " start nerdtree automatically when vim starts up
"map <C-n> :NERDTreeToggle<CR>

" keybindings for language client
" nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
" nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
" nnoremap <silent> gr :call LanguageClient_textDocument_references()<CR>
" nnoremap <silent> gs :call LanguageClient_textDocument_documentSymbol()<CR>
" nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
" nnoremap <silent> gf :call LanguageClient_textDocument_codeAction()<CR>

" ALE
nmap <F8> <Plug>(ale_fix)

" fzf
noremap <leader>s :Rg
nnoremap <C-s> :Rg<CR>

" Telescope
"nnoremap <leader>ff <cmd>Telescope find_files<cr>
"nnoremap <leader>fg <cmd>Telescope live_grep<cr>
"nnoremap <leader>fb <cmd>Telescope buffers<cr>
"nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" change working directory to where the file in the buffer is located
" if user types `,cd`
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>

" ALT-[ exits in terminal mode (tnoremap - terminal remap mode)
tnoremap <A-\> <C-\><C-n><C-w><C-p>
tnoremap <expr> <A-r> '<C-\><C-n>"'.nr2char(getchar()).'pi'<Paste>
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l

" Easy most-recent-buffer switching
"nnoremap <Tab> :buffers<CR>:buffer<Space>
nnoremap <Tab> :Buffers<CR>
nnoremap <silent> <S-tab> :Buffers<CR><CR>

" vim-test mappings
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

" Circumvent OS X hash issue
imap <silent> <A-3> <C-v>035
