-- vim:ai:foldmethod=marker:foldlevel=0
local enabled = true
if not enabled then
  return {}
end

local M = {
  -- Autocompletion
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    {
      'hrsh7th/cmp-nvim-lsp',
      event = 'InsertEnter',
    },
    {
      'hrsh7th/cmp-emoji',
      event = 'InsertEnter',
    },
    {
      'hrsh7th/cmp-buffer',
      event = 'InsertEnter',
    },
    {
      'hrsh7th/cmp-path',
      event = 'InsertEnter',
    },
    {
      'hrsh7th/cmp-cmdline',
      event = 'InsertEnter',
    },
    {
      'saadparwaiz1/cmp_luasnip',
      event = 'InsertEnter',
    },
    {
      'L3MON4D3/LuaSnip',
      event = 'InsertEnter',
      dependencies = {
        'rafamadriz/friendly-snippets',
      },
    },
    {
      'hrsh7th/cmp-nvim-lua',
    },
    { 'roobert/tailwindcss-colorizer-cmp.nvim', config = true },
    'onsails/lspkind.nvim',
  },
}

function M.config()
  local ok, cmp = pcall(require, 'cmp')
  if not ok then
    return
  end
  vim.api.nvim_set_hl(0, 'CmpItemKindCopilot', { fg = '#6CC644' })
  vim.api.nvim_set_hl(0, 'CmpItemKindTabnine', { fg = '#CA42F0' })
  vim.api.nvim_set_hl(0, 'CmpItemKindCrate', { fg = '#F64D00' })
  vim.api.nvim_set_hl(0, 'CmpItemKindEmoji', { fg = '#FDE030' })
  local luasnip = require 'luasnip'
  local lspkind = require 'lspkind'
  require('luasnip.loaders.from_vscode').lazy_load()
  require('luasnip').filetype_extend('typescriptreact', { 'html' })

  local check_backspace = function()
    local col = vim.fn.col '.' - 1
    ---@diagnostic disable-next-line: param-type-mismatch
    return col == 0 or vim.fn.getline('.'):sub(col, col):match '%s'
  end
  local icons = require 'custom.icons'

  cmp.setup {
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    formatting = {
      -- {{{
      -- fields = { 'kind', 'abbr', 'menu' },
      -- format = function(entry, vim_item)
      --   vim_item.kind = icons.kind[vim_item.kind]
      --   vim_item.menu = ({
      --     nvim_lsp = '',
      --     nvim_lua = '',
      --     luasnip = '',
      --     buffer = '',
      --     path = '',
      --     emoji = '',
      --   })[entry.source.name]
      --   if entry.source.name == 'copilot' then
      --     vim_item.kind = icons.git.Octoface
      --     vim_item.kind_hl_group = 'CmpItemKindCopilot'
      --   end
      --
      --   if entry.source.name == 'cmp_tabnine' then
      --     vim_item.kind = icons.misc.Robot
      --     vim_item.kind_hl_group = 'CmpItemKindTabnine'
      --   end
      --
      --   if entry.source.name == 'crates' then
      --     vim_item.kind = icons.misc.Package
      --     vim_item.kind_hl_group = 'CmpItemKindCrate'
      --   end
      --
      --   if entry.source.name == 'lab.quick_data' then
      --     vim_item.kind = icons.misc.CircuitBoard
      --     vim_item.kind_hl_group = 'CmpItemKindConstant'
      --   end
      --
      --   if entry.source.name == 'emoji' then
      --     vim_item.kind = icons.misc.Smiley
      --     vim_item.kind_hl_group = 'CmpItemKindEmoji'
      --   end
      --
      --   return vim_item
      -- end,
      -- }}}

      format = require('cmp-tailwind-colors').format,

      -- {{{
      -- format = lspkind.cmp_format {
      --   mode = 'symbol_text', -- show only symbol annotations
      --   maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      --   -- can also be a function to dynamically calculate max width such as
      --   -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
      --   ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
      --   symbol_map = {
      --     Text = icons.kind.Text,
      --     Method = icons.kind.Method,
      --     Function = icons.kind.Function,
      --     Constructor = icons.kind.Constructor,
      --     Field = icons.kind.Field,
      --     Variable = icons.kind.Variable,
      --     Class = icons.kind.Class,
      --     Interface = icons.kind.Interface,
      --     Module = icons.kind.Module,
      --     Property = icons.kind.Property,
      --     Unit = icons.kind.Unit,
      --     Value = icons.kind.Value,
      --     Enum = icons.kind.Enum,
      --     Keyword = icons.kind.Keyword,
      --     Snippet = icons.kind.Snippet,
      --     Color = icons.kind.Color,
      --     File = icons.kind.File,
      --     Reference = icons.kind.Reference,
      --     Folder = icons.kind.Folder,
      --     EnumMember = icons.kind.EnumMember,
      --     Constant = icons.kind.Constant,
      --     Struct = icons.kind.Struct,
      --     Event = icons.kind.Event,
      --     Operator = icons.kind.Operator,
      --     TypeParameter = icons.kind.TypeParameter,
      --   },
      --
      --   -- The function below will be called before any actual modifications from lspkind
      --   -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      --   -- before = function (entry, vim_item)
      --   --   ...
      --   --   return vim_item
      --   -- end
      -- },
      -- }}}
    },
    completion = { completeopt = 'noselect' },
    preselect = cmp.PreselectMode.None,
    mapping = cmp.mapping.preset.insert {
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      -- ['<C-Space>'] = cmp.mapping.complete {},
      ['<C-e>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      },
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_locally_jumpable() then
          luasnip.expand_or_jump()
        elseif check_backspace() then
          fallback()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.locally_jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),
    },
    sources = {
      { name = 'copilot' },
      {
        name = 'nvim_lsp',
        entry_filter = function(entry, ctx)
          local kind =
              require('cmp.types.lsp').CompletionItemKind[entry:get_kind()]
          if kind == 'Snippet' and ctx.prev_context.filetype == 'java' then
            return false
          end

          if ctx.prev_context.filetype == 'markdown' then
            return true
          end

          if kind == 'Text' then
            return false
          end

          return true
        end,
      },
      { name = 'copilot' },
      { name = 'luasnip' },
      { name = 'cmp_tabnine' },
      { name = 'nvim_lua' },
      { name = 'buffer' },
      { name = 'path' },
      { name = 'calc' },
      { name = 'emoji' },
      { name = 'treesitter' },
      { name = 'crates' },
      { name = 'tmux' },
    },
    -- {{{
    -- sources = {
    --   { name = 'copilot', group_index = 2 },
    --   -- { name = 'nvim_lsp', group_index = 2 },
    --   {
    --     name = 'nvim_lsp',
    --     keyword_length = 1,
    --     group_index = 2,
    --     max_item_count = 40,
    --   },
    --   { name = 'path', group_index = 2 },
    --   { name = 'luasnip', group_index = 2 },
    -- },
    -- }}}
    confirm_opts = {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    window = {
      completion = {
        border = 'rounded',
        -- winhighlight = 'Normal:Pmenu,CursorLine:PmenuSel,FloatBorder:FloatBorder,Search:None',
        col_offset = -3,
        side_padding = 1,
        scrollbar = false,
        scrolloff = 8,
      },
      documentation = {
        border = 'rounded',
        -- winhighlight = 'Normal:Pmenu,FloatBorder:FloatBorder,Search:None',
      },
    },
    experimental = {
      ghost_text = false,
    },

    -- cmp with autopairs
    -- pcall(function()
    --   local function on_confirm_done(...)
    --     require('nvim-autopairs.completion.cmp').on_confirm_done()(...)
    --   end
    --   require('cmp').event:off('confirm_done', on_confirm_done)
    --   require('cmp').event:on('confirm_done', on_confirm_done)
    -- end),
  }
end

-- {{{
function M.old_config()
  local ok, cmp = pcall(require, 'cmp')
  if not ok then
    return
  end
  local luasnip = require 'luasnip'
  require('luasnip.loaders.from_vscode').lazy_load()
  luasnip.config.setup {}
  cmp.setup {
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    formatting = {
      format = require('cmp-tailwind-colors').format,
    },
    completion = { completeopt = 'noselect' },
    preselect = cmp.PreselectMode.None,
    mapping = cmp.mapping.preset.insert {
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      -- ['<C-Space>'] = cmp.mapping.complete {},
      ['<C-e>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      },
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_locally_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.locally_jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),
    },
    sources = {
      { name = 'copilot' },
      {
        name = 'nvim_lsp',
        entry_filter = function(entry, ctx)
          local kind =
              require('cmp.types.lsp').CompletionItemKind[entry:get_kind()]
          if kind == 'Snippet' and ctx.prev_context.filetype == 'java' then
            return false
          end

          if ctx.prev_context.filetype == 'markdown' then
            return true
          end

          if kind == 'Text' then
            return false
          end

          return true
        end,
      },
      { name = 'luasnip' },
      { name = 'cmp_tabnine' },
      { name = 'nvim_lua' },
      { name = 'buffer' },
      { name = 'path' },
      { name = 'calc' },
      { name = 'emoji' },
      { name = 'treesitter' },
      { name = 'crates' },
      { name = 'tmux' },
    },
    -- sources = {
    --   { name = 'copilot', group_index = 2 },
    --   -- { name = 'nvim_lsp', group_index = 2 },
    --   {
    --     name = 'nvim_lsp',
    --     keyword_length = 1,
    --     group_index = 2,
    --     max_item_count = 40,
    --   },
    --   { name = 'path', group_index = 2 },
    --   { name = 'luasnip', group_index = 2 },
    -- },
  }
end

-- }}}

return M