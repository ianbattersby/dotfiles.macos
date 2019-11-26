let g:ale_completion_enabled = 0
let g:ale_linters_explicit = 1
let g:ale_sign_column_always = 1
let g:ale_lint_on_text_changed = 'always'
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 1
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'
let g:ale_sign_info = '⇥'

let g:ale_linters = {
        \ 'asciidoc': ['vale'],
        \ 'bash': ['language-server', 'shellcheck'],
        \ 'dart': ['dartanalyzer', 'dartfmt', 'language_server'],
        \ 'dockerfile': ['hadolint'],
        \ 'gitcommit': ['gitlint'],
        \ 'go': ['golangci-lint', 'gofmt'],
        \ 'json': ['jq' ],
        \ 'markdown': ['vale'],
        \ 'rust': ['rls'],
        \ 'rst': ['vale'],
        \ 'terraform': ['terraform-fmt'],
        \ 'tex': ['vale'],
        \ 'text': ['vale'],
        \ 'yaml': ['yamllint'],
    \ }

" Highlight colours
highlight ALEWarning ctermbg=10 ctermfg=226 guifg=#333333 guibg=#ffff99
highlight ALEWarningSign ctermbg=10 ctermfg=226 guifg=#ffff09 guibg=#181818
highlight ALEError ctermbg=10 ctermfg=52 guifg=#dddddd guibg=#990033
highlight ALEErrorSign ctermbg=10 ctermfg=52 guifg=#990033 guibg=#181818
highlight ALEInfo ctermbg=10 ctermfg=255 guifg=#eeeeee guibg=#aaaaaa
highlight ALEInfoSign ctermbg=10 ctermfg=255 guifg=#aaaaaa guibg=#181818

" Rust
let g:ale_rust_cargo_use_check = 1
let g:ale_rust_cargo_check_all_targets = 1
let g:ale_rust_rls_toolchain = 'nightly'
