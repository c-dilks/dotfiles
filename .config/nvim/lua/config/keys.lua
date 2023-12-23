-- leader keybindings
vim.g.mapleader = [[ ]]
function leader_commands(modes, bind_table)
  for key, bind in pairs(bind_table) do
    vim.keymap.set(modes, [[<Leader>]]..key, [[<Cmd>]]..bind..[[<CR>]])
  end
end
leader_commands({'n', 'v'}, {
  w = [[w]],
  q = [[q]],
  x = [[x]],
  X = [[xa]],
  Q = [[q!]],
  n = [[nohl]],
  e = [[e]],
})

-- page up, down, left, right
for key, bind in pairs({
  k = [[<C-U>]],
  j = [[<C-D>]],
  h = [[10zh]],
  l = [[10zl]],
}) do
  vim.keymap.set({'n','v'}, [[<M-]]..key..[[>]], bind)
  vim.keymap.set({'n'},     [[<Esc>]]..key,      bind)
end

-- window switching
vim.keymap.set('', [[']],  [[<C-W>]])
vim.keymap.set('', [['']], [[<C-W><C-W>]])
vim.keymap.set('', [[<Leader><Leader>]], [[<C-w>]])

-- reload syntax
vim.keymap.set({'n', 'v'}, [[<F12>]], [[:syntax sync fromstart<CR>]])

-- yank to system clipboard upon mouse selection
vim.keymap.set('v', [[<LeftRelease>]], [["*ygv]])
