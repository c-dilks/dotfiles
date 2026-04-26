-- INSTALLATION
-- Java:
--   :MasonInstall jdtls
--   :TSInstall java
-- C++:
--   :MasonInstall clangd
--   :TSInstall cpp
--   :TSInstall c

return {
  {
    'neovim/nvim-lspconfig',
    enabled = true,
    lazy = false,
    dependencies = {
      'williamboman/mason.nvim', -- package manager
      'nvim-treesitter/nvim-treesitter', -- syntax tree, etc.
      'SmiteshP/nvim-navic', -- top bar, tells you where you are
    },
    init = function()
    end,
    config = function()

      -- general keybindings
      vim.keymap.set({'n', 'v'}, [[Ls]], [[<Cmd>LspStop<CR>]])
      vim.keymap.set({'n', 'v'}, [[Lq]], [[<Cmd>LspStart<CR>]])
      vim.keymap.set({'n', 'v'}, [[Li]], [[<Cmd>LspInfo<CR>]])
      vim.keymap.set({'n', 'v'}, [[Lf]], vim.lsp.buf.code_action)
      vim.keymap.set({'n', 'v'}, [[Ln]], vim.diagnostic.goto_next)
      vim.keymap.set({'n', 'v'}, [[Lp]], vim.diagnostic.goto_prev)
      vim.api.nvim_create_autocmd('LspAttach', { -- these keybindings can only be used after LSP initializes
        callback = function(args)
          local opts = { buffer = args.buf }
          vim.keymap.set('n', 'gd', function()
            vim.cmd("normal! m'") -- push current pos to jumplist so <C-o> behaves correctly
            vim.lsp.buf.definition()
          end, opts)
          vim.keymap.set('n', 'gD', function()
            vim.cmd("normal! m'") -- push current pos to jumplist so <C-o> behaves correctly
            vim.lsp.buf.declaration()
          end, opts)
        end,
      })

      -- mason
      require('mason').setup()

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

      -- enable LSPs
      lsps = {
        'clangd',
        'jdtls',
      }
      for i,lsp in ipairs(lsps) do
        if vim.fn.executable(lsp) == 1 then
          vim.lsp.enable(lsp)
        end
      end

    end,
  },
}
