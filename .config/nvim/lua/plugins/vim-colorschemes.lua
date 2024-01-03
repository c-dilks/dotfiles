return {
  'c-dilks/vim-colorschemes',
  branch   = 'custom',
  lazy     = false,
  priority = 1000,
  config   = function()
    vim.cmd([[colorscheme lizard256]])
  end,
}
