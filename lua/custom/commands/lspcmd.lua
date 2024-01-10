-- [[ Configure LSP ]]
-- Native type hints
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.server_capabilities.inlayHintProvider then
      if vim.lsp.inlay_hint ~= nil then
        vim.lsp.inlay_hint(args.buf, true)
      end
    end
    -- whatever other lsp config you want
    local nmap = function(keys, func, desc)
      if desc then
        desc = desc
      end
      vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end
    local tbuiltin = require 'telescope.builtin'
    nmap('<leader>lr', vim.lsp.buf.rename, 'Rename')
    nmap('<leader>la', vim.lsp.buf.code_action, 'Code Action')

    nmap('gd', vim.lsp.buf.definition, 'Goto Definition')
    nmap('gr', require('telescope.builtin').lsp_references, 'Goto References')
    nmap('gI', vim.lsp.buf.implementation, 'Goto Implementation')
    nmap('<leader>lD', vim.lsp.buf.type_definition, 'Type Definition')
    nmap('<leader>ls', tbuiltin.lsp_document_symbols, 'Document Symbols')
    nmap('<leader>lW', tbuiltin.lsp_workspace_symbols, 'Workspace Symbols')
    nmap(
      '<leader>lw',
      tbuiltin.lsp_dynamic_workspace_symbols,
      'Dynamic Workspace Symbols'
    )
    nmap('<leader>ld', function()
      ---@diagnostic disable-next-line: param-type-mismatch
      vim.diagnostic.open_float(0, { scope = 'line' })
    end, 'Open line diagnostics in float')
    nmap('<leader>lo', '<cmd>SymbolsOutline<cr>', 'Symbols Outline')

    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    -- nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, 'Goto Declaration')
    nmap(
      '<leader>lza',
      vim.lsp.buf.add_workspace_folder,
      'Workspace Add Folder'
    )
    nmap(
      '<leader>lzr',
      vim.lsp.buf.remove_workspace_folder,
      'Workspace Remove Folder'
    )
    nmap('<leader>lzl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, 'Workspace List Folders')
  end,
})

-- lsp inlay hint color
vim.api.nvim_set_hl(0, 'LspInlayHint', { fg = '#5d5966' })
