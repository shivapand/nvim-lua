return {
  'lewis6991/gitsigns.nvim',
  config = function()
    require('gitsigns').setup {
      on_attach = function(bufnr)
        local gitsigns = require('gitsigns')

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        map('n', ']h', function()
          if vim.wo.diff then
            vim.cmd.normal({ ']c', bang = true })
          else
            gitsigns.nav_hunk('next')
          end
        end, { desc = 'Goto next hunk' })

        map('n', '[h', function()
          if vim.wo.diff then
            vim.cmd.normal({ '[c', bang = true })
          else
            gitsigns.nav_hunk('prev')
          end
        end, { desc = 'Goto previous hunk' })

        map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'preview hunk' })

        map('n', '<leader>hb', function()
          gitsigns.blame_line({ full = true })
        end, { desc = 'git blame' })

        map('n', '<leader>hd', gitsigns.diffthis, { desc = 'diff this' })

        map('n', '<leader>hD', function()
          gitsigns.diffthis('~')
        end, { desc = 'diff this ~' })
      end
    }
  end
}
