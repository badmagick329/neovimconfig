local enabled = true
if not enabled then
  return {}
end

local M = {
  'numToStr/Comment.nvim',
  event = 'VeryLazy',
  lazy = false,
  commit = '0236521ea582747b58869cb72f70ccfa967d2e89',
}

function M.config()
  require('Comment').setup {
    ---Add a space b/w comment and the line
    padding = true,
    ---Whether the cursor should stay at its position
    sticky = true,
    ---Lines to be ignored while (un)comment
    ignore = nil,
    ---LHS of toggle mappings in NORMAL mode
    toggler = {
      ---Line-comment toggle keymap
      line = 'gcc',
      ---Block-comment toggle keymap
      block = 'gbc',
    },
    ---LHS of operator-pending mappings in NORMAL and VISUAL mode
    opleader = {
      ---Line-comment keymap
      line = 'gc',
      ---Block-comment keymap
      block = 'gb',
    },
    ---LHS of extra mappings
    extra = {
      ---Add comment on the line above
      above = 'gcO',
      ---Add comment on the line below
      below = 'gco',
      ---Add comment at the end of line
      eol = 'gcA',
    },
    ---Enable keybindings
    ---NOTE: If given `false` then the plugin won't create any mappings
    mappings = {
      ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
      basic = true,
      ---Extra mapping; `gco`, `gcO`, `gcA`
      extra = true,
    },
    ---Function to call before (un)comment
    pre_hook = function(...)
      local loaded, ts_comment =
          pcall(require, 'ts_context_commentstring.integrations.comment_nvim')
      if loaded and ts_comment then
        return ts_comment.create_pre_hook()(...)
      end
    end,
    ---Function to call after (un)comment
    post_hook = nil,
  }
end

return M

--
-- local M = {
--   'numToStr/Comment.nvim',
--   lazy = false,
--   dependencies = {
--     {
--       'JoosepAlviste/nvim-ts-context-commentstring',
--       event = 'VeryLazy',
--     },
--   },
-- }
--
-- function M.config()
--   vim.g.skip_ts_context_commentstring_module = true
--   ---@diagnostic disable:missing-fields
--   require('ts_context_commentstring').setup {
--     enable_autocmd = false,
--   }
--   require('Comment').setup {
--     ---Add a space b/w comment and the line
--     ---@type boolean
--     padding = true,
--     ---Line which should be ignored while comment/uncomment.
--     ---Could be a regular expression or a function that returns a regex string
--     ---or a table with list of regex strings or a function that returns a list of regex strings.
--     ---Example: Use '^$' to ignore empty lines
--     ---@type string|function|table|function
--     ignore = nil,
--     ---Whether to create basic (operator-pending) and extended mappings for NORMAL/VISUAL mode
--     ---@type table
--     mappings = {
--       ---operator-pending mapping
--       ---Includes `gcc`, `gcb`, `gc[count]{motion}` and `gb[count]{motion}`
--       basic = true,
--       ---extended mapping
--       ---Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
--       extended = true,
--     },
--     ---LHS of line and block comment toggle mapping in NORMAL/VISUAL mode
--     ---@type table
--     toggler = {
--       ---line-comment toggle
--       line = 'gcc',
--       ---block-comment toggle
--       block = 'gbc',
--     },
--     ---LHS of line and block comment operator-mode mapping in NORMAL/VISUAL mode
--     ---@type table
--     opleader = {
--       ---line-comment opfunc mapping
--       line = 'gc',
--       ---block-comment opfunc mapping
--       block = 'gb',
--     },
--     ---Pre-hook, called before commenting the line
--     ---@type function|nil
--     pre_hook = nil,
--     ---Post-hook, called after commenting is done
--     ---@type function|nil
--     post_hook = nil,
--   }
-- end
--
-- return M
