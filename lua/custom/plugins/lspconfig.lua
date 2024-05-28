-- vim:ai:foldmethod=marker:foldlevel=0

local M = {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    { 'williamboman/mason.nvim', config = true },
    'williamboman/mason-lspconfig.nvim',

    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    { 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },

    'folke/neodev.nvim',
  },
}

function M.config()
  local lspconfig = require 'lspconfig'
  lspconfig.htmx.setup{}
  local icons = require 'custom.icons'
  -- Diagnostic configuration
  local default_diagnostic_config = {
    signs = {
      active = true,
      values = {
        { name = 'DiagnosticSignError', text = icons.diagnostics.Error },
        { name = 'DiagnosticSignWarn',  text = icons.diagnostics.Warning },
        { name = 'DiagnosticSignHint',  text = icons.diagnostics.Hint },
        { name = 'DiagnosticSignInfo',  text = icons.diagnostics.Information },
      },
    },
    virtual_text = true,
    update_in_insert = false,
    underline = false,
    severity_sort = true,
    float = {
      focusable = true,
      style = 'minimal',
      border = 'rounded',
      source = 'always',
      header = '',
      prefix = '',
    },
  }
  vim.diagnostic.config(default_diagnostic_config)
  for _, sign in
  ipairs(vim.tbl_get(vim.diagnostic.config(), 'signs', 'values') or {})
  do
    vim.fn.sign_define(
      sign.name,
      { texthl = sign.name, text = sign.text, numhl = sign.name }
    )
  end

  -- Pop up windows configuration
  vim.lsp.handlers['textDocument/hover'] =
      vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
  vim.lsp.handlers['textDocument/signatureHelp'] =
      vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })
  require('lspconfig.ui.windows').default_options.border = 'rounded'
end

M.on_attach = function(client, bufnr)
  if client.supports_method 'textDocument/hover' then
    vim.api.nvim_buf_set_keymap(
      bufnr,
      'n',
      'K',
      '<cmd>lua vim.lsp.buf.hover()<CR>',
      { noremap = true, silent = true }
    )
  end
end

return M

--- {{{
-- return {
--   -- LSP Configuration & Plugins
--   'neovim/nvim-lspconfig',
--   event = { 'BufReadPre', 'BufNewFile' },
--   dependencies = {
--     -- Automatically install LSPs to stdpath for neovim
--     { 'williamboman/mason.nvim', config = true },
--     'williamboman/mason-lspconfig.nvim',
--
--     -- Useful status updates for LSP
--     -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
--     { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },
--
--     -- Additional lua configuration, makes nvim stuff amazing!
--     'folke/neodev.nvim',
--   },
--   config = function()
--     local lspconfig = require 'lspconfig'
--     local icons = require 'custom.icons'
--     local default_diagnostic_config = {
--       signs = {
--         active = true,
--         values = {
--           { name = 'DiagnosticSignError', text = icons.diagnostics.Error },
--           { name = 'DiagnosticSignWarn', text = icons.diagnostics.Warning },
--           { name = 'DiagnosticSignHint', text = icons.diagnostics.Hint },
--           { name = 'DiagnosticSignInfo', text = icons.diagnostics.Information },
--         },
--       },
--       virtual_text = true,
--       update_in_insert = false,
--       underline = false,
--       severity_sort = true,
--       float = {
--         focusable = true,
--         style = 'minimal',
--         border = 'rounded',
--         source = 'always',
--         header = '',
--         prefix = '',
--       },
--     }
--     vim.diagnostic.config(default_diagnostic_config)
--     for _, sign in
--       ipairs(vim.tbl_get(vim.diagnostic.config(), 'signs', 'values') or {})
--     do
--       vim.fn.sign_define(
--         sign.name,
--         { texthl = sign.name, text = sign.text, numhl = sign.name }
--       )
--     end
--
--     vim.lsp.handlers['textDocument/hover'] =
--       vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
--     vim.lsp.handlers['textDocument/signatureHelp'] =
--       vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })
--     require('lspconfig.ui.windows').default_options.border = 'rounded'
--   end,
-- }
-- }}}

