local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local lspconfig = require("lspconfig")
local util = require("lspconfig/util")
local ih = require("inlay-hints")

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

-- 0.10 should support inlay hints by default (see line 11..13) but for some reason it doesn't work
-- the code bellow enables them using inlay-hints plugin
lspconfig.rust_analyzer.setup {
  on_attach = function (client, bufnr)
    on_attach(client, bufnr)
    ih.on_attach(client, bufnr)
  end,
}

lspconfig.gopls.setup {
  -- on_attach = on_attach,
  on_attach = function (client, bufnr)
    on_attach(client, bufnr)
    ih.on_attach(client, bufnr)
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
