--[[ map '<Leader>'..key to a command
opts = {
  modes: modes for these keybindings
  lazy:  if true, return table for lazy.nvim spec
  keys:  the keybindings table { key -> command }
}
--]]
function leader_commands(opts)
  local modes = opts.modes or {'n'}
  local lazy  = opts.lazy_syntax  or false
  local lazy_keys = {}
  for key, bind in pairs(opts.keys) do
    local _key  = [[<Leader>]]..key
    local _bind = [[<Cmd>]]..bind..[[<CR>]]
    if lazy then
      table.insert(lazy_keys, { _key, _bind, mode=modes })
    else
      vim.keymap.set(modes, _key, _bind)
    end
  end
  if lazy then return lazy_keys end
end

-- leader keybindings
vim.g.mapleader = [[ ]]
leader_commands({
  modes = {'n', 'v'},
  keys = {
    w = [[w]],
    q = [[q]],
    x = [[x]],
    X = [[xa]],
    Q = [[qa]],
    n = [[nohl]],
    e = [[e]],
  },
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
vim.keymap.set({'n','v'}, [[<PageUp>]], [[<C-U>]])
vim.keymap.set({'n','v'}, [[<PageDown>]], [[<C-D>]])
vim.keymap.set({'n','v'}, [[<S-Tab>]], [[<C-U>]])
vim.keymap.set({'n','v'}, [[<Tab>]], [[<C-D>]])

-- jump to beginning or end of line in insert mode (also works for normal mode)
vim.keymap.set({'i','n'}, [[<M-a>]], [[<Esc>A]])
vim.keymap.set({'i','n'}, [[<M-i>]], [[<Esc>I]])

-- window switching
for idx, key in ipairs({'h', 'j', 'k', 'l'}) do
  vim.keymap.set('', [[<C-]]..key..[[>]], [[<C-w>]]..key)
end
vim.keymap.set('', [[']],  [[<C-W>]])
vim.keymap.set('', [['']], [[<C-W><C-W>]])
vim.keymap.set('', [[<Leader><Leader>]], [[<C-w>]])

-- toggle spellcheck
vim.keymap.set({'n', 'v'}, [[<F10>s]], function()
  vim.o.spell = not vim.o.spell
  if vim.o.spell then
    vim.notify('enable spellcheck')
  else
    vim.notify('disable spellcheck')
  end
end)

-- toggle whitespace diffs
vim.keymap.set({'n', 'v'}, [[<F10>w]], function()
  if vim.o.diffopt:find('iwhiteall') then
    vim.notify('show whitespace diffs')
    vim.cmd('set diffopt-=iwhiteall')
  else
    vim.notify('ignore whitespace diffs')
    vim.cmd('set diffopt+=iwhiteall')
  end
end)

-- reload syntax
vim.keymap.set({'n', 'v'}, [[<F12>]], [[<Cmd>syntax sync fromstart<CR>]])

-- yank to system clipboard upon mouse selection
vim.keymap.set('v', [[<LeftRelease>]], [["*ygv]])
