local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local get_codelldb = require("custom.configs.dap-utils").get_codelldb
local codelldb_path, liblldb_path = get_codelldb()

local options = {
  server = {
    on_attach = on_attach,
    capabilities = capabilities,
  },
  dap = {
    adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
  },
}

return options
