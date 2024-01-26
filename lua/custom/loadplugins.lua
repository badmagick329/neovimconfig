-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',
  -- GOAT surround plugin
  'tpope/vim-surround',
  -- lets you repeat things like vim surround motions
  'tpope/vim-repeat',
  'pappasam/nvim-repl',
  'mbbill/undotree',
  -- need this for go
  'simrat39/inlay-hints.nvim',
  -- lazygit
  {
    'kdheepak/lazygit.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },
  -- telescope dap
  'nvim-telescope/telescope-dap.nvim',
  -- Better sort
  'sQVe/sort.nvim',
  -- Context
  -- 'nvim-treesitter/nvim-treesitter-context',

  { import = 'custom.plugins' },
  require 'custom.dap',
}, {
  change_detection = {
    enabled = true,
    notify = false,
  },
  ui = {
    border = 'rounded',
  },
})
