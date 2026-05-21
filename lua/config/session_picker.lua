local M = {}
local unpack_fn = table.unpack or unpack

local function session_dir()
  return vim.fn.stdpath("state") .. "/sessions/"
end

local function list_sessions()
  local sessions = vim.fn.glob(session_dir() .. "*.vim", true, true)
  table.sort(sessions, function(a, b)
    local sa = vim.uv.fs_stat(a)
    local sb = vim.uv.fs_stat(b)
    local ma = sa and sa.mtime and sa.mtime.sec or 0
    local mb = sb and sb.mtime and sb.mtime.sec or 0
    return ma > mb
  end)
  return sessions
end

local function decode_session_name(path)
  local file = vim.fn.fnamemodify(path, ":t:r")
  local raw_dir, branch = unpack_fn(vim.split(file, "%%", { plain = true }))
  local dir = raw_dir:gsub("%%", "/")
  branch = branch and branch:gsub("%%", "/") or nil
  if jit.os:find("Windows") then
    dir = dir:gsub("^(%w)/", "%1:/")
  end
  return dir, branch
end

local function session_items()
  local items = {}
  for _, path in ipairs(list_sessions()) do
    local dir, branch = decode_session_name(path)
    local stat = vim.uv.fs_stat(path)
    items[#items + 1] = {
      path = path,
      dir = dir,
      branch = branch,
      mtime = stat and stat.mtime and stat.mtime.sec or 0,
      display = branch and branch ~= "" and (dir .. "  [" .. branch .. "]") or dir,
    }
  end
  return items
end

function M.select()
  local ok, pickers = pcall(require, "telescope.pickers")
  if not ok then
    require("persistence").select()
    return
  end

  local conf = require("telescope.config").values
  local finders = require("telescope.finders")
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local themes = require("telescope.themes")

  local items = session_items()
  if vim.tbl_isempty(items) then
    vim.notify("No saved sessions found", vim.log.levels.INFO)
    return
  end

  local opts = themes.get_dropdown({
    prompt_title = "Sessions",
    previewer = false,
    results_title = false,
    width = 0.72,
    height = 0.48,
  })

  pickers
    .new(opts, {
      finder = finders.new_table({
        results = items,
        entry_maker = function(item)
          return {
            value = item,
            display = vim.fn.fnamemodify(item.display, ":~"),
            ordinal = item.dir .. " " .. (item.branch or ""),
          }
        end,
      }),
      sorter = conf.generic_sorter({}),
      previewer = false,
      attach_mappings = function(prompt_bufnr, map)
        local function load_selected()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)
          if not selection or not selection.value then
            return
          end
          vim.fn.chdir(selection.value.dir)
          require("persistence").load()
        end

        actions.select_default:replace(load_selected)
        map({ "i", "n" }, "<C-j>", actions.move_selection_next)
        map({ "i", "n" }, "<C-k>", actions.move_selection_previous)
        map("n", "j", actions.move_selection_next)
        map("n", "k", actions.move_selection_previous)
        map("n", "q", actions.close)
        return true
      end,
    })
    :find()
end

return M
