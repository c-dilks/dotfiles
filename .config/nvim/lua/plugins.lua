-- vim-plug
local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')
Plug('junegunn/vim-easy-align')
Plug('tpope/vim-commentary')
Plug('junegunn/fzf', {['do'] = vim.fn['fzf#install']})
Plug('junegunn/fzf.vim')
Plug('c-dilks/vim-colorschemes', {branch = 'custom'})
Plug('vim-crystal/vim-crystal')
Plug('nvim-tree/nvim-web-devicons')
Plug('sindrets/diffview.nvim')
Plug('lervag/vimtex')
Plug('backdround/improved-search.nvim')
vim.call('plug#end')

-- commentary: comment styles
vim.cmd([[au FileType cpp setlocal commentstring=//%s]])

-- fzf
vim.api.nvim_set_var('fzf_preview_window', {'up:40%', 'ctrl-/'})
vim.api.nvim_set_var('fzf_action', {
  ['ctrl-t'] = 'tab split',
  ['ctrl-x'] = 'split',
  ['ctrl-v'] = 'vsplit',
})
leader_commands('n', {
  o = [[Files!]],
  m = [[Marks!]],
  t = [[BTags!]],
  T = [[BTags! <C-R><C-W>]],
  s = [[Tags!]],
  S = [[Tags! <C-R><C-W>]],
  r = [[Rg!]],
  R = [[Rg! <C-R><C-W>]],
  l = [[BLines!]],
  b = [[Buffers]],
})

-- improved-search
local search = require('improved-search')
vim.keymap.set({'n', 'x', 'o'}, 'n', search.stable_next)
vim.keymap.set({'n', 'x', 'o'}, 'N', search.stable_previous)
vim.keymap.set('n', '*', search.current_word_strict) -- search wihtout moving
vim.keymap.set('x', '*', search.in_place) -- search selections

-- vim-easy-align
vim.keymap.set({'n','x'}, 'ga', '<Plug>(EasyAlign)')

-- vim-crystal
vim.api.nvim_set_var('crystal_define_mappings', 0) -- disable vim-crystal tool keybindings (conflicts with other plugins)

-- vimtex
vim.api.nvim_set_var('vimtex_view_method',     'zathura')
vim.api.nvim_set_var('vimtex_mappings_prefix', '<Leader>v')
