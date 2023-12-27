return {
  'c-dilks/notator.nvim',
  branch = 'main',
  lazy = false,
  opts = {
    tag_table = {
      { name = 'PRIORITY', color = 'yellow'     },
      { name = 'ACTION',   color = 'red'        },
      { name = 'RUNNING',  color = 'cyan'       },
      { name = 'WAITING',  color = 'magenta'    },
      { name = 'DONE',     color = 'lightgreen' },
    },
  },
}
