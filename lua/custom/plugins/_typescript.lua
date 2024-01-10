local enabled = false
if not enabled then
  return {}
end

local M = {
  'jose-elias-alvarez/typescript.nvim',
  event = 'BufReadPre',
}

function M.config()
  local ts = require 'typescript'
  ts.setup {
    disable_commands = false, -- prevent the plugin from creating Vim commands
    debug = false, -- enable debug logging for commands
    go_to_source_definition = {
      fallback = true, -- fall back to standard LSP definition on failure
    },
    server = {
      on_attach = function(client, bufnr)
        -- your other on_attach stuff here if you have any
        -- ...
        print("Enabling inlay hints")
        vim.lsp.buf.inlay_hint(bufnr, true)
      end,
      settings = {
        -- specify some or all of the following settings if you want to adjust the default behavior
        javascript = {
          inlayHints = {
            includeInlayEnumMemberValueHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayParameterNameHints = 'all', -- 'none' | 'literals' | 'all';
            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayVariableTypeHints = true,
          },
        },
        typescript = {
          inlayHints = {
            includeInlayEnumMemberValueHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayParameterNameHints = 'all', -- 'none' | 'literals' | 'all';
            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayVariableTypeHints = true,
          },
        },
      },
    },
  }
end

return M
