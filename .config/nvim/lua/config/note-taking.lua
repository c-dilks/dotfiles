-- tag name and colors
local tags = {
  {'PRIORITY', 'yellow'     },
  {'TODO',     'red'        },
  {'RUNNING',  'cyan'       },
  {'WAITING',  'magenta'    },
  {'DONE',     'lightgreen' },
}

-- determine the length of the largest tag name
local max_width = 0
for _, tag in ipairs(tags) do
  local len = string.len(tag[1])
  if len > max_width then max_width = len end
end
max_width = max_width + 2

-- keybinding '<Leader>'..tagnumber assigns the tag
for num, tag in ipairs(tags) do
  local name  = tag[1]
  local color = tag[2]
  vim.keymap.set(
    {'n', 'v'},
    [[<Leader>]]..tostring(num),
    string.format([[^dt}dwI- %-]]..max_width..[[s <Esc>^]], '{'..name..'}')
  )
  vim.cmd(string.format([[highlight hi_%s cterm=bold ctermfg=%s guifg=%s]], name, color, color))
  vim.cmd(string.format([[syn keyword hi_%s %s]], name, name))
end

-- keybindings to add and remove a tag
vim.keymap.set({'n', 'v'}, [[<Leader>0]], [[^a {}<Esc>^]])
vim.keymap.set({'n', 'v'}, [[<Leader>9]], [[^f{dt}dw^]])
