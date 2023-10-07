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

return M
