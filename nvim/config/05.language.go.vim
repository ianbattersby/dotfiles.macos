let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1

" Show type information
let g:go_auto_type_info = 1

" Highlight variable uses
let g:go_auto_sameids = 1

" Add the failing test name to the output of :GoTest
let g:go_test_show_name = 1

" Set whether the JSON tags should be snakecase or camelcase.
let g:go_addtags_transform = "snakecase"

" Run goimports when running gofmt
let g:go_fmt_command = "goimports"

" Set neosnippet as snippet engine
let g:go_snippet_engine = "neosnippet"

" Show the progress when running :GoCoverage
let g:go_echo_command_info = 1

" Go bin path
let g:go_bin_path = expand("~/code/go/bin")

" Editor
au FileType go set noexpandtab
au FileType go set shiftwidth=4
au FileType go set softtabstop=4
au FileType go set tabstop=4

" gometalinter configuration
" let g:go_metalinter_command = ""
" let g:go_metalinter_deadline = "5s"
" let g:go_metalinter_enabled = [
"     \ 'deadcode',
"     \ 'errcheck',
"     \ 'dupl',
"     \ 'gochecknoglobals',
"     \ 'gochecknoinits',
"     \ 'goconst',
"     \ 'gocyclo',
"     \ 'gofmt',
"     \ 'goimports',
"     \ 'golint',
"     \ 'gosec',
"     \ 'gosimple',
"     \ 'gotype',
"     \ 'gotypex',
"     \ 'ineffassign',
"     \ 'interfacer',
"     \ 'lll',
"     \ 'maligned',
"     \ 'megacheck',
"     \ 'misspell',
"     \ 'nakedret',
"     \ 'structcheck',
"     \ 'varcheck',
"     \ 'vet',
"     \ 'vetshadow'
" \]

" Keybindings
au FileType go nmap <F8> :GoMetaLinter<cr>
au FileType go nmap <F9> :GoCoverageToggle -short<cr>
au FileType go nmap <F10> :GoTest -short<cr>
au FileType go nmap <F12> <Plug>(go-def)
au Filetype go nmap <leader>ga <Plug>(go-alternate-edit)
au Filetype go nmap <leader>gah <Plug>(go-alternate-split)
au Filetype go nmap <leader>gav <Plug>(go-alternate-vertical)
au FileType go nmap <leader>gt :GoDeclsDir<cr>
au FileType go nmap <leader>gc <Plug>(go-coverage-toggle)
au FileType go nmap <leader>gd <Plug>(go-def)
au FileType go nmap <leader>gdv <Plug>(go-def-vertical)
au FileType go nmap <leader>gdh <Plug>(go-def-split)
au FileType go nmap <leader>gD <Plug>(go-doc)
au FileType go nmap <leader>gDv <Plug>(go-doc-vertical)
