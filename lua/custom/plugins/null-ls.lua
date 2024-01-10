local M = {
  'nvimtools/none-ls.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
}

function M.config()
  local null_ls = require 'null-ls'
  local formatting = null_ls.builtins.formatting
  local diagnostics = null_ls.builtins.diagnostics
  local augroup = vim.api.nvim_create_augroup('LSPFormatting', {})
  local defaults = {
    border = nil,
    cmd = { 'nvim' },
    debounce = 250,
    debug = false,
    default_timeout = 5000,
    diagnostic_config = {},
    diagnostics_format = '#{m}',
    fallback_severity = vim.diagnostic.severity.ERROR,
    log_level = 'warn',
    notify_format = '[null-ls] %s',
    on_attach = nil,
    on_init = nil,
    on_exit = nil,
    root_dir = require('null-ls.utils').root_pattern(
      '.null-ls-root',
      'Makefile',
      '.git'
    ),
    root_dir_async = nil,
    should_attach = nil,
    sources = nil,
    temp_dir = nil,
    update_in_insert = false,
  }
  null_ls.setup {
    defaults = defaults,
    debug = false,
    sources = {
      -- ------- GO -------
      null_ls.builtins.formatting.gofumpt,
      null_ls.builtins.formatting.goimports_reviser,
      null_ls.builtins.formatting.golines,
      -- ------- LUA -------
      null_ls.builtins.formatting.stylua,
      -- ------- PYTHON -------
      -- null_ls.builtins.diagnostics.mypy,
      null_ls.builtins.diagnostics.ruff,
      null_ls.builtins.formatting.djlint,
      null_ls.builtins.formatting.black.with {
        extra_args = { '--line-length', '79' },
      },
      -- null_ls.builtins.formatting.black.with {
      --   extra_args = { "--preview" },
      -- },
      null_ls.builtins.formatting.isort,
      -- ------- MARKDOWN/JS/HTML -------
      null_ls.builtins.formatting.prettierd,
      -- ------- CLANG -------
      null_ls.builtins.formatting.clang_format,
      -- ------- Javascript -------
      -- null_ls.builtins.formatting.eslint,
    },
    on_attach = function(client, bufnr)
      -- Autoformat on save --
      -- Filter these out
      if client.name == 'tsserver' or client.name == 'typescript-tools' then
        return
      end
      -- If formatting is supported
      if client.supports_method 'textDocument/formatting' then
        vim.api.nvim_clear_autocmds {
          group = augroup,
          buffer = bufnr,
        }
        -- Trigger before buffer write
        vim.api.nvim_create_autocmd('BufWritePre', {
          group = augroup,
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format { async = false, bufnr = bufnr }
          end,
        })
      end
    end,
  }
end

return M