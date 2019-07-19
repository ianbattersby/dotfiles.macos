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
            \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
            \ 'haskell': ['hie-wrapper', '--lsp']
            \ }
            "\ 'go': [$GOPATH . '/bin/go-langserver', '-gocodecompletion']
            "\ 'rust': ['env', 'CARGO_TARGET_DIR=~/.cargo/bin/rls', 'rls'],
            "\ 'rust': ['rustup', 'run', 'stable', 'rls'],

let g:LanguageClient_diagnosticsDisplay = {
            \ 1: {
            \   "name": "Error",
            \   "texthl": "ALEError",
            \   "signText": "✖",
            \   "signTexthl": "ALEErrorSign",
            \ },
            \ 2: {
            \   "name": "Warning",
            \   "texthl": "ALEWarning",
            \   "signText": "⚠",
            \   "signTexthl": "ALEWarningSign",
            \ },
            \ 3: {
            \   "name": "Information",
            \   "texthl": "ALEInfo",
            \   "signText": "⇥",
            \   "signTexthl": "ALEInfoSign",
            \ },
            \ 4: {
            \   "name": "Hint",
            \   "texthl": "ALEInfo",
            \   "signText": "➤",
            \   "signTexthl": "ALEInfoSign",
            \ },
            \ }

let g:LanguageClient_autoStart = 1
let g:LanguageClient_diagnosticsEnable = 1

set completefunc=LanguageClient#complete
set formatexpr=LanguageClient_textDocument_rangeFormatting()

let g:LanguageClient_loadSettings = 1
let g:LanguageClient_settingsPath = '~/.config/nvim/settings.json'
