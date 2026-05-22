--[[

INSTALLATION
- Notes
  - Use Mason to install LSP servers; run `:Mason`
  - I prefer to do this manually, since on some machines installation may fail (firewall blocks, etc.)
- Java:
  - `:MasonInstall jdtls`
    - if you get a failure to download 'lombok.jar', see below
- C++:
  - I prefer system `clangd`, but if you want, `:MasonInstall clangd`

TROUBLESHOOTING

- need to start over from a clean slate?
  - `rm -rf ~/.local/share/nvim` (local data and plugins)
  - `rm -rf ~/.cache/nvim`       (cache)
  - `rm -rf ~/.local/state/nvim` (state)

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
    'mason-org/mason.nvim', -- package manager
    enabled = true,
    lazy = false,
    dependencies = {
      'SmiteshP/nvim-navic', -- top bar, tells you where you are
    },
    init = function()
    end,
    config = function()

      -- keybindings
      vim.api.nvim_create_autocmd('LspAttach', { -- these keybindings can only be used after LSP initializes
        callback = function(args)
          -- common `vim.keymap.set` wrapper
          local lsp_keymap = function(mode, lhs, rhs)
            vim.keymap.set(mode, lhs, rhs, { buffer = args.buf, silent = true })
          end
          -- enable/disable
          lsp_keymap({'n'}, [[Ls]], function()
            vim.cmd('lsp disable')
          end)
          lsp_keymap({'n'}, [[Lq]], function()
            vim.cmd('lsp enable')
          end)
          -- diagnostic jump
          lsp_keymap({'n'}, [[Ln]], function()
            vim.diagnostic.jump({ count = 1, float = true })
          end)
          lsp_keymap({'n'}, [[Lp]], function()
            vim.diagnostic.jump({ count = -1, float = true })
          end)
          -- diagnostic fix
          lsp_keymap({'n'}, [[Lf]], function()
            vim.lsp.buf.code_action()
          end)
          -- rename
          lsp_keymap({'n'}, [[LR]], function()
            vim.lsp.buf.rename()
          end)
          -- gotos
          lsp_keymap({'n'}, [[K]], function()
            vim.lsp.buf.hover()
          end)
          lsp_keymap('n', [[gd]], function()
            vim.cmd("normal! m'") -- push current pos to jumplist so <C-o> behaves correctly
            vim.lsp.buf.definition()
          end)
          lsp_keymap('n', [[gD]], function()
            vim.cmd("normal! m'") -- push current pos to jumplist so <C-o> behaves correctly
            vim.lsp.buf.declaration()
          end)
          lsp_keymap('n', [[gi]], function()
            vim.cmd("normal! m'") -- push current pos to jumplist so <C-o> behaves correctly
            vim.lsp.buf.implementation()
          end)
          -- references
          lsp_keymap({'n'}, [[Lr]], function()
            vim.lsp.buf.references()
          end)
        end
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
      -- NOTE: their configurations are found in `../../lsp/`
      -- NOTE: use `:Mason` to install servers, or your system package manager (see note at the top)
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
