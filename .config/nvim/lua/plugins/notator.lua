return {
  dir = vim.fn.stdpath('config') .. '/lua/notator',
  lazy = false,
  opts = {
    notation_table = {
      { name = 'PRIORITY', color = 'yellow'     },
      { name = 'TODO',     color = 'red'        },
      { name = 'RUNNING',  color = 'cyan'       },
      { name = 'WAITING',  color = 'magenta'    },
      { name = 'DONE',     color = 'lightgreen' },
    },
    fixed_width = false,
  }
}
