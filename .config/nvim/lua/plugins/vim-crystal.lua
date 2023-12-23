return {
  'vim-crystal/vim-crystal',
  ft = crystal,
  config = function()
    -- disable vim-crystal tool keybindings (conflicts with other plugins)
    vim.api.nvim_set_var('crystal_define_mappings', 0)
  end,
}
