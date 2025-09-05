-- Load all Lua files from lua/custom/
local custom_path = vim.fn.stdpath("config") .. "/lua/custom"

local function load_custom_modules()
  local handle = vim.loop.fs_scandir(custom_path)
  if not handle then return end

  while true do
    local name, t = vim.loop.fs_scandir_next(handle)
    if not name then break end

    if t == "file" and name:match("%.lua$") then
      local module = "custom." .. name:gsub("%.lua$", "")
      local ok, err = pcall(require, module)
      if not ok then
        vim.notify("Error loading " .. module .. "\n" .. err, vim.log.levels.ERROR)
      end
    end
  end
end

load_custom_modules()
