-- options
local fixed_width = false -- fixed-width tags or not

-- tag name
local tags = {
  'PRIORITY',
  'TODO',
  'RUNNING',
  'WAITING',
  'DONE',
}

-- determine the length of the largest tag name (for fixed width tags)
local tag_width = 0
if fixed_width then
  for _, tag in ipairs(tags) do
    local len = string.len(tag)
    if len > tag_width then tag_width = len end
  end
  tag_width = tag_width + 2
end

-- keybinding '<Leader>'..tagnumber assigns the tag
for num, tag in ipairs(tags) do
  vim.keymap.set(
    {'n', 'v'},
    [[<Leader>]]..tostring(num),
    string.format([[^dt}dwI- %-]]..tag_width..[[s <Esc>^f}w]], '{'..tag..'}')
  )
end

-- keybinding
vim.keymap.set({'n', 'v'}, [[<Leader>0]], [[^a {]]..tags[1]..[[}<Esc>^f}w]]) -- add the first tag
vim.keymap.set({'n', 'v'}, [[<Leader>9]], [[^f{dt}dw^w]]) -- remove the tag
vim.keymap.set({'n', 'v'}, [[<Leader>8]], [[^f}w]]) -- move cursor to first word after tag
