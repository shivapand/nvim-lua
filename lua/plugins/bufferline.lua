return {
  'akinsho/bufferline.nvim',
  dependencies = {'nvim-tree/nvim-web-devicons'},
  config = function ()
    require("bufferline").setup {
      options = {
        mode = "tabs",
        numbers = "ordinal",
        show_close_icon = false,
        show_buffer_close_icons = false,
        show_duplicate_prefix = true,
        max_name_length = 25,
        max_prefix_length = 40,
        truncate_names = true,
        get_element_icon = function(buf)
          return require("nvim-web-devicons").get_icon(buf.name, nil, { default = false })
        end,
        name_formatter = function(buf)
          -- fallback if path is nil
          if not buf.path or buf.path == "" then
            return buf.name
          end

          local path = vim.fn.fnamemodify(buf.path, ":.:h") -- folder path relative to cwd
          local name = buf.name

          -- split path into segments safely
          local segments = {}
          for seg in string.gmatch(path, "[^/]+") do
            table.insert(segments, seg)
          end

          -- prepend last N segments (adjust N as needed)
          local N = 2
          local start_index = math.max(#segments - N + 1, 1)
          local prefix = table.concat({ unpack(segments, start_index, #segments) }, "/")

          return prefix .. "/" .. name
        end,
      }
    }
  end
}
