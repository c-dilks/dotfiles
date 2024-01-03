return {
  {
    'junegunn/fzf',
    run = './install --all',
    lazy = false,
  },
  {
    'junegunn/fzf.vim',
    lazy = false,
    config = function()
      vim.api.nvim_set_var('fzf_preview_window', {'up:40%', 'ctrl-/'})
      vim.api.nvim_set_var('fzf_action', {
        ['ctrl-t'] = 'tab split',
        ['ctrl-x'] = 'split',
        ['ctrl-v'] = 'vsplit',
      })
      vim.keymap.set({'n'}, [[q/]], [[<Cmd>History/<CR>]])
      vim.keymap.set({'n'}, [[q:]], [[<Cmd>History:<CR>]])
      leader_commands({
        modes = {'n'},
        keys = {
          o = [[Files!]],
          m = [[Marks!]],
          t = [[BTags!]],
          T = [[BTags! <C-R><C-W>]],
          s = [[Tags!]],
          S = [[Tags! <C-R><C-W>]],
          r = [[Rg!]],
          R = [[Rg! <C-R><C-W>]],
          l = [[BLines!]],
          b = [[Buffers]],
        },
      })
    end,
  },
}
