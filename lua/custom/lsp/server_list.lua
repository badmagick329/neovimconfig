return {
  -- clangd = { filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'hpp' } },
  svelte = {},
  bashls = {},
  emmet_ls = {},
  -- ocamllsp = {},
  docker_compose_language_service = {},
  dockerls = {},
  cssls = {},
  bufls = {
    filetypes = { 'proto' },
    root_dir = require('lspconfig').util.root_pattern('.git', '.bufconfig'),
  },
  tailwindcss = require 'custom.lsp.servers.tailwindcss',
  pyright = require 'custom.lsp.servers.pyright',
  html = require 'custom.lsp.servers.html',
  jsonls = require 'custom.lsp.servers.jsonls',
  -- lua_ls = require 'custom.lsp.servers.lua_ls',
  gopls = require 'custom.lsp.servers.gopls',
}
