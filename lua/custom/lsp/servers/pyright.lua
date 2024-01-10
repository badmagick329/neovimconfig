return {
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        autoImportCompletions = true,
        completeFunctionParens = true,
        diagnosticMode = 'workspace',
        useLibraryCodeForTypes = true,
        -- useLibraryCodeForTypes = false,
        diagnosticSeverityOverrides = {
          reportGeneralTypeIssues = 'none',
          reportOptionalSubscript = 'none',
          reportPrivateUsage = 'warning',
          reportOptionalMemberAccess = 'none',
        },
      },
    },
  },
}
