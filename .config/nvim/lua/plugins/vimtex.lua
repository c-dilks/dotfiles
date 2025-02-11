return {
  'lervag/vimtex',
  ft = 'tex',
  config = function()

    -- Ensure VimTeX is installed and loaded
    vim.g.vimtex_compiler_latexmk = {
      callback = 1,
      continuous = 0,
      executable = 'latexmk',
      options = {
        '-pdf',
        '-shell-escape',
        '-verbose',
        '-file-line-error',
        '-synctex=1',
        '-f',
      },
    }

    -- NOTE: for keybindings, run :help vimtex-default-mappings
    vim.g.vimtex_mappings_prefix = '<Leader>l' -- maps '<Leader>l' -> '\l'
    vim.g.vimtex_view_method = 'zathura'
  end
}
