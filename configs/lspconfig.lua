local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local lspconfig = require("lspconfig")
local util = require("lspconfig/util")

lspconfig.clangd.setup {
  on_attach = function (client, bufnr)
    client.server_capabilities.signatureHelpProvider = false
    if client.server_capabilities.inlayHintProvider then
      vim.g.inlay_hints_visible = true
      vim.lsp.inlay_hint(bufnr, true)
    else
      print("no inlay hints available")
    end
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
}

lspconfig.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "python" },
}

-- YAML language server setup
lspconfig.yamlls.setup {
  capabilities = capabilities,
  settings = {
    yaml = {
      schemas = {
        -- ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
        -- Add other schemas here
        -- ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.0/schema.json"] = "*.yaml",
        -- ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*.yaml",
      },
    },
  },
}

lspconfig.gopls.setup {
  on_attach = function (client, bufnr)
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
  cmd = {"gopls"},
  filetypes = {"go", "gomod", "gowork", "gotmpl"},
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      semanticTokens = true,
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    }
  },
}

lspconfig.tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    prederences = {
      disableSuggestions = true,
    }
  }
}

lspconfig.ruby_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "ruby" },
}

lspconfig.solidity.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "solidity" },
  root_dir = util.find_git_ancestor,
}
