local M = {}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Toggle breakpoint",
    },
    ["<leader>dr"] = {
      "<cmd> DapContinue <CR>",
      "Run or continue the debugger"
    },
    ["<leader>duc"] = {
      function ()
        require("dapui").close()
      end,
      "Close debugger UI"
    },
    ["<leader>duo"] = {
      function ()
        require("dapui").open()
      end,
      "Open debuger UI"
    },
  }
}

M.dap_go = {
  plugin = true,
  n = {
    ["<leader>dgt"] = {
      function ()
        require("dap-go").debug_test()
      end,
      "Debug go test",
    },
    ["<leader>dgl"] = {
      function ()
        require("dap-go").debug_last()
      end,
      "Debug last go test",
    },
  }
}

M.crates = {
  plugin = true,
  n = {
    ["<leader>rcu"] = {
      function ()
        require("crates").upgrade_all_crates()
      end,
      "Update crates"
    },
    ["<leader>rch"] = {
      function ()
        require("crates").open_homepage()
      end,
      "Open home page"
    },
    ["<leader>rcr"] = {
      function ()
        require("crates").open_repository()
      end,
      "Open repository"
    },
    ["<leader>rcD"] = {
      function ()
        require("crates").open_documentation()
      end,
      "Open documentation"
    },
    ["<leader>rcv"] = {
      function ()
        require("crates").show_versions_popup()
        require("crates").focus_popup()
      end,
      "Show versions"
    },
    ["<leader>rcf"] = {
      function ()
        require("crates").show_features_popup()
        require("crates").focus_popup()
      end,
      "Show features"
    },
    ["<leader>rcd"] = {
      function ()
        require("crates").show_dependencies_popup()
      end,
      "Show dependencies"
    },
  }
}

M.gopher = {
  plugin = true,
  n = {
    ["<leader>gsj"] = {
      "<cmd> GoTagAdd json <CR>",
      "Add json struct tags",
    },
    ["<leader>gsy"] = {
      "<cmd> GoTagAdd yaml <CR>",
      "Add yaml struct tags"
    }
  }
}

return M
