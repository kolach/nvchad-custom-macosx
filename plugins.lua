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
        "clangd",
        "clang-format",
        "pyright",
        "mypy",
        "ruff",
        "black",
        "debugpy",
        "ruby-lsp",
      }
    }
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "rust",
        "cpp",
        "go",
        "typescript",
        "javascript",
        "python",
        "markdown",
      },
    },
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
    event = "VeryLazy",
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
      -- require("chatgpt").setup()
      require("chatgpt").setup({
        api_key_cmd = "op read op://Private/gpt_api_key_nvim/credential --no-newline",
      })
    end
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    opts = {
      handlers = {},
    },
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function (_, _)
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
      require("core.utils").load_mappings("dap_python")
    end,
  },
  {
    "m4xshen/hardtime.nvim",
    event = "VeryLazy",
    enabled = false,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
    },
    opts = {
      disable_mouse = false,
      restricted_keys = {
        -- remove Enter from restricted keys to make
        -- wildfire work
        ["<CR>"] = {},
      },
    },
    config = function (_, opts)
      require("hardtime").setup(opts)
    end,
  },
  {
    "sustech-data/wildfire.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function (_, _)
      require("wildfire").setup()
    end,
  },
  {
    "abecodes/tabout.nvim",
    event = "VeryLazy",
    branch = "feature/tabout-md",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "hrsh7th/nvim-cmp",
    },
    config = function (_, _)
      require("tabout").setup()
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end
  },
  {
    "roobert/tabtree.nvim",
    event = "VeryLazy",
    ft = {"rust"},
    opts = {
      language_configs = {
        rust = {
          target_query = [[
            (struct_item) @struct_item_capture
            (impl_item) @impl_item_capture
            (function_item) @function_item_capture
          ]],
          -- experimental feature, to move the cursor in certain situations like when handling python f-strings
          offsets = {
            string_start_capture = 1,
          },
        },
      },
    },
    config = function(_, opts)
      require("tabtree").setup(opts)
    end,
  },
}

return plugins
