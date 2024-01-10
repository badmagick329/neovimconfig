local enabled = true
if not enabled then
  return {}
end

local opts = {
  timeout = 100,
  stages = 'fade_in_slide_out',
  top_down = true,
  render = 'simple',
  fps = 60,
  skip = true,
}

local M = {

  'rcarriga/nvim-notify',
  event = 'BufReadPre',
  filter = {
    event = 'msg_show',
    any = {
      { find = '%d+L, %d+B' },
      { find = '; after #%d+' },
      { find = '; before #%d+' },
      { find = '%d fewer lines' },
      { find = '%d more lines' },
    },
  },
  opts = opts,
}

function M.config()
  local notfiy = require 'notify'
  require('notify').setup {
    background_colour = '#000000',
  }
  vim.notify = notfiy
end

return M
