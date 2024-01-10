-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = false
vim.o.termguicolors = true

-- Undo dir
vim.o.undodir = os.getenv 'HOME' .. '/.vim/undodir'
vim.o.undofile = true
vim.o.swapfile = false

-- Make line numbers default
vim.wo.number = true
-- Hybrid line numbers
vim.o.nu = true
vim.o.rnu = true

-- Set tab length to 4
vim.o.tabstop = 4      -- size of a hard tabstop (ts)
vim.o.softtabstop = 4  -- number of spaces a <Tab> counts for. When 0, feature is off (sts)
vim.o.shiftwidth = 4   -- size of an indent (sw)
vim.o.expandtab = true -- always use spaces instead of tabs

-- better scrolling
vim.o.scrolloff = 8

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 150
vim.o.timeoutlen = 1000

-- Color column
vim.o.colorcolumn = '80'

-- Popup menu
vim.opt.pumheight = 10 -- pop up menu height
vim.opt.pumblend = 10

vim.opt.cmdheight = 1             -- more space in the neovim command line for displaying messages
vim.opt.backup = false            -- creates a backup file
vim.opt.writebackup = false       -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.guifont = 'monospace:h17' -- the font used in graphical neovim applications
vim.opt.title = false

-- [[ Plugins ]]
-- Set completeopt to have a better completion experience. For cmp
vim.o.completeopt = 'menuone,noselect'

-- repl settings
vim.g.repl_filetype_commands = {
  python = 'ipython --no-autoindent',
  -- python = "ptpython --dark-bg",
  javascript = 'node',
}
vim.g.repl_split = 'right'
