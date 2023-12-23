return {
  {
    'junegunn/fzf',
    run = './install --all',
    lazy = false,
  },
  {
    'junegunn/fzf.vim',
    config = function()
      vim.api.nvim_set_var('fzf_preview_window', {'up:40%', 'ctrl-/'})
      vim.api.nvim_set_var('fzf_action', {
        ['ctrl-t'] = 'tab split',
        ['ctrl-x'] = 'split',
        ['ctrl-v'] = 'vsplit',
      })
    end,
    keys = leader_commands({
      modes = {'n'},
      lazy = true,
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
    }),
  },
}
