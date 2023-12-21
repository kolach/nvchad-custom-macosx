---@type ChadrcConfig
local M = {}

M.ui = {
  theme = 'catppuccin',
  theme_toggle = {
    'catppuccin',
    'ayu_light',
  },
  tabufline = {
    lazyload = false,
  }
}
M.plugins = 'custom.plugins'
M.mappings = require "custom.mappings"

vim.opt.relativenumber = true
vim.opt.guifont = "JetBrainsMono Nerd Font:h17"

return M
