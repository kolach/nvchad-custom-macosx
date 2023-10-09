local plugins = {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "codelldb",
        "rust-analyzer",
        "gopls",
        "gofumpt",
        "goimports-reviser",
        "golines",
        "eslint-lsp",
        "js-debug-adapter",
        "typescript-language-server",
        "prettier",
      }
}
  },
  {
    "neovim/nvim-lspconfig",
    config = function ()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end
  },
  {
    -- Enables Rust formatting on save
    "rust-lang/rust.vim",
    ft = "rust",
    init = function ()
      vim.g.rustfmt_autosave = 1
    end
  },
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",
    opts = function ()
      return require "custom.configs.rust-tools"
    end,
    config = function (_, opts)
      require("rust-tools").setup(opts)
    end
  },
  {
    "mfussenegger/nvim-dap",
    config = function ()
      require("custom.configs.dap")
      require("core.utils").load_mappings("dap")
    end
  },
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      require("custom.configs.dap-ui")
    end
  },
  -- To manage Rust crates
  -- See https://www.youtube.com/watch?v=mh_EJhH49Ms&t=600s
  -- See key mapping at custom/mapping.lua
  {
    "saecki/crates.nvim",
    dependencies = {"hrsh7th/nvim-cmp", "nvim-lua/plenary.nvim" },
    ft = {"rust", "toml"},
    opts = function ()
      return require("custom.configs.crates")
    end,
    config = function (_, opts)
      require("core.utils").load_mappings("crates")
      local crates = require("crates")
      crates.setup(opts)
      crates.show()
    end
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function ()
      local M = require "plugins.configs.cmp"
      table.insert(M.sources, {name = "crates"})
      return M
    end
  },
  -- End of: To manage Rust crates
  {
    "jose-elias-alvarez/null-ls.nvim",
    ft = {"go"},
    opts = function ()
      return require("custom.configs.null-ls")
    end
  },
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = "mfussenegger/nvim-dap",
    config = function (_, opts)
      require("dap-go").setup(opts)
      require("core.utils").load_mappings("dap_go")
    end,
  },
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    config = function (_, opts)
      require("gopher").setup(opts)
      require("core.utils").load_mappings("gopher")
    end,
    build = function ()
      vim.cmd [[silent! GoInstallDeps]]
    end
  },
  {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    config = function()
      require "custom.configs.lint"
    end
  },
  {
    "mhartington/formatter.nvim",
    event = "VeryLazy",
    opts = function()
      return require "custom.configs.formatter"
    end
  },
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function ()
      require("chatgpt").setup({
        api_key_cmd = "op read op://Private/gpt_api_key_nvim/credential",
      })
    end
  },
}

return plugins
