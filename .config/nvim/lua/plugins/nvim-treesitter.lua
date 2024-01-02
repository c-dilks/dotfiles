return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    lazy = false,
    config = function()
      require('nvim-treesitter.configs').setup({
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = true,
        },
        indent = {
          enable = false,
          disable = {'c', 'cpp'},
        },
      })
    end,
  },
  {
    'HiPhish/rainbow-delimiters.nvim',
    lazy = false,
  }
}