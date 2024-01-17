return {
  clangd = {},
  svelte = {},
  bashls = {},
  emmet_ls = {},
  ruff_lsp = {},
  tailwindcss = require 'custom.lsp.servers.tailwindcss',
  pyright = require 'custom.lsp.servers.pyright',
  html = require 'custom.lsp.servers.html',
  jsonls = require 'custom.lsp.servers.jsonls',
  lua_ls = require 'custom.lsp.servers.lua_ls',
  gopls = require 'custom.lsp.servers.gopls',
}
