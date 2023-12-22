-- colorscheme, from plugin 'c-dilks/vim-colorschemes'
vim.cmd([[
if has("gui_running")
  set gfn=Monospace\ 12
  colorscheme black_angus
  set tw=80
  set spell
else
  colorscheme adventurous
endif
]])
