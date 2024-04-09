return {
  'smithbm2316/centerpad.nvim',
  lazy = false,
  config = function()
    vim.keymap.set({'n'}, [[<Leader>z]], [[<Cmd>Centerpad 60 0<CR>]])
  end
}
