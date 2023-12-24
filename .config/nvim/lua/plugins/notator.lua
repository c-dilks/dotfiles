return {
  'c-dilks/notator.nvim',
  branch = 'main',
  lazy = false,
  opts = {
    tag_table = {
      { name = 'PRIORITY', color = 'yellow'     },
      { name = 'TODO',     color = 'red'        },
      { name = 'RUNNING',  color = 'cyan'       },
      { name = 'WAITING',  color = 'magenta'    },
      { name = 'DONE',     color = 'lightgreen' },
    },
  },
}
