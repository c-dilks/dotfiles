return {
  'tpope/vim-commentary',
  keys = {{ [[gc]], mode={'n','x'}}},
  config = function()
    vim.cmd([[au FileType cpp setlocal commentstring=//%s]])
  end,
}
