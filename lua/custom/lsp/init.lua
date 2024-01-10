-- vim:ai:foldmethod=marker:foldlevel=0
local servers = require('custom.lsp.server_list')
-- Setup neovim lua configuration
require('neodev').setup {
  library = { plugins = { 'nvim-dap-ui' }, types = true },
}

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'
local on_attach = function(client, bufnr)
  if client.supports_method 'textDocument/hover' then
    vim.api.nvim_buf_set_keymap(
      bufnr,
      'n',
      'K',
      '<cmd>lua vim.lsp.buf.hover()<CR>',
      { noremap = true, silent = true }
    )
  end
  if client.supports_method 'textDocument/inlayHint' then
    vim.lsp.inlay_hint(bufnr, true)
  end
end

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end,
}

-- Setup dap for python
local mason_path = vim.fn.glob(vim.fn.stdpath 'data' .. '/mason/')
pcall(function()
  require('dap-python').setup(mason_path .. 'packages/debugpy/venv/bin/python')
  -- require("dap-python").setup("python")
end)

-- {{{
-- local lspconfig = require 'lspconfig'

-- pyright setup
-- lspconfig.pyright.setup {
--   capabilities = capabilities,
--   settings = {
--     python = {
--       analysis = {
--         autoSearchPaths = true,
--         autoImportCompletions = true,
--         completeFunctionParens = true,
--         diagnosticMode = 'workspace',
--         useLibraryCodeForTypes = true,
--         -- useLibraryCodeForTypes = false,
--         diagnosticSeverityOverrides = {
--           reportGeneralTypeIssues = 'none',
--           reportOptionalSubscript = 'none',
--           reportPrivateUsage = 'warning',
--           reportOptionalMemberAccess = 'none',
--         },
--       },
--     },
--   },
--   filetypes = { 'python' },
-- }

-- local util = require 'lspconfig.util'
-- local ih = require 'inlay-hints'
-- Settings with inlay hints
-- typescript-tools
-- lspconfig['typescript-tools'].setup {
--   capabilities = capabilities,
--   filetypes = {
--     'javascript',
--     'javascriptreact',
--     'javascript.jsx',
--     'typescript',
--     'typescriptreact',
--     'typescript.tsx',
--   },
--   root_dir = function(fname)
--     return util.root_pattern 'tsconfig.json' (fname)
--         or util.root_pattern('package.json', 'jsconfig.json', '.git')(fname)
--   end,
--   single_file_support = true,
--   settings = {
--     javascript = {
--       inlayHints = {
--         includeInlayEnumMemberValueHints = true,
--         includeInlayFunctionLikeReturnTypeHints = true,
--         includeInlayFunctionParameterTypeHints = true,
--         includeInlayParameterNameHints = 'all', -- 'none' | 'literals' | 'all';
--         includeInlayParameterNameHintsWhenArgumentMatchesName = true,
--         includeInlayPropertyDeclarationTypeHints = true,
--         includeInlayVariableTypeHints = true,
--       },
--     },
--     typescript = {
--       inlayHints = {
--         includeInlayEnumMemberValueHints = true,
--         includeInlayFunctionLikeReturnTypeHints = true,
--         includeInlayFunctionParameterTypeHints = true,
--         includeInlayParameterNameHints = 'all', -- 'none' | 'literals' | 'all';
--         includeInlayParameterNameHintsWhenArgumentMatchesName = true,
--         includeInlayPropertyDeclarationTypeHints = true,
--         includeInlayVariableTypeHints = true,
--       },
--     },
--   },
-- }
-- gopls
-- lspconfig.gopls.setup {
--   -- on_attach = function(c, b)
--   --   ih.on_attach(c, b)
--   -- end,
--   capabilities = capabilities,
--   filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
--   settings = {
--     gopls = {
--       hints = {
--         assignVariableTypes = true,
--         compositeLiteralFields = false,
--         compositeLiteralTypes = true,
--         constantValues = true,
--         functionTypeParameters = true,
--         parameterNames = false,
--         rangeVariableTypes = true,
--       },
--     },
--   },
-- }
--
-- }}}
