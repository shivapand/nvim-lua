--[[ return {
  "echasnovski/mini.pairs",
  event = "InsertEnter", -- lazy-load on insert
  config = function()
    require('mini.pairs').setup({
      -- default mappings are automatically applied, so you can omit `mappings`
      -- but if you want to add a custom one like "surround":
      mappings = {
        -- wrap text in parentheses with Alt+e
        ['<M-e>'] = { action = 'surround', pair = '()' },

        -- Only expand ( ... ) if *next* char is not a word
        ["("] = { action = "open", pair = "()", neigh_pattern = "[^\\w].[^\\w]" },
      },
    })
  end
} ]]

return {
  "echasnovski/mini.pairs",
  enabled = true,
  event = { "VeryLazy" },
  version = "*",
  opts = {
    -- In which modes mappings from this `config` should be created
    modes = { insert = true, command = false, terminal = false },

    -- Global mappings. Each right hand side should be a pair information, a
    -- table with at least these fields (see more in |MiniPairs.map|):
    -- - <action> - one of 'open', 'close', 'closeopen'.
    -- - <pair> - two character string for pair to be used.
    -- By default pair is not inserted after `\`, quotes are not recognized by
    -- `<CR>`, `'` does not insert pair after a letter.
    -- Only parts of tables can be tweaked (others will use these defaults).
    mappings = {
      [")"] = { action = "close", pair = "()", neigh_pattern = "[^\\]." },
      ["]"] = { action = "close", pair = "[]", neigh_pattern = "[^\\]." },
      ["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\]." },
      ["["] = {
        action = "open",
        pair = "[]",
        neigh_pattern = ".[%s%z%)}%]]",
        register = { cr = false },
        -- foo|bar -> press "[" -> foo[bar
        -- foobar| -> press "[" -> foobar[]
        -- |foobar -> press "[" -> [foobar
        -- | foobar -> press "[" -> [] foobar
        -- foobar | -> press "[" -> foobar []
        -- {|} -> press "[" -> {[]}
        -- (|) -> press "[" -> ([])
        -- [|] -> press "[" -> [[]]
      },
      ["{"] = {
        action = "open",
        pair = "{}",
        -- neigh_pattern = ".[%s%z%)}]",
        neigh_pattern = ".[%s%z%)}%]]",
        register = { cr = false },
        -- foo|bar -> press "{" -> foo{bar
        -- foobar| -> press "{" -> foobar{}
        -- |foobar -> press "{" -> {foobar
        -- | foobar -> press "{" -> {} foobar
        -- foobar | -> press "{" -> foobar {}
        -- (|) -> press "{" -> ({})
        -- {|} -> press "{" -> {{}}
      },
      ["("] = {
        action = "open",
        pair = "()",
        -- neigh_pattern = ".[%s%z]",
        neigh_pattern = ".[%s%z%)]",
        register = { cr = false },
        -- foo|bar -> press "(" -> foo(bar
        -- foobar| -> press "(" -> foobar()
        -- |foobar -> press "(" -> (foobar
        -- | foobar -> press "(" -> () foobar
        -- foobar | -> press "(" -> foobar ()
      },
      -- Single quote: Prevent pairing if either side is a letter
      ['"'] = {
        action = "closeopen",
        pair = '""',
        neigh_pattern = "[^%w\\][^%w]",
        register = { cr = false },
      },
      -- Single quote: Prevent pairing if either side is a letter
      ["'"] = {
        action = "closeopen",
        pair = "''",
        neigh_pattern = "[^%w\\][^%w]",
        register = { cr = false },
      },
      -- Backtick: Prevent pairing if either side is a letter
      ["`"] = {
        action = "closeopen",
        pair = "``",
        neigh_pattern = "[^%w\\][^%w]",
        register = { cr = false },
      },
    },
  },
}
