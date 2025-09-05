-- scrollsave.lua
-- Persist cursor + scroll position across buffers & sessions

local M = {}

-- Path to save views
local view_file = vim.fn.stdpath("data") .. "/scroll_positions.json"

-- Load views from file
local function load_views()
  print('Load')
  local f = io.open(view_file, "r")
  if not f then return {} end
  local ok, data = pcall(vim.json.decode, f:read("*a"))
  f:close()
  return ok and data or {}
end

-- Save views to file
local function save_views(views)
  local f = io.open(view_file, "w")
  if not f then return end
  f:write(vim.json.encode(views))
  f:close()
end

-- In-memory table of views
local buf_views = load_views()

-- Check if buffer is "normal" (not special)
local function is_normal_buf(buf)
  if vim.bo[buf].buftype ~= "" then return false end
  if vim.bo[buf].filetype == "" then return false end
  return true
end

-- Public: setup autocmds
function M.setup()
  -- Save position when leaving buffer
  vim.api.nvim_create_autocmd("BufLeave", {
    callback = function()
      local buf = vim.api.nvim_get_current_buf()
      if not is_normal_buf(buf) then return end
      local name = vim.api.nvim_buf_get_name(buf)
      if name ~= "" then
        buf_views[name] = vim.fn.winsaveview()
      end
    end,
  })

  -- Restore position when entering buffer
  vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
      local buf = vim.api.nvim_get_current_buf()
      if not is_normal_buf(buf) then return end
      local name = vim.api.nvim_buf_get_name(buf)
      local view = buf_views[name]
      if view then
        vim.fn.winrestview(view)
      end
    end,
  })

  -- On exit, prune invalid files and save
  vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = function()
      local cleaned = {}
      for name, view in pairs(buf_views) do
        if vim.fn.filereadable(name) == 1 then
          cleaned[name] = view
        end
      end
      save_views(cleaned)
    end,
  })

  -- Optional: user commands
  vim.api.nvim_create_user_command("ScrollSave", function()
    local buf = vim.api.nvim_get_current_buf()
    if is_normal_buf(buf) then
      buf_views[vim.api.nvim_buf_get_name(buf)] = vim.fn.winsaveview()
      save_views(buf_views)
      print("Scroll position saved")
    end
  end, {})

  vim.api.nvim_create_user_command("ScrollRestore", function()
    local buf = vim.api.nvim_get_current_buf()
    if is_normal_buf(buf) then
      local view = buf_views[vim.api.nvim_buf_get_name(buf)]
      if view then
        vim.fn.winrestview(view)
        print("Scroll position restored")
      end
    end
  end, {})
end

return M
