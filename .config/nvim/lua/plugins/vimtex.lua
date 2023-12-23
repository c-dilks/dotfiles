return {
  'lervag/vimtex',
  ft = 'tex',
  config = function()
    vim.api.nvim_set_var('vimtex_view_method',     'zathura')
    vim.api.nvim_set_var('vimtex_mappings_prefix', '<Leader>v')
  end
}
