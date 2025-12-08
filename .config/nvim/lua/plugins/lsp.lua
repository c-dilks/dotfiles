return {
  {
    'neovim/nvim-lspconfig',
    enabled = true,
    lazy = false,
    dependencies = {
      'VonHeikemen/lsp-zero.nvim',
      'williamboman/mason-lspconfig.nvim',
      'williamboman/mason.nvim',
      'SmiteshP/nvim-navic',
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

      -- lsp-zero and mason setup
      require('lsp-zero').setup()
      require('mason').setup()
      require('mason-lspconfig').setup {
        ensure_installed = lsps_avail,
        automatic_installation = true,
      }

      -- navic
      require('nvim-navic').setup {
        icons = {
          enabled = false,
        },
        lsp = {
          auto_attach = true,
        },
      }
      vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"

      -- LSP clangd
      if vim.fn.executable('clangd') == 1 then
        vim.lsp.enable('clangd', {
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
        })
      end

      -- LSP jdtls
      if vim.fn.executable('jdtls') == 1 then
        vim.lsp.enable('jdtls', {
          root_dir = function(fname)
            return require('lspconfig.util').root_pattern(
            'pom.xml'
            )(fname) or
            require('lspconfig.util').find_git_ancestor(fname)
          end,
        })
      end

    end,
  },
}
