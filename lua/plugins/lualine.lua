return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'echasnovski/mini.icons' },
  config = function(_)
    local function trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
      return function(str)
        local win_width = vim.fn.winwidth(0)
        if hide_width and win_width < hide_width then return ''
        elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
          return (no_ellipsis and '' or '...') .. str:sub(trunc_len)
        end
        return str
      end
    end

    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        always_show_tabline = true,
        globalstatus = false,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
          refresh_time = 16, -- ~60fps
          events = {
            'WinEnter',
            'BufEnter',
            'BufWritePost',
            'SessionLoadPost',
            'FileChangedShellPost',
            'VimResized',
            'Filetype',
            'CursorMoved',
            'CursorMovedI',
            'ModeChanged',
          },
        }
      },
      sections = {
        lualine_a = {},
        lualine_b = {
          {
            'branch',
            fmt = trunc(120, -10, 60),
            color = {
              bg = '#16161e'
            }
          }, {
            'diff',
            color = {
              bg = '#16161e'
            }
          }
        },
        lualine_c = {
          {
            'filename',
            path = 1
          }
        },
        lualine_x = {'diagnostics'},
        lualine_y = {},
        lualine_z = {}
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {}
    }
  end,
}
