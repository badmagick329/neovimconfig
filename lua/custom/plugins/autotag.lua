local enabled = true
if not enabled then
  return {}
end

local M = {
  'windwp/nvim-ts-autotag',
  event = 'BufRead',
}

function M.config()
  local autotag = require 'nvim-treesitter.configs'
  autotag.setup {
    autotag = {
      enable = true,
      enable_rename = true,
      enable_close = true,
      enable_close_on_slash = false,
    },
  }
end

return M
