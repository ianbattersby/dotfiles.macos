let g:ale_completion_enabled = 0
let g:ale_linters_explicit = 1
let g:ale_sign_column_always = 1
let g:ale_lint_on_text_changed = 'always'
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 1
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'

let g:ale_linters = {
        \ 'bash': ['language-server', 'shellcheck'],
        \ 'go': ['gometalinter', 'gofmt'],
        \ 'rust': ['cargo', 'rls'],
        \ 'json': ['jq' ],
        \ 'yaml': ['yamllint']
    \ }

" Rust
let g:ale_rust_cargo_use_check = 1
let g:ale_rust_catgo_check_all_targets = 1

