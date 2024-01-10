return {
  settings = {
    json = {
      -- schemas = require('schemastore').json.schemas {
      -- To use a subset of the catalog:
      -- select = {
      --   '.eslintrc',
      --   'package.json',
      -- },
      -- To ignore a subset
      -- ignore = {
      --   '.eslintrc',
      --   'package.json',
      -- },
      -- },
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
    yaml = {
      schemaStore = {
        -- You must disable built-in schemaStore support if you want to use
        -- this plugin and its advanced options like `ignore`.
        enable = false,
        -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
        url = '',
      },
      schemas = require('schemastore').yaml.schemas(),
    },
  },
}
