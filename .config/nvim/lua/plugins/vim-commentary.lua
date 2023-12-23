return {
  'tpope/vim-commentary',
  lazy = false,
  config = function()
    vim.cmd([[au FileType cpp setlocal commentstring=//%s]])
  end,
}
