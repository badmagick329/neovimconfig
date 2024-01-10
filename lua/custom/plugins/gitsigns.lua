local enabled = true
if not enabled then
  return {}
end

return {
  'lewis6991/gitsigns.nvim',
  opts = {
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
    on_attach = function(bufnr)
      vim.keymap.set(
        'n',
        '<leader>gp',
        require('gitsigns').prev_hunk,
        { buffer = bufnr, desc = '[G]o to [P]revious Hunk' }
      )
      vim.keymap.set(
        'n',
        '<leader>gn',
        require('gitsigns').next_hunk,
        { buffer = bufnr, desc = '[G]o to [N]ext Hunk' }
      )
      vim.keymap.set(
        'n',
        '<leader>gh',
        require('gitsigns').preview_hunk,
        { buffer = bufnr, desc = 'Preview [H]unk' }
      )
    end,
  },
}
