local M = {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available. Make sure you have the system
    -- requirements installed.
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
  },
}
-- lua regex https://www.lua.org/pil/20.2.html
-- magic chars:
-- ( ) . % + - * ? [ ^ $
function M.config()
  local t = require 'telescope'
  t.setup {
    defaults = {
      prompt_prefix = '🔭 ',
      selection_caret = '➡ ',
      -- path_display = { 'smart' },

      mappings = {
        i = {
          ['<C-u>'] = false,
          ['<C-d>'] = false,
        },
      },
      file_ignore_patterns = {
        'node%_modules/*',
        '%.git/.*',
        'venv/.*',
        'vnv/.*',
        '__pycache__/.*',
        '%.pytest_cache/.*',
        'go.sum',
        '%.jpeg$',
        '%.jpg$',
        '%.png$',
        '%.mp4$',
        '%.webm$',
        '%.mkv$',
        '%.avi$',
        'package-lock.json$',
        'yarn.lock$',
        -- lua regex https://www.lua.org/pil/20.2.html
        '%.next/.*',
        '%.DS_Store$',
        '^fontawesomefree/.*',
        'db/.*',
        '%assetmanager/static/.*',
      },
    },
  }
  -- Enable telescope fzf native, if installed
  pcall(t.load_extension, 'fzf')
end

return M
