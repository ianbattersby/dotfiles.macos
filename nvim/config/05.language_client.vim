" language_client.vim contains vim settings specific to the language
" client plugin

" language server commands
" \ 'rust': ['rustup', 'run', 'stable', 'rls'],
" \ 'cpp': ['cquery', '--log-file=/tmp/cq.log'],
" \ 'cpp': ['clangd'],
let g:LanguageClient_serverCommands = {
            \ 'cpp': ['cquery', '--log-file=/tmp/cq.log'],
            \ 'c': ['cquery', '--log-file=/tmp/cq.log'],
            \ 'python': ['/usr/local/bin/pyls', '--log-file', '/tmp/pyls3.log', '-v'],
            \ 'rust': ['env', 'CARGO_TARGET_DIR=/users/ian/.cargo/bin/rls', 'rls'],
            \ 'haskell': ['hie-wrapper', '--lsp']
            \ }
            "\ 'rust': ['rustup', 'run', 'stable', 'rls'],
let g:LanguageClient_autoStart = 1

set completefunc=LanguageClient#complete
set formatexpr=LanguageClient_textDocument_rangeFormatting()

let g:LanguageClient_loadSettings = 1
let g:LanguageClient_settingsPath = '/Users/ian/.config/nvim/settings.json'
