-- filetype configs
-- TODO: convert to lua, use filetype plugin and compare with its defaults
vim.cmd([[
" python indentation
au Filetype python
      \ setlocal tabstop=4
      \ | setlocal softtabstop=4
      \ | setlocal shiftwidth=4
      \ | setlocal expandtab
      \ | setlocal autoindent
      \ | setlocal nosmartindent
      \ | setlocal fileformat=unix
" latex
au Filetype tex,markdown
      \ set tw=0
      \ | set spell
      \ | set wrap
      \ | set linebreak
" asymptote
augroup filetypedetect
au BufNewFile,BufRead *.asy setf asy
augroup END
filetype plugin on
]])
