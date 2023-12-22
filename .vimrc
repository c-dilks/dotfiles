" status lines 
set laststatus=2 
set showcmd
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set wildmenu

" emulator title
set titleold=urxvt
set title

" searching
set hlsearch
set incsearch

" syntax highlighting
syntax enable
filetype plugin on

" line numbers
set number relativenumber

" diff options to ignore whitespace
" set diffopt+=iwhite
" set diffexpr=""

" latex
" let g:tex_flavor='latex'
let g:Tex_MultipleCompileFormats='pdf,bib,pdf'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_ViewRule_dvi='xdvi'
let g:Tex_ViewRule_pdf='zathura'
" latex jps
" let g:tex_flavor='xelatex'
" let g:Tex_CompileRule_pdf='xelatex --interaction=nonstopmode $*'

" automatically change pwd to current file's directory
set autochdir

" default indentation (cf. overrides below)
set autoindent " copy indent from current line when starting a new line
set expandtab " enter spaces when tab is pressed
set tabstop=8 " use 2 spaces to represent tab
set shiftwidth=2 " number of spaces to use for auto-indent
set softtabstop=2
set smarttab " insert tabs at beginning of line
set smartindent " C-like auto indentaion
" set cindent " indent using the triggers list in `cinkeys` below
" set cinkeys=0{,0},{,},:

" python indentation
au Filetype python
\ setlocal tabstop=4
\ | setlocal softtabstop=4
\ | setlocal shiftwidth=4
\ | setlocal expandtab
\ | setlocal autoindent
\ | setlocal nosmartindent
\ | setlocal fileformat=unix

" mouse
set mouse=a

" clipboard
let g:clipbrdDefaultReg = '+'

" colour sheme and wrapping
" set background=dark
if has("gui_running")
  set gfn=Monospace\ 12
  set tw=0
  set spell
  set wrap
  set linebreak
  colorscheme slate
else
  " colorscheme black_angus
  " colorscheme neonwave
  " colorscheme wargrey
  colorscheme muon
  " set tw=88
endif
" highlight Comment ctermfg=9

" tagbar
nmap <F5> :TagbarToggle<CR>
highlight TagbarSignature guifg=Magenta ctermfg=Magenta
highlight TagbarHighlight guifg=Black guibg=Green ctermfg=Black ctermbg=Green

" key mappings
map <F8> <C-W><C-W>
map ' <C-W>
map '' <C-W><C-W>
nnoremap <M-j> <C-D>
nnoremap <M-k> <C-U>
nnoremap <M-M> /\v^(\w+\s+)?\w+::\w+\(.*\)
nnoremap <Esc>j <C-D>
nnoremap <Esc>k <C-U>
nnoremap <Esc>m /\v^(\w+\s+)?\w+::\w+\(.*\)
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk
nnoremap gO :!xdg-open <cfile><CR>
nnoremap gR :!rox > /dev/null 2>&1 <cfile><CR>

" reload syntax
nnoremap <F12> :syntax sync fromstart<CR>

" detect changes and auto-reload
set autoread
" au CursorHold,CursorHoldI * checktime


" leader keybindings
let mapleader = "\<Space>"
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>x :x<CR>
nnoremap <Leader>Q :q!<CR>
nnoremap <Leader>n :nohl<CR>
nnoremap <Leader>e :e<CR>
nnoremap <Leader><Leader> <C-w>
" fixes annoying case where you just want to compile latex again, but cursor
" is focused on an error window at the bottom
nnoremap <Leader>;; <C-w><C-w>:call Tex_RunLaTeX()<CR><C-w><C-w>
" compiling
nnoremap <Leader>m :!<Space>make<CR>
nnoremap <Leader>j :! make quick<CR>

" debugger config
packadd termdebug
" let g:termdebug_wide=1 " highlighting is glitchy...
nnoremap <F8> mA:Termdebug %:r.exe<CR><C-w>2j<C-w>H<C-w>l

" asymptote
augroup filetypedetect
au BufNewFile,BufRead *.asy setf asy
augroup END
filetype plugin on
