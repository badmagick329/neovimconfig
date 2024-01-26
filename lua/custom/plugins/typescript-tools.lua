local enabled = true
if not enabled then
  return {}
end

return {
  'pmizio/typescript-tools.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
  opts = {},
  config = function()
    require('typescript-tools').setup {
      settings = {
        tsserver_file_preferences = {
          -- includeInlayParameterNameHints = 'literals',
          includeInlayParameterNameHints = 'none',
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeCompletionsForModuleExports = true,
          quotePreference = 'auto',
        },
        tsserver_format_options = {
          allowIncompleteCompletions = false,
          allowRenameOfImportPath = false,
        },
      },
    }
  end,
}
