-- general settings
vim.o.number         = true  -- line numbers
vim.o.relativenumber = true  -- relative line numbers
vim.o.title          = true  -- show filename in title
vim.o.autoread       = true  -- detect changes and auto-reload
vim.o.wrap           = false -- enable sidescrolling
vim.o.sidescroll     = 1     -- smooth sidescrolling
vim.o.scrolloff      = 5     -- don't let the cursor be less than this many lines away from the top or bottom
vim.o.mouse          = 'a'   -- enable mouse in all modes

-- indentation
vim.o.autoindent  = true -- copy indent from current line when starting a new line
vim.o.expandtab   = true -- enter spaces when tab is pressed
vim.o.tabstop     = 8    -- use 2 spaces to represent tab
vim.o.shiftwidth  = 2    -- number of spaces to use for auto-indent
vim.o.softtabstop = 2
vim.o.smarttab    = true -- insert tabs at beginning of line
vim.o.smartindent = true -- C-like auto indentaion
