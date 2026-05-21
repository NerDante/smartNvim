local M = {}

M.default = "tokyonight"
M.statefile = vim.fn.stdpath("state") .. "/last-colorscheme"

local function ensure_state_dir()
  local dir = vim.fn.fnamemodify(M.statefile, ":h")
  vim.fn.mkdir(dir, "p")
end

local function set_background(colorscheme)
  if colorscheme == "gruvbox"
    or colorscheme == "tokyonight"
    or colorscheme == "onedark"
    or colorscheme == "catppuccin-mocha"
    or colorscheme == "kanagawa"
    or colorscheme == "kanagawa-wave"
    or colorscheme == "kanagawa-dragon"
  then
    vim.o.background = "dark"
  elseif colorscheme == "catppuccin-latte" or colorscheme == "kanagawa-lotus" then
    vim.o.background = "light"
  end
end

function M.apply(colorscheme)
  set_background(colorscheme)
  local ok, err = pcall(vim.cmd.colorscheme, colorscheme)
  if not ok then
    vim.notify(("Failed to load colorscheme '%s': %s"):format(colorscheme, err), vim.log.levels.WARN)
    return false
  end
  return true
end

function M.load()
  local colorscheme = M.default
  if vim.fn.filereadable(M.statefile) == 1 then
    local lines = vim.fn.readfile(M.statefile)
    if lines[1] and lines[1] ~= "" then
      colorscheme = lines[1]
    end
  end

  if not M.apply(colorscheme) then
    M.apply(M.default)
  end
end

function M.setup()
  local group = vim.api.nvim_create_augroup("ThemePersistence", { clear = true })

  vim.api.nvim_create_autocmd("ColorScheme", {
    group = group,
    desc = "Persist colorscheme choice",
    callback = function(event)
      ensure_state_dir()
      vim.fn.writefile({ event.match }, M.statefile)
    end,
  })

  vim.api.nvim_create_user_command("ThemePicker", function()
    vim.cmd("Telescope colorscheme enable_preview=true")
  end, { desc = "Pick a colorscheme with Telescope" })
end

return M
