-- vim:ai:foldmethod=marker:foldlevel=0:
local themes = {}

-- {{{
themes.catpuccin = {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  lazy = false,
  config = function()
    require('catppuccin').setup {
      color_overrides = {
        --   latte = {
        --     base = "#e7c5e8",
        --     mantle = "#242424",
        --     crust = "#474747",
        -- },
      },
      flavour = 'macchiato', -- latte, frappe, macchiato, mocha
      background = {         -- :h background
        light = 'latte',
        dark = 'mocha',
      },
      transparent_background = true, -- disables setting the background color.
      show_end_of_buffer = false,    -- shows the '~' characters after the end of buffers
      term_colors = true,            -- sets terminal colors (e.g. `g:terminal_color_0`)
      dim_inactive = {
        enabled = false,             -- dims the background color of inactive window
        shade = 'dark',
        percentage = 0.15,           -- percentage of the shade to apply to the inactive window
      },
      no_italic = true,              -- Force no italic
      no_bold = false,               -- Force no bold
      no_underline = true,           -- Force no underline
      styles = {                     -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { 'italic' },     -- Change the style of comments
        conditionals = { 'italic' },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
      },
      custom_highlights = {},
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = false,
        mini = {
          enabled = true,
          indentscope_color = '',
        },
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
      },
    }

    -- setup must be called before loading
    vim.cmd.colorscheme 'catppuccin'
  end,
}
themes.sonokai = {
  -- Theme inspired by Atom
  'sainnhe/sonokai',
  priority = 1000,
  lazy = false,
  config = function()
    -- sonokai transparent
    vim.g.sonokai_transparent_background = '2'
    vim.g.sonokai_diagnostic_virtual_text = 'colored'
    vim.g.sonokai_style = 'espresso'
    vim.g.sonokari_better_performance = 1
    -- vim.g.sonokai_enable_italic = 1
    vim.cmd.colorscheme 'sonokai'
    vim.cmd [[set termguicolors]]
  end,
}

themes.tokyonight = {
  'folke/tokyonight.nvim',
  lazy = false,
  priority = 1000,
  opts = {},
  config = function()
    -- vim.g.tokyonight_style = "night"
    -- vim.g.tokyonight_italic_functions = true
    -- vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
    -- vim.g.tokyonight_dark_sidebar = true
    -- vim.g.tokyonight_dark_float = true
    -- vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }
    vim.cmd [[colorscheme tokyonight-day]]
  end,
}
-- }}}

-- Available themes:
--   * catpuccin
--   * sonokai
--   * tokyonight
local M = themes.catpuccin

return M
