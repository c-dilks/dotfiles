require('config.settings')
require('config.filetypes')
require('config.keys')
require('config.lazy')

-- transparent bg
vim.cmd('highlight Normal guibg=none')
vim.cmd('highlight NonText guibg=none')
vim.cmd('highlight Normal ctermbg=none')
vim.cmd('highlight NonText ctermbg=none')
