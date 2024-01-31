local enabled = true
if not enabled then
  return {}
end

local M = {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'VeryLazy',
}

function M.config()
  local copilot = require 'copilot'
  local cmp_status_ok, cmp = pcall(require, 'cmp')
  if cmp_status_ok then
    cmp.event:on('menu_opened', function()
      vim.b.copilot_suggestion_hidden = true
    end)

    cmp.event:on('menu_closed', function()
      vim.b.copilot_suggestion_hidden = false
    end)
  end
  copilot.setup {
    panel = {
      enabled = false,
      auto_refresh = false,
      keymap = {
        jump_prev = '[[',
        jump_next = ']]',
        -- Keymapping in cmp. otherwise have issues with autpair
        -- accept = '<M-;>',
        -- refresh = "gr",
        open = '<M-i>',
      },
      layout = {
        position = 'bottom', -- | top | left | right
        ratio = 0.4,
      },
    },
    suggestion = {
      enabled = true,
      auto_trigger = true,
      debounce = 75,
      keymap = {
        accept = false,
        accept_word = false,
        accept_line = false,
        next = '<M-]>',
        prev = '<M-[>',
        dismiss = '<C-]>',
      },
    },
    filetypes = {
      yaml = false,
      markdown = false,
      help = false,
      gitcommit = false,
      gitrebase = false,
      hgcommit = false,
      norg = false,
      svn = false,
      cvs = false,
      text = false,
      sh = function()
        if
            string.match(
              vim.fs.basename(vim.api.nvim_buf_get_name(0)),
              '^%.env.*'
            )
        then
          -- disable for .env files
          return false
        end
        return true
      end,
      ['.'] = false,
    },
    copilot_node_command = 'node', -- Node.js version must be > 16.x
    server_opts_overrides = {},
  }
end

return M
