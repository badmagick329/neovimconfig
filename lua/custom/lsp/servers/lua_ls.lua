return {
  settings = {
    Lua = {
      format = {
        enable = false,
      },
      diagnostics = {
        globals = { 'vim', 'spec' },
      },
      runtime = {
        version = 'LuaJIT',
        special = {
          spec = 'require',
        },
      },
      workspace = {
        checkThirdParty = false,
        library = {
          [vim.fn.expand '$VIMRUNTIME/lua'] = true,
          [vim.fn.stdpath 'config' .. '/lua'] = true,
        },
      },
      hint = {
        enable = true,
        arrayIndex = 'Disable', -- "Enable" | "Disable" | "Auto"
        await = true,
        paramName = 'All', -- "All" | "Literal" | "Disable"
        paramType = true,
        semiColon = 'All', -- "All" | "SameLine" | "Disable"
        setType = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
