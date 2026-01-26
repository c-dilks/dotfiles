return {
  {
    'neovim/nvim-lspconfig',
    enabled = true,
    lazy = false,
    dependencies = {
      'williamboman/mason.nvim', -- package manager
      'williamboman/mason-lspconfig.nvim',
      'nvim-treesitter/nvim-treesitter', -- syntax tree, etc.
      'SmiteshP/nvim-navic', -- top bar, tells you where you are
      -- "ray-x/navigator.lua", -- lots of enhancements and keybindings
      -- { "ray-x/guihua.lua", build = "cd lua/fzy && make" }, -- for `ray-x/navigator.lua`
      -- "ms-jpq/coq_nvim", -- auto-completion
      -- { "ms-jpq/coq.artifacts", branch = "artifacts" }, -- for coq
    },
    init = function()
      -- -- coq settings
      -- vim.g.coq_settings = {
      --   auto_start = 'shut-up',
      --   keymap = {
      --     manual_complete = '<C-Space>',  -- trigger key
      --     -- disable/remap the following, since they conflict with other bindings:
      --     jump_to_mark = '', -- default <c-h>
      --     bigger_preview = '',  -- default <c-k>
      --   },
      --   completion = {
      --     always = false,  -- don't auto-trigger
      --     sticky_manual = false, -- go away after completing something
      --   },
      -- }
    end,
    config = function()

      -- general keybindings
      vim.keymap.set({'n', 'v'}, [[Ls]], [[<Cmd>LspStop<CR>]])
      vim.keymap.set({'n', 'v'}, [[Lq]], [[<Cmd>LspStart<CR>]])
      vim.keymap.set({'n', 'v'}, [[Li]], [[<Cmd>LspInfo<CR>]])
      vim.keymap.set({'n', 'v'}, [[Lf]], vim.lsp.buf.code_action)
      vim.keymap.set({'n', 'v'}, [[Ln]], vim.diagnostic.goto_next)
      vim.keymap.set({'n', 'v'}, [[Lp]], vim.diagnostic.goto_prev)
      vim.keymap.set({'n', 'v'}, [[Ld]], vim.lsp.buf.definition)

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

      -- mason
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

      -- -- ray-x/navigator
      -- require('navigator').setup {
      --   keymaps = {
      --     -- disable/remap the following, since they conflict with other bindings:
      --     {key = '<c-m>', func = vim.lsp.buf.signature_help, desc = 'signature_help'}, -- default <c-k>
      --   },
      --   icons = {
      --     icons = true,
      --     diagnostic_head = '🐛', -- prefix for other diagnostic_* icons
      --     diagnostic_err = '🐺',
      --     diagnostic_warn = '🪲',
      --     diagnostic_virtual_text = '🦊',
      --   },
      --   lsp = {
      --     format_on_save = false,
      --     servers = lsps_avail,
      --     diagnostic = {
      --       virtual_text = { spacing = 3, source = false },
      --       virtual_lines = {
      --         current_line = true, -- show diagnostic only on current line
      --       },
      --       register = true, -- workaround https://github.com/ray-x/navigator.lua/issues/335
      --     },
      --     -- diagnostic_scrollbar_sign = false,
      --     display_diagnostic_qf = true,
      --   },
      -- }

      -- -- coq (NOTE: see `init` function above for coq settings)
      -- coq = require('coq')

      -- LSP clangd
      if vim.fn.executable('clangd') == 1 then
        vim.lsp.enable('clangd', { -- coq.lsp_ensure_capabilities({
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
        }) -- ) coq
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
