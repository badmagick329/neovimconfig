local enabled = true
if not enabled then
  return {}
end

local M = {

  'danymat/neogen',
  dependencies = 'nvim-treesitter/nvim-treesitter',
}

function M.config()
  require('neogen').setup {
    enable = true,
    languages = {
      python = {
        template = {
          annotation_convention = 'numpydoc',
        },
      },
      rust = {
        template = {
          annotation_convention = 'rustdoc',
        },
      },
    },
  }
end

return M
