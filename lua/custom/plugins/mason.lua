local M = {
  'williamboman/mason-lspconfig.nvim',
  commit = 'e7b64c11035aa924f87385b72145e0ccf68a7e0a',
  dependencies = {
    'williamboman/mason.nvim',
    'nvim-lua/plenary.nvim',
  },
}

function M.config()
  require('mason').setup {
    ui = {
      border = 'rounded',
      icons = {
        package_pending = ' ',
        package_installed = '󰄳 ',
        package_uninstalled = ' 󰚌',
      },
    },
    max_concurrent_installers = 10,
    ensure_installed = {
      -- python
      'pyright',
      -- 'ruff-lsp',
      'black',
      'isort',
      'debugpy',
      'djlint',
      -- rust
      'rust-analyzer',
      -- go
      -- 'gopls',
      -- 'golines',
      -- 'gofumpt',
      -- 'goimports-reviser',
      'delve',
      -- c
      -- 'clangd',
      'clang-format',
      -- docker
      'docker-compose-language-service',
      'dockerfile-language-server',
      -- config
      'json-lsp',
      'yaml-language-server',
      -- js/ts
      'typescript-language-server',
      'eslint-lsp',
      'eslint_d',
      'js-debug-adapter',
      'tailwindcss-language-server',
      -- html/css
      'html-lsp',
      'css-lsp',
      -- markdown
      'prettierd',
      'marksman',
      -- lua
      'lua-language-server',
      'stylua',
    },
  }
  require('mason-lspconfig').setup {
    ensure_installed = M.servers,
  }
end

return M
