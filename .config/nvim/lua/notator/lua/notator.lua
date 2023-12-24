local M = {}

-- defaults
local DEFAULT_CONFIG = {
  notation_table = {
    { name = 'TODO',  color = 'red'        },
    { name = 'FIXME', color = 'yellow'     },
    { name = 'DONE',  color = 'lightgreen' },
  },
  keybindings = {},
  fixed_width = false,
}

local DEFAULT_KEYBINDINGS = {
  add_notation      = [[<Leader>0]],
  remove_notation   = [[<Leader>9]],
  move_to_beginning = [[<Leader>8]],
}

local DEFAULT_STYLES = {
  color = 'red',
  style = 'bold',
  key   = 'default',
}

-- setup
function M.setup(config)
  M.config = config

  -- check the configuration and set defaults
  for key, def in pairs(DEFAULT_CONFIG) do
    if M.config[key] == nil then M.config[key] = def end
  end

  for key, def in pairs(DEFAULT_KEYBINDINGS) do
    if M.config.keybindings[key] == nil then M.config.keybindings[key] = def end
  end

  for num, notation in ipairs(M.config.notation_table) do
    if notation['name'] == nil then notation['name'] = [[NOTE]]..tostring(num) end
    for key, def in pairs(DEFAULT_STYLES) do
      if notation[key] == nil then notation[key] = def end
    end
  end

  -- determine the length of the largest notation (for fixed width notations)
  local notation_width = 0
  if M.config.fixed_width then
    for _, notation in ipairs(M.config.notation_table) do
      local len = string.len(notation.name)
      if len > notation_width then notation_width = len end
    end
    notation_width = notation_width + 2
  end

  -- keybindings to assign notations
  for num, notation in ipairs(M.config.notation_table) do
    local key = [[<Leader>]]..tostring(num)
    if notation.key ~= 'default' then
      key = notation.key
    end
    vim.keymap.set(
      {'n', 'v'},
      key,
      string.format([[^dt}dwI- %-]]..notation_width..[[s <Esc>^f}w]], '{'..notation.name..'}')
      )
  end

  -- additional keybindings
  vim.keymap.set(
    {'n', 'v'},
    M.config.keybindings.add_notation,
    [[^a {]]..M.config.notation_table[1].name..[[}<Esc>^f}w]]
    )
  vim.keymap.set(
    {'n', 'v'},
    M.config.keybindings.remove_notation,
    [[^f{dt}dw^w]]
    )
  vim.keymap.set(
    {'n', 'v'},
    M.config.keybindings.move_to_beginning,
    [[^f}w]]
    )

end

return M
