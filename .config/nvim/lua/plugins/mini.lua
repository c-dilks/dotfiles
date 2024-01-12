return {
  {
    -- extend and create `a`/`i` text objects
    'echasnovski/mini.ai',
    lazy = false,
    config = true,
  },
  {
    -- align text interactively with `ga`
    'echasnovski/mini.align',
    lazy = false,
    config = true,
  },
  {
    -- animation
    'echasnovski/mini.animate',
    lazy = false,
    config = function()
      local P = require('mini.animate')
      P.setup({
        cursor = {
          timing = P.gen_timing.linear({ duration = 100, unit = 'total' }),
        },
        scroll = {
          timing = P.gen_timing.linear({ duration = 50, unit = 'total' }),
        },
      })
    end,
  },
  {
    -- comment lines with `gc`
    'echasnovski/mini.comment',
    lazy = false,
    config = true,
  },
  {
    --[[ visualize and work with indentation scope
         - use text objects `ii` and `ai` (e.g., `vai`)
         - move cursor with `[i` and `]i`
    ]]
    'echasnovski/mini.indentscope',
    lazy = false,
    config = function()
      local P = require('mini.indentscope')
      P.setup({
        draw = {
          delay = 50,
          animation = P.gen_animation.quadratic({
            easing = 'out',
            duration = 100,
            unit = 'total',
          }),
        },
        symbol = '│',
      })
    end
  },
  {
    -- split and join arguments with `gS`
    'echasnovski/mini.splitjoin',
    lazy = false,
    config = true,
  },
  {
    -- status line
    'echasnovski/mini.statusline',
    lazy = false,
    config = true,
  },
  {
    -- surround actions
    'echasnovski/mini.surround',
    lazy = false,
    opts = {
      mappings = {
        add            = 'Sa', -- Add surrounding in Normal and Visual modes
        delete         = 'Sd', -- Delete surrounding
        find           = 'Sf', -- Find surrounding (to the right)
        find_left      = 'SF', -- Find surrounding (to the left)
        highlight      = 'Sh', -- Highlight surrounding
        replace        = 'Sr', -- Replace surrounding
        update_n_lines = 'Sn', -- Update `n_lines`
        suffix_last    = 'l', -- Suffix to search with "prev" method
        suffix_next    = 'n', -- Suffix to search with "next" method
      },
    },
  },
  {
    -- highlight trailing spaces
    'echasnovski/mini.trailspace',
    lazy = false,
    config = true,
  },
}
