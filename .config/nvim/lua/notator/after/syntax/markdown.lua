for _, notation in ipairs(require('notator').config.notation_table) do
  vim.cmd([[highlight]]
  .. [[ hi_]]      .. notation.name
  .. [[ cterm=]]   .. notation.style
  .. [[ ctermfg=]] .. notation.color
  .. [[ guifg=]]   .. notation.color
  )
  vim.cmd([[syntax keyword]]
  .. [[ hi_]] .. notation.name
  .. [[ ]]    .. notation.name
  )
end
