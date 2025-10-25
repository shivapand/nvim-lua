-- Custom completion configuration for blink-cmp
local M = {}

-- Node modules completion for SCSS files
function M.setup_node_modules_completion()
  local blink = require('blink')
  
  -- Add custom completion source for node_modules
  blink.add_source('node_modules', {
    name = 'Node Modules',
    priority = 1000,
    filetypes = { 'scss', 'css', 'sass', 'less' },
    completion = function(context)
      local line = context.line
      local col = context.col
      local before_cursor = line:sub(1, col - 1)
      
      -- Check if we're after a ~ symbol (for SCSS imports)
      local tilde_match = before_cursor:match('~([^%s]*)$')
      if tilde_match then
        local completions = {}
        local node_modules_path = vim.fn.finddir('node_modules', '.;')
        
        if node_modules_path ~= '' then
          local packages = vim.fn.globpath(node_modules_path, '*', false, true)
          for _, package in ipairs(packages) do
            local package_name = vim.fn.fnamemodify(package, ':t')
            if package_name ~= '.' and package_name ~= '..' and not package_name:match('^%.') then
              table.insert(completions, {
                label = package_name,
                kind = 'Module',
                detail = 'node_modules package',
                insertText = package_name,
                filterText = tilde_match
              })
            end
          end
        end
        
        return completions
      end
      
      return {}
    end
  })
end

return M