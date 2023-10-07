local M = {}

M.get_codelldb = function ()
  local mason_registry = require "mason-registry"
  local codelldb = mason_registry.get_package "codelldb"
  local extension_path = codelldb:get_install_path() .. "/extension/"
  local codelldb_path = extension_path .. "adapter/codelldb"
  local liblldb_path = ""
  if vim.loop.os_uname().sysname:find "Windows" then
    liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
  elseif vim.fn.has "mac" == 1 then
    liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
  else
    liblldb_path = extension_path .. "lldb/lib/liblldb.so"
  end
  return codelldb_path, liblldb_path
end

M.get_debug_server_js = function ()
  local mason_registry = require("mason-registry")
  local js_debug_adapter = mason_registry.get_package("js-debug-adapter")
  return js_debug_adapter:get_install_path() .. "/js-debug/src/dapDebugServer.js"
end

return M
