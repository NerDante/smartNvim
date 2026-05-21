vim.g.mapleader = ";"
vim.g.maplocalleader = "\\"

if vim.loader then
  pcall(vim.loader.enable)
end

require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lazy")
