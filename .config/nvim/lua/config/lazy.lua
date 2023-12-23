-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath) -- add to runtime path

-- plugins
require('lazy').setup({
  { 'c-dilks/vim-colorschemes', branch = 'custom'},
  { 'junegunn/vim-easy-align' },
  { 'tpope/vim-commentary' },
  { 'vim-crystal/vim-crystal' },
  { 'junegunn/fzf', run = './install --all' },
  { 'junegunn/fzf.vim' },
  { 'nvim-tree/nvim-web-devicons' },
  { 'sindrets/diffview.nvim' },
  { 'lervag/vimtex' },
  { 'backdround/improved-search.nvim' },
})

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

-- vim-easy-align
vim.keymap.set({'n','x'}, 'ga', '<Plug>(EasyAlign)')

-- commentary: comment styles
vim.cmd([[au FileType cpp setlocal commentstring=//%s]])

-- vim-crystal
vim.api.nvim_set_var('crystal_define_mappings', 0) -- disable vim-crystal tool keybindings (conflicts with other plugins)

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

-- vimtex
vim.api.nvim_set_var('vimtex_view_method',     'zathura')
vim.api.nvim_set_var('vimtex_mappings_prefix', '<Leader>v')
