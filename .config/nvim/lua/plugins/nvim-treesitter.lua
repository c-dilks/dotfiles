return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    lazy = false,
    config = function()
      require('nvim-treesitter.install').compilers = {'gcc'} -- since ifarm `cc` is ancient
      require('nvim-treesitter.configs').setup({
        ensure_installed = { 'c', 'lua', 'vim', 'vimdoc', 'query' },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = false, -- too many issues at the moment...
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
