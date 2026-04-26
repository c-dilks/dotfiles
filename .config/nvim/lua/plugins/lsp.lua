--[[

INSTALLATION
- Notes
  - Use Mason to install LSP servers, and TreeSitter to install language plugins
  - Run `:Mason` to see LSP servers
  - I prefer to do this manually, since on some machines installation may fail (firewall blocks, etc.)
- Java:
  - `:MasonInstall jdtls`
    - if you get a failure to download 'lombok.jar', see below
  - `:TSInstall java`
- C++:
  - `:MasonInstall clangd`
  - `:TSInstall cpp`
  - `:TSInstall c`

TROUBLESHOOTING
- jdtls: exits with code 13 and signal 0:
  - jdtls cache may have gotten in a bad state, wipe it:
    - `rm -rI ~/.cache/nvim/jdtls`
    - `rm -rI ~/.cache/jdtls`
    - `rm -rI ~/.local/share/jdtls`

- jdtls: failure to download lombok.jar when installing jdtls
  - may be blocked by firewall
  - get it on an unblocked machine: `wget https://projectlombok.org/downloads/lombok.jar`
  - open Mason registry configuration: `~/.local/share/nvim/mason/registries/github/mason-org/mason-registry/registry.json`
    - edit the `lombok` download link for `lombok.jar` for the `linux` target to be `file:///path/to/lombok.jar`
  - retry `:MasonInstall jdtls`

--]]


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

      -- workaround for https://github.com/neovim/neovim/issues/37166
      vim.lsp.config('jdtls', {
        on_attach = function(client, bufnr)
          client.server_capabilities.definitionProvider = true
          client.server_capabilities.hoverProvider = true
          client.server_capabilities.documentFormattingProvider = true
          client.server_capabilities.documentRangeFormattingProvider = true
          client.server_capabilities.renameProvider = true
          client.server_capabilities.inlayHintProvider = true
        end,
      })

    end,
  },
}
