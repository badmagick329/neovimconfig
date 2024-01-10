local enabled = true
if not enabled then
  return {}
end

local M = {
  'windwp/nvim-autopairs',
  event = 'BufRead',
  dependencies = { 'hrsh7th/nvim-cmp' },
}

function M.config()
  require('nvim-autopairs').setup {}
  -- NOTE: Automatically add `(` after selecting a function or method
  local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
  local cmp = require 'cmp'
  cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
end

return M
