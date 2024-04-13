local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd('VimResized', {
  desc = 'Auto resize panes when resizing nvim window',
  pattern = '*',
  command = 'tabdo wincmd =',
})

-- Show cursor line only in active window
autocmd({ 'InsertLeave', 'WinEnter' }, {
  pattern = '*',
  command = 'set cursorline',
  group = augroup('CursorLine', { clear = true }),
})
autocmd({ 'InsertEnter', 'WinLeave' }, {
  pattern = '*',
  command = 'set nocursorline',
  group = augroup('CursorLine', { clear = true }),
})

-- Restore cursor
autocmd({ 'BufReadPost' }, {
  pattern = { '*' },
  callback = function()
    vim.api.nvim_exec('silent! normal! g`"zv', false)
  end,
})

-- Remove all trailing whitespace on save
autocmd('BufWritePre', {
  command = [[:%s/\s\+$//e]],
  group = augroup('TrimWhiteSpaceGrp', { clear = true }),
})

-- Windows to close with "q"
autocmd('FileType', {
  pattern = {
    'help',
    'startuptime',
    'qf',
    'lspinfo',
    'man',
    'checkhealth',
    'tsplayground',
    'HIERARCHY-TREE-GO',
    'dap-float',
    'spectre_panel',
    'null-ls-info',
    'empty',
    'neotest-output',
    'neotest-summary',
    'neotest-output-panel',
  },
  command = [[
            nnoremap <buffer><silent> q :close<CR>
            set nobuflisted
        ]],
})

--Delete [No Name] buffers,
autocmd('BufHidden', {
  callback = function(event)
    if
        event.file == ''
        and vim.bo[event.buf].buftype == ''
        and not vim.bo[event.buf].modified
    then
      vim.schedule(function()
        pcall(vim.api.nvim_buf_delete, event.buf, {})
      end)
    end
  end,
})

-- Center After Saving
-- autocmd('BufWritePost', {
--   group = augroup('CenterAfterSave', { clear = true }),
--   callback = function()
--     vim.api.nvim_feedkeys('zz', 'n', false)
--   end,
-- })

-- Highlight on yank
local highlight_group = augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank { higroup = 'Visual', timeout = 40 }
  end,
  group = highlight_group,
  pattern = '*',
})

-- If entering weird command window, quit it
autocmd('CmdWinEnter', {
  callback = function()
    vim.cmd 'quit'
  end,
})

-- Fix auto comment on new line following a comment
autocmd({ 'BufWinEnter' }, {
  callback = function()
    vim.cmd 'set formatoptions-=cro'
    -- neotree gets rid of columns if maximised. This fixes it
    vim.cmd 'set colorcolumn=80'
  end,
})

-- clang fix for "multiple different client offset_encodings detected for buffer"
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.offsetEncoding = { 'utf-16' }
-- require('lspconfig').clangd.setup { capabilities = capabilities }