-- {{{
-- local M = {
--   'neovim/nvim-lspconfig',
--   event = { 'BufReadPre', 'BufNewFile' },
--   commit = 'e49b1e90c1781ce372013de3fa93a91ea29fc34a',
--   dependencies = {
--     {
--       'folke/neodev.nvim',
--       commit = 'b094a663ccb71733543d8254b988e6bebdbdaca4',
--     },
--   },
-- }
--
-- -- local function lsp_keymaps(bufnr)
-- --   local opts = { noremap = true, silent = true }
-- --   local keymap = vim.api.nvim_buf_set_keymap
-- --   keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
-- --   keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
-- --   keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
-- --   keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
-- --   keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
-- --   keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
-- -- end
-- --
--
-- M.on_attach = function(client, bufnr) end
--
-- function M.common_capabilities()
--   local status_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
--   if status_ok then
--     return cmp_nvim_lsp.default_capabilities()
--   end
--
--   local capabilities = vim.lsp.protocol.make_client_capabilities()
--   capabilities.textDocument.completion.completionItem.snippetSupport = true
--   capabilities.textDocument.completion.completionItem.resolveSupport = {
--     properties = {
--       'documentation',
--       'detail',
--       'additionalTextEdits',
--     },
--   }
--
--   return capabilities
-- end
--
-- function M.config()
--   local lspconfig = require 'lspconfig'
--   local icons = require 'custom.icons'
--
--   local servers = {
--     'bashls',
--     'clangd',
--     'cssls',
--     'docker_compose_language_service',
--     'dockerls',
--     'gopls',
--     'html',
--     'jsonls',
--     'lua_ls',
--     'marksman',
--     'pyright',
--     'ruff_lsp',
--     'rust_analyzer',
--     'tailwindcss',
--     'tsserver',
--     'yamlls',
--   }
--
--   local default_diagnostic_config = {
--     signs = {
--       active = true,
--       values = {
--         { name = 'DiagnosticSignError', text = icons.diagnostics.Error },
--         { name = 'DiagnosticSignWarn', text = icons.diagnostics.Warning },
--         { name = 'DiagnosticSignHint', text = icons.diagnostics.Hint },
--         { name = 'DiagnosticSignInfo', text = icons.diagnostics.Information },
--       },
--     },
--     virtual_text = true,
--     update_in_insert = false,
--     underline = false,
--     severity_sort = true,
--     float = {
--       focusable = true,
--       style = 'minimal',
--       border = 'rounded',
--       source = 'always',
--       header = '',
--       prefix = '',
--     },
--   }
--
--   vim.diagnostic.config(default_diagnostic_config)
--
--   for _, sign in
--     ipairs(vim.tbl_get(vim.diagnostic.config(), 'signs', 'values') or {})
--   do
--     vim.fn.sign_define(
--       sign.name,
--       { texthl = sign.name, text = sign.text, numhl = sign.name }
--     )
--   end
--
--   vim.lsp.handlers['textDocument/hover'] =
--     vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
--   vim.lsp.handlers['textDocument/signatureHelp'] =
--     vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })
--   require('lspconfig.ui.windows').default_options.border = 'rounded'
--
--   local mason_lspconfig = require 'mason-lspconfig'
--
--   mason_lspconfig.setup {
--     ensure_installed = vim.tbl_keys(servers),
--   }
--
--   for _, server in pairs(servers) do
--     local opts = {
--       -- on_attach = M.on_attach,
--       capabilities = M.common_capabilities(),
--       filetypes = (servers[server] or {}).filetypes,
--     }
--
--     local require_ok, settings = pcall(require, 'custom.lspsettings.' .. server)
--     if require_ok then
--       opts = vim.tbl_deep_extend('force', settings, opts)
--     end
--     print('Setting up lspconfig for ' .. server)
--
--     if server == 'lua_ls' then
--       -- Setup neovim lua configuration
--       require('neodev').setup {
--         library = { plugins = { 'nvim-dap-ui' }, types = true },
--       }
--     end
--
--     lspconfig[server].setup(opts)
--   end
-- end
--
-- -- Setup dap for python
-- local mason_path = vim.fn.glob(vim.fn.stdpath 'data' .. '/mason/')
-- pcall(function()
--   require('dap-python').setup(mason_path .. 'packages/debugpy/venv/bin/python')
--   -- require("dap-python").setup("python")
-- end)
--
-- return M
-- }}}
