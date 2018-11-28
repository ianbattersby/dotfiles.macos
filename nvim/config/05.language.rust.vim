let g:rustfmt_command = "rustfmt +nightly"
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0
let g:rust_clip_command = "pbcopy"

let $RUST_SRC_PATH = systemlist("rustc --print sysroot")[0] . "/lib/rustlib/src/rust/src"

augroup cmdheight_rust
  au!
  autocmd BufNewFile,BufRead *.rs set cmdheight=5
augroup END

" Follow Rust code style rules
au Filetype rust set colorcolumn=100
