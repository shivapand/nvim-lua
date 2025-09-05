vim.opt.updatetime = 500

vim.api.nvim_create_autocmd(
  'CursorHold',
  {
    group = vim.api.nvim_create_augroup(
      'LspSagaDiagnostics',
      { clear = true }
    ),
    command = 'Lspsaga show_cursor_diagnostics ++unfocus',
    desc = 'Show LSP diagnostics on cursor hold',
  }
)


vim.api.nvim_create_autocmd(
  'BufReadPost',
  {
    group = vim.api.nvim_create_augroup(
      'OilRelativePathFix',
      { clear = true }
    ),
    callback = function()
      vim.cmd('cd `pwd`')
    end,
    desc = 'Fix for Oil opening files with absolute-path'
  }
)


vim.opt.sessionoptions:append('globals')

vim.api.nvim_create_autocmd(
  'User',
  {
    pattern = 'PersistenceSavePre',
    callback = function()
      vim.api.nvim_exec_autocmds(
        'User',
        { pattern = 'SessionSavePre' }
      )
    end,
  }
)


-- Path to save views
local view_file = vim.fn.stdpath("data") .. "/scroll_positions.json"

-- Load views from file
local function load_views()
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

-- Keep in-memory table of views
local buf_views = load_views()

-- Save position when leaving a buffer
vim.api.nvim_create_autocmd("BufLeave", {
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    local name = vim.api.nvim_buf_get_name(buf)
    if name ~= "" then
      buf_views[name] = vim.fn.winsaveview()
    end
  end,
})

-- Restore position when entering a buffer
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    local name = vim.api.nvim_buf_get_name(buf)
    local view = buf_views[name]
    if view then
      vim.fn.winrestview(view)
    end
  end,
})

-- Save everything on exit
vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    save_views(buf_views)
  end,
})
