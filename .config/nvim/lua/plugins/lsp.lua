return {
  {
    'VonHeikemen/lsp-zero.nvim',
    -- enabled = false,
    dependencies = {
      'neovim/nvim-lspconfig',
    },
  },
  {
    'williamboman/mason.nvim',
    -- enabled = false,
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
      vim.keymap.set({'n', 'v'}, [[Ln]], vim.diagnostic.goto_next)
      vim.keymap.set({'n', 'v'}, [[Lp]], vim.diagnostic.goto_prev)

      -- set list of LSPs
      local lsps = {
        'clangd',
        'jdtls',
      }
      -- choose only LSPs which are available
      local lsps_avail = {}
      for i,lsp in ipairs(lsps) do
        if vim.fn.executable(lsp) == 1 then
          table.insert(lsps_avail, lsp)
        end
      end

      -- mason setup
      local lsp_zero        = require('lsp-zero')
      local mason           = require('mason')
      local mason_lspconfig = require('mason-lspconfig')
      local lspconfig       = require('lspconfig')
      -- lsp_zero.preset('recommended') -- deprecated
      lsp_zero.setup()
      mason.setup()
      mason_lspconfig.setup {
        ensure_installed = lsps_avail,
        automatic_installation = true,
      }

      -- LSP clangd
      if vim.fn.executable('clangd') == 1 then
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
              )(fname) or
              require('lspconfig.util').root_pattern(
                'compile_commands.json',
                'compile_flags.txt'
              )(fname) or
              require('lspconfig.util').find_git_ancestor(fname)
          end,
        }
      end

      -- LSP jdtls
      if vim.fn.executable('jdtls') == 1 then
        lspconfig.jdtls.setup {
          root_dir = function(fname)
            return require('lspconfig.util').root_pattern(
            'pom.xml'
            )(fname) or
            require('lspconfig.util').find_git_ancestor(fname)
          end,
        }
      end

    end,
  },
}
