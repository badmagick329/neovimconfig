local M = {
  -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  event = { 'BufReadPost', 'BufNewFile' },
  commit = 'afa103385a2b5ef060596ed822ef63276ae88016',
  build = ':TSUpdate',
  dependencies = {
    {
      'nvim-treesitter/nvim-treesitter-textobjects',
      event = 'VeryLazy',
      -- commit = '78c49ca7d2f7ccba2115c11422c037713c978ad1',
    },
    {
      'JoosepAlviste/nvim-ts-context-commentstring',
      event = 'VeryLazy',
      -- commit = '92e688f013c69f90c9bbd596019ec10235bc51de',
    },
    {
      'windwp/nvim-ts-autotag',
      event = 'VeryLazy',
      -- commit = '6be1192965df35f94b8ea6d323354f7dc7a557e4',
    },
    {
      'windwp/nvim-autopairs',
      event = 'InsertEnter',
      -- commit = 'f6c71641f6f183427a651c0ce4ba3fb89404fa9e',
    },
  },
}

function M.config()
  require('nvim-treesitter.configs').setup {
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = {
      'awk',
      'bash',
      'c',
      'cpp',
      'css',
      'csv',
      'dockerfile',
      'fish',
      'git_config',
      'git_rebase',
      'gitattributes',
      'gitcommit',
      'gitignore',
      'go',
      'gomod',
      'gosum',
      'gowork',
      'html',
      'htmldjango',
      'http',
      'javascript',
      'jq',
      'json',
      'jsonc',
      'lua',
      'luap',
      'make',
      'markdown',
      'markdown_inline',
      'python',
      'query',
      'regex',
      'ruby',
      'rust',
      'scheme',
      'scss',
      'sql',
      'toml',
      'tsx',
      'typescript',
      'vim',
      'vimdoc',
      'vue',
      'yaml',
    },
    auto_install = true,

    highlight = { enable = true, use_languagetree = true },
    indent = { enable = true, disable = { 'python' } },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<c-v>',
        node_incremental = '<c-v>',
        scope_incremental = '<c-s>',
        node_decremental = '<c-b>',
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
          ['ii'] = '@conditional.inner',
          ['ai'] = '@conditional.outer',
          ['il'] = '@loop.inner',
          ['al'] = '@loop.outer',
          ['at'] = '@comment.outer',
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          [']m'] = '@function.outer',
          [']]'] = '@class.outer',
        },
        goto_next_end = {
          [']M'] = '@function.outer',
          [']['] = '@class.outer',
        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[['] = '@class.outer',
        },
        goto_previous_end = {
          ['[M'] = '@function.outer',
          ['[]'] = '@class.outer',
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<leader>a'] = '@parameter.inner',
        },
        swap_previous = {
          ['<leader>A'] = '@parameter.inner',
        },
      },
    },
  }
end

return M
