return {
  {
    'nvim-tree/nvim-web-devicons',
    lazy = false,
  },
  {
    'sindrets/diffview.nvim',
    lazy = false,
    config = function()
      local P = require('diffview')
      P.setup({
        keymaps = {
          file_panel = {
            { "n", "X", false, { desc = "Restore entry to the state on the left side" } }, -- disabled, since easy to accidentally do, and difficult to deliberately undo
          },
        },
      })
    end
  },
}
