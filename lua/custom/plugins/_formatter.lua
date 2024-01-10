-- vim:ai:foldmethod=marker:foldlevel=0:
local enabled = false
if not enabled then
  return {}
end

-- Default formatters:
-- https://github.com/mhartington/formatter.nvim/tree/master/lua/formatter/filetypes
local M = {
  'mhartington/formatter.nvim',
  event = 'VeryLazy',
}

-- {{{
local get_formatters = function()
  local util = require 'formatter.util'
  local formatters = {}
  formatters.lua = {
    function()
      -- Conditional formatting example
      if util.get_current_buffer_file_name() == 'special.lua' then
        return nil
      end
      return {
        exe = 'stylua',
        args = {
          '--search-parent-directories',
          '--stdin-filepath',
          util.escape_path(util.get_current_buffer_file_path()),
          '--',
          '-',
        },
        stdin = true,
      }
    end,
  }
  formatters.sql = {
    function()
      return {
        exe = 'sql-formatter-cli',
        args = {
          '-',
        },
        stdin = true,
      }
    end,
  }
  formatters.go = {
    --[[
          golines -m 79 -t 4
          --]]
    function()
      return {
        exe = 'golines',
        -- args = {
        --   '-m',
        --   '79',
        --   '-t',
        --   '4',
        --   '-w',
        --   util.escape_path(util.get_current_buffer_file_path()),
        -- },
        stdin = true,
      }
    end,
  }
  formatters.python = {
    function()
      return {
        exe = 'black',
        args = {
          '-q',
          '--line-length',
          '79',
          '-',
        },
        stdin = true,
      }
    end,
    function()
      return {
        exe = 'isort',
        args = {
          '-',
        },
        stdin = true,
      }
    end,
  }
  formatters.djlint = {
    function()
      return {
        exe = 'djlint',
        args = {
          '--indent',
          '2',
          '--quiet',
          '--format-css',
          '--max-line-length',
          '80',
          '--indent-css',
          '5',
          '--max-attribute-length',
          '80',
          '-',
          '--reformat',
        },
        stdin = true,
      }
    end,
  }
  formatters.prettierd = {
    function()
      return {
        exe = 'prettierd',
        args = {
          util.escape_path(util.get_current_buffer_file_path()),
        },
        stdin = true,
      }
    end,
  }
  formatters.prisma = {
    function()
      return {
        exe = 'npx',
        args = {
          'prisma',
          'format',
          '--schema',
          util.escape_path(util.get_current_buffer_file_path()),
        },
        stdin = false,
      }
    end,
  }
  return formatters
end
-- }}}

function M.config()
  local util = require 'formatter.util'
  local formatters = get_formatters()

  require('formatter').setup {
    -- Enable or disable logging
    logging = true,
    -- Set the log level
    log_level = vim.log.levels.WARN,
    filetype = {

      -- Formatter configurations for filetype "lua" go here
      -- and will be executed in order
      lua = formatters.lua,
      c = {
        -- default c formatter
        require('formatter.filetypes.c').clangformat,
      },
      rust = {
        require('formatter.filetypes.rust').rustfmt,
      },
      sql = formatters.sql,
      go = formatters.go,
      python = formatters.python,
      htmldjango = formatters.djlint,
      html = formatters.djlint,
      javascript = formatters.prettierd,
      javascriptreact = formatters.prettierd,
      typescript = formatters.prettierd,
      typescriptreact = formatters.prettierd,
      markdown = formatters.prettierd,
      prisma = formatters.prisma,
      -- Use the special "*" filetype for defining formatter configurations on
      -- any filetype
      ['*'] = {
        -- "formatter.filetypes.any" defines default configurations for any
        -- filetype
        require('formatter.filetypes.any').remove_trailing_whitespace,
      },
    },
  }
end

return M
