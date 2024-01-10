local M = {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'AndreM222/copilot-lualine',
    {
      'nvim-tree/nvim-web-devicons',
      opt = true,
    },
  },
}

function M.config()
  require('lualine').setup {
    options = {
      icons_enabled = false,
      theme = 'auto',
      section_separators = { left = '', right = ' ' },
      component_separators = { left = '', right = '|' },
      ignore_focus = { 'neo-tree' },
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'diff', 'diagnostics' },
      -- lualine_b = {'%=', '%t%m', '%3p'}
      lualine_c = { { 'filename', file_status = true, path = 1 } },
      lualine_x = { 'encoding', 'fileformat', 'filetype', 'copilot' },
      lualine_y = { 'progress' },
      lualine_z = { 'location' },
    },
    extensions = { 'quickfix', 'man', 'fugitive' },
  }
end

return M
