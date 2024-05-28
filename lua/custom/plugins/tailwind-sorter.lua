-- vim:ai:foldmethod=marker:foldlevel=0:
local enabled = false
if not enabled then
  return {}
end

return {
  'laytan/tailwind-sorter.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-lua/plenary.nvim' },
  build = 'cd formatter && npm i && npm run build',
  config = true,
}
