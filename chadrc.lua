---@type ChadrcConfig
local M = {}

M.ui = {
  theme = 'catppuccin',
  theme_toggle = {
    'catppuccin',
    'ayu_light',
  },
}
M.plugins = 'custom.plugins'
M.mappings = require "custom.mappings"

return M
