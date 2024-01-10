-- vim:ai:foldmethod=marker:foldlevel=0
local keymap = vim.keymap.set
local nmap = function(keys, func, desc)
  keymap('n', keys, func, { desc = desc })
end

local nrmap = function(keys, func, desc)
  keymap('n', keys, func, { desc = desc, remap = true })
end

local nrsmap = function(keys, func, desc)
  keymap('n', keys, func, { desc = desc, remap = true, silent = true })
end

-- [[ Basic Keymaps ]]
keymap({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
-- Save
keymap({ 'n', 'v', 'i', 'x' }, '<C-s>', '<cmd>w<cr>', { silent = true })
-- Select full function
-- {{{
-- keymap('n', 'vaf', 'vafo0oj', { silent = true, remap = true })
-- keymap('n', 'vif', 'vifo0oj', { silent = true, remap = true })
-- }}}

-- ???
keymap('n', '<C-i>', '<C-i>', opts)

-- Close buffer
keymap(
  'n',
  '<leader>x',
  '<cmd>bdelete!<cr>',
  { desc = 'Close buffer', silent = true }
)
-- Close all except current buffer
-- Vim version
keymap(
  'n',
  '<leader>X',
  '<cmd>%bdelete|edit#|bdelete#<cr>',
  { desc = 'Close all except current buffer', silent = true }
)

-- Remap for dealing with word wrap
keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- move stuff with J and K in v mode
keymap('v', 'J', ":m '>+1<CR>gv=gv")
keymap('v', 'K', ":m '<-2<CR>gv=gv")

-- Move to windows using ctrl + hjkl
nrmap('<C-h>', '<C-w>h', 'Go to left window')
nrmap('<C-j>', '<C-w>j', 'Go to lower window')
nrmap('<C-k>', '<C-w>k', 'Go to upper window')
nrmap('<C-l>', '<C-w>l', 'Go to right window')

-- Do not put stuff in registers for these
keymap('x', 'p', [["_dP]])
keymap({ 'x', 'n' }, 'x', [["_x]])
keymap({ 'x', 'n' }, 'C', [["_C]])

-- Diagnostic keymaps
nmap('[d', vim.diagnostic.goto_prev, 'Go to previous diagnostic message')
nmap(']d', vim.diagnostic.goto_next, 'Go to next diagnostic message')
nmap('<leader>q', vim.diagnostic.setloclist, 'Open diagnostics list')

-- function signature help in insert mode
local opts = { noremap = true, silent = true }
keymap('i', '<C-h>', function()
  vim.lsp.buf.signature_help()
end, opts)

-- better indenting
keymap('v', '<', '<gv')
keymap('v', '>', '>gv')

-- better scrolling: keep cursor centered
keymap('n', '<C-d>', '<C-d>zz')
keymap('n', '<C-u>', '<C-u>zz')
keymap('n', 'n', 'nzzzv')
keymap('n', 'N', 'Nzzzv')

-- PLUGIN KEYMAPS
-- [[ Copilot Keymaps ]]
nmap('<leader>ps', '<cmd> Copilot status <CR>', 'Copilot status')
nmap('<leader>pp', '<cmd> Copilot disable <CR>', 'Disable copilot')
nmap('<leader>pP', '<cmd> Copilot enable <CR>', 'Enable copilot')

-- [[ LazyGit ]]
keymap('n', '<leader>gg', '<cmd>LazyGit<cr>', { desc = 'LazyGit' })

-- [[ formatter.nvim ]]
keymap('n', '<leader>lf', function()
  vim.lsp.buf.format {
    async = false,
    filter = function(client)
      return client.name ~= 'typescript-tools'
    end,
  }
end, { desc = 'Format Buffer' })

-- [[ vim-tmux-navigator ]]
nrsmap('<C-h>', ':<C-U>TmuxNavigateLeft<CR>', 'Go to left window')
nrsmap('<C-j>', ':<C-U>TmuxNavigateDown<CR>', 'Go to lower window')
nrsmap('<C-k>', ':<C-U>TmuxNavigateUp<CR>', 'Go to upper window')
nrsmap('<C-l>', ':<C-U>TmuxNavigateRight<CR>', 'Go to right window')

-- [[ Telescope Keymaps ]]
local tbuiltin = require 'telescope.builtin'
local actions = require 'telescope.actions'
nmap('<leader>?', tbuiltin.oldfiles, '[?] Find recently opened files')
nmap('<leader><space>', tbuiltin.buffers, '[ ] Find existing buffers')
nmap('<leader>/', function()
  tbuiltin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, '[/] Fuzzily search in current buffer')

nmap('<leader>fg', tbuiltin.git_files, 'Telescope: Git Files')
nmap('<leader>ff', function()
  tbuiltin.find_files { hidden = true, no_ignore = true }
end, 'Telescope: Files')
nmap('<leader>fh', tbuiltin.help_tags, 'Telescope: Help')
nmap('<leader>fW', tbuiltin.grep_string, 'Telescope: Current Word')
nmap('<leader>fw', tbuiltin.live_grep, 'Telescope: Text')
nmap('<leader>fd', tbuiltin.diagnostics, 'Telescope: Diagnostics')
nmap('<leader>fr', tbuiltin.resume, 'Telescope: Resume')

-- [[ Harpoon Keymaps ]]
local hui = require 'harpoon.ui'
local hmark = require 'harpoon.mark'

nmap('<leader>kk', hui.toggle_quick_menu, 'Harpoon Quickmenu')
nmap('<leader>ka', hmark.add_file, 'Add file')
-- stylua: ignore start
nmap('<leader>kq', function() hui.nav_file(1) end, 'Harpoon: File 1')
nmap('<leader>kw', function() hui.nav_file(2) end, 'Harpoon: File 2')
nmap('<leader>ke', function() hui.nav_file(3) end, 'Harpoon: File 3')
nmap('<leader>kr', function() hui.nav_file(4) end, 'Harpoon: File 4')
nmap('<leader>kt', function() hui.nav_file(5) end, 'Harpoon: File 5')
-- stylua: ignore end

-- [[ Spectre Keymaps ]]
local spectre = require 'spectre'
nmap('<leader>ss', spectre.open, 'Spectre')
nmap('<leader>sw', function()
  spectre.open_visual { select_words = true }
end, 'Spectre')
nmap('<leader>sf', spectre.open_file_search, 'Spectre')

-- [[ repl Keymaps ]]
nmap('<leader>ii', '<cmd>ReplToggle<cr>', 'Toggle Repl')
nmap('<leader>ir', '<cmd>ReplRunCell<cr>', 'Run Cell')

-- [[ undo tree ]]
nmap('<leader>u', '<cmd>UndotreeToggle<cr>', 'Toggle UndoTree')

-- [[ Trouble ]]
-- stylua: ignore start
local trouble = require('trouble')
nmap('<leader>tt', function() trouble.open() end, 'Trouble: Toggle Trouble')
nmap('<leader>tw', function() trouble.open 'workspace_diagnostics' end, 'Trouble: Workspace Diagnosis')
nmap('<leader>td', function() trouble.open 'document_diagnostics' end, 'Trouble: Document Diagnosis')
nmap('<leader>tq', function() trouble.open 'quickfix' end, 'Trouble: Open quickfix')
nmap('<leader>tl', function() trouble.open 'loclist' end, 'Trouble: Open loclist')
nmap('gR', function() trouble.open 'lsp_references' end, 'Trouble: LSP References')
-- stylua: ignore end

-- [[ Bufferline ]]
nmap('<S-l>', '<cmd>BufferLineCycleNext<CR>', 'Cycle to next buffer')
nmap('<S-h>', '<cmd>BufferLineCyclePrev<CR>', 'Cycle to prev buffer')

-- [[ Todo Comments ]]
nmap('<leader>fc', '<cmd>TodoTelescope<cr>', 'TodoComments: Telescope')
nmap('<leader>fx', '<cmd>TodoTrouble<cr>', 'TodoComments: Trouble')

-- [[ Dap Keybinds ]]
local dap = require 'dap'
local dapui = require 'dapui'
-- stylua: ignore start
nmap('<F5>', function() dap.continue() end, 'Debug: Continue')
nmap('<F10>', function() dap.step_into() end, 'Debug: Step Into')
nmap('<F11>', function() dap.step_over() end, 'Debug: Step Over')
nmap('<F12>', function() dap.step_out() end, 'Debug: Step Out')
nmap('<Leader>db', function() dap.toggle_breakpoint() end, 'Debug: Toggle Breakpoint')
keymap('n', '<leader>dB', function()
  dap.set_breakpoint(vim.fn.input 'Debug: Breakpoint condition: ')
end, { desc = 'Conditional Breakpoint' })

nmap('<Leader>dr', function() dap.repl.open() end, 'Debug: Open Repl')
nmap('<Leader>dl', function() dap.run_last() end, 'Debug: Run Last')
nmap('<Leader>dx', function()
  dap.close()
  dapui.close()
end, 'Debug: Close')

-- {{{
-- [[ ToggleTerm ]]
-- nmap('<leader>rq', '<cmd>1ToggleTerm size=20 direction=horizontal<cr>', 'ToggleTerm: Horizontal Terminal 1')
-- nmap('<leader>rw', '<cmd>2ToggleTerm size=80 direction=vertical<cr>', 'ToggleTerm: Vertical Terminal 2')
-- nmap('<leader>re', '<cmd>3ToggleTerm direction=float<cr>', 'ToggleTerm: Floating Terminal 3')

-- stylua: ignore end
-- -- stylua: ignore start
-- -- [[Refactor]]
-- -- Extract function supports only visual mode
-- keymap("x", "<leader>re", function() require('refactoring').refactor('Extract Function') end, { desc = 'Extract Function' })
-- keymap("x", "<leader>rf", function() require('refactoring').refactor('Extract Function To File') end, { desc = 'Extract Function To File' })
-- -- Extract variable supports only visual mode
-- keymap("x", "<leader>rv", function() require('refactoring').refactor('Extract Variable') end, { desc = 'Extract Variable' })
-- -- Inline func supports only normal
-- keymap("n", "<leader>rI", function() require('refactoring').refactor('Inline Function') end, { desc = 'Inline Function' })
-- -- Inline var supports both normal and visual mode
-- keymap({ "n", "x" }, "<leader>ri", function() require('refactoring').refactor('Inline Variable') end, { desc = 'Inline Variable' })
-- -- Extract block supports only normal mode
-- keymap("n", "<leader>rb", function() require('refactoring').refactor('Extract Block') end, { desc = 'Extract Block' })
-- keymap("n", "<leader>rbf", function() require('refactoring').refactor('Extract Block To File') end, { desc = 'Extract Block To File' })
-- -- prompt for a refactor to apply when the remap is triggered
-- keymap(
--     {"n", "x"},
--     "<leader>rr",
--     function() require('refactoring').select_refactor() end, { desc = 'Select Refactor' }
-- )
-- Note that not all refactor support both normal and visual mode
-- stylua: ignore end

-- local widgets = require 'dap.ui.widgets'
-- nmap('<Leader>de', function() widgets.centered_float(widgets.scopes).open() end, 'Open Scopes')
-- nmap('<Leader>dv', function() widgets.centered_float(widgets.variables).open() end, 'Open Variables')
-- nmap('<Leader>df', function() widgets.centered_float(widgets.frames).open() end, 'Open Frames')
-- keymap({'n', 'v'}, '<Leader>dh', function()
--   require('dap.ui.widgets').hover()
-- end, { desc = 'Hover' })
-- keymap({'n', 'v'}, '<Leader>dp', function()
--   require('dap.ui.widgets').preview()
-- end, { desc = 'Preview' })
-- }}}
