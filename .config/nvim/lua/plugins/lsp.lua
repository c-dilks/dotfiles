return {
  {
    'VonHeikemen/lsp-zero.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
    },
  },
  {
    'williamboman/mason.nvim',
    lazy = false,
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()

      -- general keybindings
      vim.keymap.set({'n', 'v'}, [[Ls]], [[<Cmd>LspStop<CR>]])
      vim.keymap.set({'n', 'v'}, [[Lq]], [[<Cmd>LspStart<CR>]])
      vim.keymap.set({'n', 'v'}, [[Li]], [[<Cmd>LspInfo<CR>]])
      vim.keymap.set({'n', 'v'}, [[Lf]], vim.lsp.buf.code_action)

      -- mason setup
      local lsp_zero        = require('lsp-zero')
      local mason           = require('mason')
      local mason_lspconfig = require('mason-lspconfig')
      local lspconfig       = require('lspconfig')
      lsp_zero.preset('recommended')
      lsp_zero.setup()
      mason.setup()
      mason_lspconfig.setup_handlers {
        function(server_name)
          lspconfig[server_name].setup {}
        end
      }
      mason_lspconfig.setup {
        ensure_installed = {
          'clangd',
        },
        automatic_installation = true,
      }

      -- LSP clangd
      lspconfig.clangd.setup {
        root_dir = function(fname)
          return require('lspconfig.util').root_pattern(
            'Makefile',
            'configure.ac',
            'configure.in',
            'config.h.in',
            'meson.build',
            'meson.options',
            'compile_commands.json',
            'build.ninja'
            )(fname) or require('lspconfig.util').root_pattern('compile_commands.json', 'compile_flags.txt')(
          fname
          ) or require('lspconfig.util').find_git_ancestor(fname)
        end,
      }

    end,
  },
}
