local enabled = true
if not enabled then
  return {}
end

return {
  'christoomey/vim-tmux-navigator',
  config = function()
    vim.g.tmux_navigator_no_mappings = 1
    vim.g.tmux_navigator_no_wrap = 1
  end,
}
