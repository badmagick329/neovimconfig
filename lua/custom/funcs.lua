-- Set background to transparent
function Scuffed_transparent()
  local hgroups = {
    'Normal',
    'NormalFloat',
    'FloatBorder',
    'TelescopeNormal',
    'TelescopeBorder',
    'FloatTitle',
    'NormalNC',
    'Pmenu',
    'PmenuKind',
    'PmenuExtra',
    'PmenuSbar',
    'MsgArea',
    'Directory',
  }
  for _, hgroup in pairs(hgroups) do
    vim.api.nvim_set_hl(0, hgroup, { bg = 'none' })
  end
end

function Hybridlines()
  vim.o.nu = true
  vim.o.rnu = true
end

function Indent(n)
  vim.o.tabstop = n
  vim.o.softtabstop = n
  vim.o.shiftwidth = n
end

function Cprints()
  local filetype = vim.bo.filetype
  local c = '# '
  local p = 'print'
  if filetype == 'python' then
    c = '# '
    p = 'print'
  end
  vim.cmd([[%s/\(.*\)\(]] .. p .. [[\)\(.*\)/\1]] .. c .. [[\2\3/g]])
end

function Uprints()
  local filetype = vim.bo.filetype
  local c = '# '
  local p = 'print'
  if filetype == 'python' then
    c = '# '
    p = 'print'
  end
  vim.cmd([[%s/\(.*\)\(]] .. c .. p .. [[\)\(.*\)/\1]] .. p .. [[\3/g]])
end
