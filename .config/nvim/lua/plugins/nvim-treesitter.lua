return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    lazy = false,
    config = function()
      require('nvim-treesitter.install').compilers = {'gcc'} -- since ifarm `cc` is ancient
      require('nvim-treesitter.configs').setup({
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = true,
          disable = {
            'markdown', -- since spellchecking is too agressive when tree-sitter is used
          },
        },
        indent = {
          enable = false,
          disable = {
            'c',
            'cpp',
          },
        },
      })
    end,
  },
  {
    'HiPhish/rainbow-delimiters.nvim',
    lazy = false,
  }
}
